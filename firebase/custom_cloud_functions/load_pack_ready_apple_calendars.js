const { FieldValue, getFirestore } = require("firebase-admin/firestore");
const { HttpsError, onCall } = require("firebase-functions/v2/https");
const { createHash } = require("node:crypto");
const ical = require("node-ical");

const day = 86_400_000;
const maxFeeds = 12;
const maxBytes = 1_000_000;

function feedUrl(input) {
  if (typeof input !== "string" || input.length > 2048) return null;
  try {
    const url = new URL(input.trim().replace(/^webcal:/i, "https:"));
    return url.protocol === "https:" &&
      /^(?:p[0-9]{1,3}-)?(?:caldav|calendars)\.icloud\.com$/.test(
        url.hostname,
      ) &&
      /^\/published\/2\/[A-Za-z0-9_=-]+\/?$/.test(url.pathname) &&
      !url.username &&
      !url.password &&
      !url.port &&
      !url.search &&
      !url.hash
      ? url
      : null;
  } catch {
    return null;
  }
}

function field(value, limit = 240) {
  const text = typeof value === "string" ? value : value?.val;
  return typeof text === "string" ? text.trim().slice(0, limit) : "";
}

function calendarDay(value, timezone) {
  return new Intl.DateTimeFormat("en-CA", {
    timeZone: timezone || "UTC",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).format(value);
}

async function download(link) {
  const url = feedUrl(link);
  if (!url)
    throw new HttpsError(
      "invalid-argument",
      "Use a public iCloud Calendar link.",
    );
  let response;
  try {
    response = await fetch(url, {
      redirect: "error",
      signal: AbortSignal.timeout(12000),
    });
    if (!response.ok || !response.body) throw new Error("Feed unavailable");
    const chunks = [];
    let size = 0;
    for await (const chunk of response.body) {
      size += chunk.length;
      if (size > maxBytes) throw new Error("Feed exceeds size limit");
      chunks.push(chunk);
    }
    const text = Buffer.concat(chunks).toString("utf8").trimStart();
    if (!text.startsWith("BEGIN:VCALENDAR"))
      throw new Error("Not a calendar feed");
    return text;
  } catch {
    throw new HttpsError(
      "unavailable",
      "Could not read this iCloud calendar. Check that the link is public.",
    );
  }
}

function header(text, key) {
  const top = text.replace(/\r?\n[ \t]/g, "").split(/\r?\nBEGIN:VEVENT/i, 1)[0];
  const value = top.match(
    new RegExp(`^${key}(?:;[^:\\r\\n]*)?:(.*)$`, "mi"),
  )?.[1];
  return field(value)?.replace(/\\([,;\\])/g, "$1");
}

function source(doc) {
  const data = doc.data();
  return { id: doc.id, provider: "apple", name: data.name, color: data.color };
}

function disconnectSources(input) {
  if (!Array.isArray(input) || input.length === 0) {
    throw new HttpsError("invalid-argument", "Select calendars to disconnect.");
  }
  const sources = new Map();
  for (const item of input) {
    if (
      !item ||
      !["apple", "google", "demo"].includes(item.provider) ||
      typeof item.id !== "string" ||
      !item.id ||
      (item.provider === "apple" && !/^[0-9a-f]{24}$/.test(item.id)) ||
      (item.provider === "demo" && item.id !== "demo")
    ) {
      throw new HttpsError("invalid-argument", "Invalid calendar source.");
    }
    sources.set(item.provider + ":" + item.id, item);
  }
  return sources;
}

function linkedToSources(doc, sources) {
  const { calendarSource, calendarId, calendarEventKey } = doc.data();
  if (typeof calendarEventKey !== "string" || !calendarEventKey) return false;
  if (calendarSource === "demo") {
    return sources.has("demo:demo") && !doc.id.startsWith("calendar-demo-");
  }
  if (typeof calendarId === "string" && calendarId) {
    return sources.has(calendarSource + ":" + calendarId);
  }
  return [...sources.values()].some(
    ({ provider, id }) =>
      provider === calendarSource &&
      (calendarEventKey.startsWith(id + ":event:") ||
        calendarEventKey.startsWith(id + ":series:")),
  );
}

async function disconnect(user, feeds, data) {
  const sources = disconnectSources(data.sources);
  const providers = [
    ...new Set([...sources.values()].map((source) => source.provider)),
  ];
  const query = user
    .collection("packingLists")
    .where("calendarSource", "in", providers);
  if (data.operation === "disconnectPreview") {
    const snapshot = await query.get();
    return {
      count: snapshot.docs.filter((doc) => linkedToSources(doc, sources))
        .length,
    };
  }
  const remove = data.disposition === "remove";
  if (!remove && data.disposition !== "keep") {
    throw new HttpsError(
      "invalid-argument",
      "Choose what to do with linked activities.",
    );
  }
  if (remove && providers.includes("demo")) {
    throw new HttpsError(
      "invalid-argument",
      "Demo transitions keep user activities.",
    );
  }
  const apple = [...sources.values()].filter(
    (source) => source.provider === "apple",
  );
  const google = new Set(
    [...sources.values()]
      .filter((source) => source.provider === "google")
      .map((source) => source.id),
  );
  let more;
  do {
    more = await getFirestore().runTransaction(async (tx) => {
      const snapshot = await tx.get(query);
      const linked = snapshot.docs.filter((doc) =>
        linkedToSources(doc, sources),
      );
      const googleConnection =
        google.size && linked.length <= 400
          ? (await tx.get(user)).data()?.googleCalendarConnection
          : null;
      for (const doc of linked.slice(0, 400)) {
        if (remove) {
          tx.delete(doc.ref);
        } else {
          tx.update(doc.ref, {
            calendarSource: "packready",
            calendarId: FieldValue.delete(),
            calendarEventKey: FieldValue.delete(),
            calendarEventId: FieldValue.delete(),
            calendarEventTitle: FieldValue.delete(),
          });
        }
      }
      if (linked.length > 400) return true;
      for (const entry of apple) tx.delete(feeds.doc(entry.id));
      const preferences = Object.fromEntries(
        [...sources.keys()]
          .filter((key) => key !== "demo:demo")
          .map((key) => [key, FieldValue.delete()]),
      );
      const changes = {};
      if (Object.keys(preferences).length)
        changes.calendarSourceEnabled = preferences;
      if (Array.isArray(googleConnection?.sources)) {
        changes.googleCalendarConnection = {
          sources: googleConnection.sources.filter(
            (source) => !google.has(source.id),
          ),
        };
      }
      if (Object.keys(changes).length) {
        tx.set(user, changes, { merge: true });
      }
      return false;
    });
  } while (more);
  return { disconnected: true };
}

function normalize(text, calendar, from, to) {
  const output = [];
  const seen = new Map();
  for (const event of Object.values(ical.sync.parseICS(text))) {
    if (
      event.type !== "VEVENT" ||
      !event.uid ||
      !event.start ||
      event.status === "CANCELLED"
    )
      continue;
    const isRecurring = Boolean(event.rrule || event.recurrenceid);
    const instances = ical.expandRecurringEvent(event, {
      from,
      to,
      expandOngoing: true,
    });
    for (const instance of instances) {
      const details = instance.event ?? event;
      if (details.status === "CANCELLED") continue;
      const { start, end } = instance;
      if (!start) continue;
      const allDay = instance.isFullDay === true || start.dateOnly === true;
      const zone =
        allDay && start.dateOnly ? "UTC" : (start.tz ?? event.start.tz);
      const effectiveEnd =
        end && end > start
          ? end
          : new Date(start.getTime() + (allDay ? day : 3_600_000));
      const recurrence = instance.recurrenceId ?? event.recurrenceid ?? start;
      const recurrenceKey =
        typeof recurrence?.toISOString === "function"
          ? recurrence.toISOString()
          : String(recurrence);
      const id = isRecurring ? `${event.uid}@${recurrenceKey}` : event.uid;
      seen.set(id, {
        id,
        provider: "apple",
        calendarId: calendar.id,
        calendarName: calendar.name,
        title: field(instance.summary ?? details.summary) || "Untitled event",
        start: allDay ? calendarDay(start, zone) : start.toISOString(),
        end: allDay
          ? calendarDay(effectiveEnd, zone)
          : effectiveEnd.toISOString(),
        location: field(instance.location ?? details.location),
        notes: field(instance.description ?? details.description, 2500),
        allDay,
        seriesId: isRecurring ? event.uid : "",
      });
    }
  }
  for (const item of seen.values()) output.push(item);
  output.sort((a, b) => a.start.localeCompare(b.start));
  return output.slice(0, 2500);
}

exports.loadPackReadyAppleCalendars = onCall(
  {
    region: "us-central1",
    timeoutSeconds: 30,
    maxInstances: 3,
  },
  async ({ auth, data }) => {
    if (!auth)
      throw new HttpsError(
        "unauthenticated",
        "Sign in to use Apple calendars.",
      );
    const feeds = getFirestore()
      .collection("packReadyCalendarFeedSecrets")
      .doc(auth.uid)
      .collection("feeds");
    if (
      data?.operation === "disconnectPreview" ||
      data?.operation === "disconnect"
    ) {
      const user = getFirestore().collection("users").doc(auth.uid);
      return disconnect(user, feeds, data);
    }
    if (data?.operation === "list") {
      return {
        sources: (await feeds.orderBy("name").limit(maxFeeds).get()).docs.map(
          source,
        ),
      };
    }
    if (data?.operation === "add") {
      const url = feedUrl(data.link);
      if (!url)
        throw new HttpsError(
          "invalid-argument",
          "Paste a public iCloud Calendar link.",
        );
      const text = await download(url.href);
      const id = createHash("sha256")
        .update(url.href.replace(/\/$/, ""))
        .digest("hex")
        .slice(0, 24);
      const name =
        field(data.name, 100) ||
        header(text, "X-WR-CALNAME") ||
        "Apple Calendar";
      const color =
        [data.color, header(text, "X-APPLE-CALENDAR-COLOR")]
          .find(
            (v) =>
              typeof v === "string" &&
              /^#[0-9a-f]{6}(?:[0-9a-f]{2})?$/i.test(v),
          )
          ?.slice(0, 7) || "#8BADD8";
      await getFirestore().runTransaction(async (tx) => {
        const existing = await tx.get(feeds.limit(maxFeeds));
        if (
          existing.size >= maxFeeds &&
          !existing.docs.some((doc) => doc.id === id)
        ) {
          throw new HttpsError(
            "resource-exhausted",
            "This account has reached the Apple calendar limit.",
          );
        }
        tx.set(feeds.doc(id), { link: url.href, name, color });
      });
      return { source: { id, provider: "apple", name, color } };
    }
    if (
      data?.operation !== "events" ||
      !Array.isArray(data.ids) ||
      data.ids.length > maxFeeds ||
      data.ids.some(
        (id) => typeof id !== "string" || !/^[0-9a-f]{24}$/.test(id),
      )
    ) {
      throw new HttpsError("invalid-argument", "Select saved Apple calendars.");
    }
    let from;
    let to;
    if (typeof data.from === "string" && typeof data.to === "string") {
      const startMs = Date.parse(data.from);
      const endMs = Date.parse(data.to);
      if (
        !Number.isFinite(startMs) ||
        !Number.isFinite(endMs) ||
        endMs <= startMs ||
        endMs - startMs > 460 * day
      ) {
        throw new HttpsError("invalid-argument", "Invalid calendar range.");
      }
      from = new Date(startMs);
      to = new Date(endMs);
    } else {
      const anchor = Date.parse(data.anchor);
      if (!Number.isFinite(anchor))
        throw new HttpsError("invalid-argument", "Invalid calendar date.");
      from = new Date(anchor - 30 * day);
      to = new Date(anchor + 60 * day);
    }
    const results = await Promise.allSettled(
      [...new Set(data.ids)].map(async (id) => {
        const doc = await feeds.doc(id).get();
        if (!doc.exists) return [];
        return normalize(
          await download(doc.data().link),
          source(doc),
          from,
          to,
        );
      }),
    );
    return {
      events: results.flatMap((result) =>
        result.status === "fulfilled" ? result.value : [],
      ),
      failed: results.filter((result) => result.status === "rejected").length,
    };
  },
);

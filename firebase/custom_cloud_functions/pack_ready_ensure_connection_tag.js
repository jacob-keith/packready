const crypto = require("crypto");
const { getAuth } = require("firebase-admin/auth");
const { getFirestore } = require("firebase-admin/firestore");
const { onCall, HttpsError } = require("firebase-functions/v2/https");

const TAG_PATTERN = /^[^#/\x00-\x1f\x7f]{1,80}#[0-9]{4}$/u;
const RESERVED_DEMO_KEYS = new Set([
  "maya#4829",
  "jordan#7316",
  "avery#3051",
  "casey#6140",
]);

function isValidTag(value) {
  return (
    typeof value === "string" &&
    TAG_PATTERN.test(value) &&
    !RESERVED_DEMO_KEYS.has(value.toLowerCase())
  );
}

function cleanDisplayName(raw) {
  if (typeof raw !== "string") return "";
  const cleaned = raw.replace(/[#/\x00-\x1f\x7f]/g, " ").trim();
  if (!cleaned) return "";
  return Array.from(cleaned).slice(0, 80).join("").trimEnd();
}

function emailLocalPart(email) {
  if (typeof email !== "string") return "";
  const at = email.indexOf("@");
  return at > 0 ? email.slice(0, at) : email;
}

exports.packReadyEnsureConnectionTag = onCall(
  {
    region: "us-central1",
    memory: "256MiB",
    timeoutSeconds: 30,
    maxInstances: 10,
  },
  async (request) => {
    const uid = request.auth?.uid;
    if (!uid) {
      throw new HttpsError(
        "unauthenticated",
        "Sign in to access your connection tag.",
      );
    }

    const db = getFirestore();
    const profileRef = db.collection("users").doc(uid);
    const handlesCol = db.collection("connection_handles");

    const clientFallback =
      typeof request.data?.fallbackName === "string"
        ? request.data.fallbackName.trim()
        : "";

    let authFallback = "";
    try {
      const userRecord = await getAuth().getUser(uid);
      authFallback =
        cleanDisplayName(userRecord.displayName) ||
        cleanDisplayName(emailLocalPart(userRecord.email));
    } catch (_) {
      authFallback = cleanDisplayName(
        emailLocalPart(request.auth?.token?.email),
      );
    }

    const start = crypto.randomInt(10000);
    const maxAttempts = 64;

    for (let offset = 0; offset < maxAttempts; offset++) {
      const code = String((start + offset) % 10000).padStart(4, "0");
      const reserved = await db.runTransaction(async (tx) => {
        const profileSnap = await tx.get(profileRef);
        const data = profileSnap.exists ? profileSnap.data() : null;
        const existing =
          typeof data?.connectionTag === "string"
            ? data.connectionTag.trim()
            : "";

        if (isValidTag(existing)) {
          const existingKey = existing.toLowerCase();
          const existingHandleRef = handlesCol.doc(existingKey);
          const existingHandleSnap = await tx.get(existingHandleRef);
          if (!existingHandleSnap.exists) {
            tx.set(existingHandleRef, { uid, handle: existing });
          }
          return existing;
        }

        const name =
          cleanDisplayName(data?.display_name) ||
          cleanDisplayName(clientFallback) ||
          authFallback ||
          "PackReady";
        const tag = `${name}#${code}`;
        const key = tag.toLowerCase();
        if (RESERVED_DEMO_KEYS.has(key)) return null;

        const handleRef = handlesCol.doc(key);
        const handleSnap = await tx.get(handleRef);
        if (handleSnap.exists && handleSnap.get("uid") !== uid) {
          return null;
        }

        tx.set(handleRef, { uid, handle: tag });
        tx.set(profileRef, { connectionTag: tag }, { merge: true });
        return tag;
      });

      if (reserved) {
        return { tag: reserved };
      }
    }

    throw new HttpsError(
      "resource-exhausted",
      "Could not reserve a unique connection tag. Please try again.",
    );
  },
);

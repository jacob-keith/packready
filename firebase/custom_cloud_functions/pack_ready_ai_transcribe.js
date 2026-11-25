const { onCall, HttpsError } = require("firebase-functions/v2/https");

const maxBytes = 44 + 180 * 16000 * 2;
const unavailable =
  "Voice transcription is temporarily unavailable. Try again.";

exports.packReadyAiTranscribe = onCall(
  { region: "us-central1", timeoutSeconds: 60, concurrency: 4 },
  async ({ auth, data }) => {
    if (!auth)
      throw new HttpsError("unauthenticated", "Sign in to record a prompt.");

    const encoded = data?.audio;
    if (
      typeof encoded !== "string" ||
      encoded.length > Math.ceil(maxBytes / 3) * 4
    ) {
      throw new HttpsError(
        "invalid-argument",
        "Record up to three minutes of audio.",
      );
    }
    const audio = Buffer.from(encoded, "base64");
    if (
      audio.length <= 44 ||
      audio.length > maxBytes ||
      audio.length % 2 !== 0 ||
      audio.toString("ascii", 0, 4) !== "RIFF" ||
      audio.readUInt32LE(4) !== audio.length - 8 ||
      audio.toString("ascii", 8, 16) !== "WAVEfmt " ||
      audio.readUInt32LE(16) !== 16 ||
      audio.readUInt16LE(20) !== 1 ||
      audio.readUInt16LE(22) !== 1 ||
      audio.readUInt32LE(24) !== 16000 ||
      audio.readUInt32LE(28) !== 32000 ||
      audio.readUInt16LE(32) !== 2 ||
      audio.readUInt16LE(34) !== 16 ||
      audio.toString("ascii", 36, 40) !== "data" ||
      audio.readUInt32LE(40) !== audio.length - 44
    ) {
      throw new HttpsError(
        "invalid-argument",
        "The recording could not be read. Try again.",
      );
    }

    const apiKey = process.env.GROQ_API_KEY;
    if (!apiKey) throw new HttpsError("failed-precondition", unavailable);
    const form = new FormData();
    form.set("file", new Blob([audio], { type: "audio/wav" }), "prompt.wav");
    form.set("model", "whisper-large-v3-turbo");
    form.set("response_format", "json");

    try {
      const response = await fetch(
        "https://api.groq.com/openai/v1/audio/transcriptions",
        {
          method: "POST",
          headers: { Authorization: `Bearer ${apiKey}` },
          signal: AbortSignal.timeout(45000),
          body: form,
        },
      );
      if (!response.ok) {
        console.warn("PackReady transcription request failed", {
          status: response.status,
        });
        throw new HttpsError("unavailable", unavailable);
      }
      const result = await response.json();
      if (typeof result.text !== "string")
        throw new HttpsError("unavailable", unavailable);
      return { text: result.text.trim() };
    } catch (error) {
      if (error instanceof HttpsError) throw error;
      throw new HttpsError("unavailable", unavailable);
    }
  },
);

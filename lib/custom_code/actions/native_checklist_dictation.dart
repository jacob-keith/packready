// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/app_events/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;
import 'package:record/record.dart';

const _maxSeconds = 180;
const _sampleRate = 16000;
const _maxBytes = _maxSeconds * _sampleRate * 2;
final _voice = Expando<_ChecklistVoice>();

class _ChecklistVoice {
  _ChecklistVoice(this.context, this.owner);
  final BuildContext context;
  final String owner;
  final recorder = AudioRecorder();
  final bytes = BytesBuilder();
  final result = Completer<String>();
  StreamSubscription? auth;
  StreamSubscription<Uint8List>? audio;
  Timer? deadline;
  String phase = 'opening';

  void setPhase(String next) {
    phase = next;
    FFAppState().update(() => FFAppState().nativeChecklistVoicePhase = next);
  }

  bool get current =>
      !result.isCompleted &&
      context.mounted &&
      FirebaseAuth.instance.currentUser?.uid == owner;

  void finish({String transcript = '', String? error}) {
    if (result.isCompleted) return;
    deadline?.cancel();
    auth?.cancel();
    audio?.cancel();
    unawaited(recorder.dispose().catchError((Object _) {}));
    setPhase('');
    if (error != null && context.mounted) _voiceError(context, error);
    result.complete(transcript);
  }

  Future<void> begin() async {
    try {
      if (!await recorder.hasPermission()) {
        finish(error: 'Allow microphone access to record a prompt.');
        return;
      }
      if (!current) return;
      final stream = await recorder.startStream(
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: _sampleRate,
          numChannels: 1,
        ),
      );
      if (!current) return;
      audio = stream.listen((chunk) {
        final remaining = _maxBytes - bytes.length;
        if (remaining <= 0) return;
        bytes.add(
          chunk.length <= remaining
              ? chunk
              : Uint8List.sublistView(chunk, 0, remaining),
        );
        if (bytes.length == _maxBytes) unawaited(stop());
      });
      setPhase('recording');
      deadline = Timer(
        const Duration(seconds: _maxSeconds),
        () => unawaited(stop()),
      );
    } catch (_) {
      finish(
        error: 'Could not start the microphone. Check access and try again.',
      );
    }
  }

  Future<void> stop() async {
    if (!current || phase != 'recording') return;
    deadline?.cancel();
    setPhase('transcribing');
    try {
      await recorder.stop();
      if (!current) return;
      final samples = bytes.takeBytes();
      if (samples.isEmpty) {
        finish(error: 'No audio was recorded. Try again.');
        return;
      }
      final response = await FirebaseFunctions.instanceFor(
        region: 'us-central1',
      ).httpsCallable('packReadyAiTranscribe').call<Map<String, dynamic>>({
        'audio': base64Encode(_voiceWav(samples)),
      });
      if (!current) return;
      final text = (response.data['text'] as String).trim();
      if (text.isEmpty) {
        finish(error: 'No speech was detected. Try again.');
      } else {
        finish(transcript: text);
      }
    } on FirebaseFunctionsException catch (error) {
      finish(
        error:
            error.message ?? 'Could not transcribe the recording. Try again.',
      );
    } catch (_) {
      finish(error: 'Could not transcribe the recording. Try again.');
    }
  }
}

void _voiceError(BuildContext context, String message) {
  ScaffoldMessenger.maybeOf(
    context,
  )?.showSnackBar(SnackBar(content: Text(message)));
}

Future<String> nativeChecklistDictation(BuildContext context, bool stop) async {
  final lifetime = ModalRoute.of(context);
  if (lifetime == null) return '';
  final prior = _voice[lifetime];
  if (stop) {
    if (prior != null) await prior.stop();
    return '';
  }
  if (prior != null) return '';
  if (!kIsWeb && defaultTargetPlatform != TargetPlatform.android) {
    _voiceError(context, 'Voice dictation is available on Android and web.');
    return '';
  }
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) {
    _voiceError(context, 'Sign in to record a prompt.');
    return '';
  }
  FocusScope.of(context).unfocus();
  final capture = _ChecklistVoice(context, uid);
  _voice[lifetime] = capture;
  capture.setPhase('opening');
  capture.auth = FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user?.uid != uid) capture.finish();
  });
  unawaited(lifetime.popped.then((_) => capture.finish()));
  unawaited(capture.begin());
  final transcript = await capture.result.future;
  if (identical(_voice[lifetime], capture)) _voice[lifetime] = null;
  return transcript;
}

Uint8List _voiceWav(Uint8List samples) {
  final wav = Uint8List(44 + samples.length);
  final header = ByteData.sublistView(wav);
  wav.setRange(0, 4, ascii.encode('RIFF'));
  header.setUint32(4, wav.length - 8, Endian.little);
  wav.setRange(8, 16, ascii.encode('WAVEfmt '));
  header.setUint32(16, 16, Endian.little);
  header.setUint16(20, 1, Endian.little); // PCM
  header.setUint16(22, 1, Endian.little); // Mono
  header.setUint32(24, _sampleRate, Endian.little);
  header.setUint32(28, _sampleRate * 2, Endian.little);
  header.setUint16(32, 2, Endian.little);
  header.setUint16(34, 16, Endian.little);
  wav.setRange(36, 40, ascii.encode('data'));
  header.setUint32(40, samples.length, Endian.little);
  wav.setRange(44, wav.length, samples);
  return wav;
}

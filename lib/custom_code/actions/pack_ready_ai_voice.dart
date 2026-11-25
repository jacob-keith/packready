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

// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'package:flutter/material.dart';
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
_AiVoiceCapture? _capture;

Future<PackReadyAiVoiceResultStruct> packReadyAiVoice(
  BuildContext context,
  bool stop,
) async {
  if (!kIsWeb && defaultTargetPlatform != TargetPlatform.android) {
    return PackReadyAiVoiceResultStruct();
  }
  if (stop) {
    if (_capture?.context == context) await _capture?.stop();
    return PackReadyAiVoiceResultStruct();
  }

  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) {
    return PackReadyAiVoiceResultStruct(error: 'Sign in to record a prompt.');
  }
  if (_capture != null) {
    if (_capture!.active) return PackReadyAiVoiceResultStruct();
    await _capture!.finish();
  }
  if (!context.mounted) return PackReadyAiVoiceResultStruct();
  FocusScope.of(context).unfocus();
  final capture = _capture = _AiVoiceCapture(context, uid);
  await capture.start();
  return capture.result.future;
}

class _AiVoiceCapture {
  _AiVoiceCapture(this.context, this.uid);

  final BuildContext context;
  final String uid;
  final recorder = AudioRecorder();
  final bytes = BytesBuilder();
  final result = Completer<PackReadyAiVoiceResultStruct>();
  Timer? timer;
  StreamSubscription? auth;
  String phase = 'opening';
  bool finishing = false;

  bool get active =>
      !finishing &&
      _capture == this &&
      context.mounted &&
      FirebaseAuth.instance.currentUser?.uid == uid;

  void setPhase(String value) {
    phase = value;
    FFAppState().update(() => FFAppState().packReadyAiVoicePhase = value);
  }

  Future<void> start() async {
    setPhase('opening');
    auth = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user?.uid != uid) unawaited(finish());
    });
    try {
      final allowed = await recorder.hasPermission();
      if (!active) return finish();
      if (!allowed) {
        return finish(error: 'Allow microphone access to record a prompt.');
      }
      final stream = await recorder.startStream(
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: _sampleRate,
          numChannels: 1,
        ),
      );
      if (!active) return finish();
      setPhase('recording');
      stream.listen(
        (chunk) {
          final remaining = _maxBytes - bytes.length;
          if (!active || remaining <= 0) return;
          bytes.add(
            chunk.length <= remaining
                ? chunk
                : Uint8List.sublistView(chunk, 0, remaining),
          );
          if (bytes.length == _maxBytes) unawaited(stop());
        },
        onError: (Object _) {
          unawaited(finish(error: 'The recording was interrupted. Try again.'));
        },
      );

      final deadline = DateTime.now().add(const Duration(seconds: _maxSeconds));
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!active) {
          unawaited(finish());
        } else if (!DateTime.now().isBefore(deadline)) {
          unawaited(stop());
        }
      });
    } catch (_) {
      await finish(
        error: 'Could not start the microphone. Check access and try again.',
      );
    }
  }

  Future<void> stop() async {
    if (!active || phase != 'recording') return;
    timer?.cancel();
    setPhase('transcribing');
    try {
      await recorder.stop();
      if (!active) return finish();
      final samples = bytes.takeBytes();
      if (samples.isEmpty)
        return finish(error: 'No audio was recorded. Try again.');
      final response = await FirebaseFunctions.instanceFor(
        region: 'us-central1',
      ).httpsCallable('packReadyAiTranscribe').call<Map<String, dynamic>>({
        'audio': base64Encode(_wav(samples)),
      });
      if (!active) return finish();
      final text = (response.data['text'] as String).trim();
      if (text.isEmpty)
        return finish(error: 'No speech was detected. Try again.');
      await finish(text: text);
    } on FirebaseFunctionsException catch (failure) {
      await finish(
        error:
            failure.message ?? 'Could not transcribe the recording. Try again.',
      );
    } catch (_) {
      await finish(error: 'Could not transcribe the recording. Try again.');
    }
  }

  Future<void> finish({String? text, String? error}) async {
    if (finishing) return;
    final deliver = active;
    finishing = true;
    timer?.cancel();
    await auth?.cancel();
    try {
      await recorder.dispose();
    } catch (_) {
      // A revoked device may close the recorder before disposal.
    }
    if (_capture == this) {
      _capture = null;
      setPhase('idle');
    }
    result.complete(
      PackReadyAiVoiceResultStruct(
        transcript: deliver ? text : null,
        error: deliver ? error : null,
      ),
    );
  }
}

Uint8List _wav(Uint8List samples) {
  final wav = Uint8List(44 + samples.length);
  final header = ByteData.sublistView(wav);
  wav.setRange(0, 4, ascii.encode('RIFF'));
  header.setUint32(4, wav.length - 8, Endian.little);
  wav.setRange(8, 16, ascii.encode('WAVEfmt '));
  header.setUint32(16, 16, Endian.little);
  header.setUint16(20, 1, Endian.little);
  header.setUint16(22, 1, Endian.little);
  header.setUint32(24, _sampleRate, Endian.little);
  header.setUint32(28, _sampleRate * 2, Endian.little);
  header.setUint16(32, 2, Endian.little);
  header.setUint16(34, 16, Endian.little);
  wav.setRange(36, 40, ascii.encode('data'));
  header.setUint32(40, samples.length, Endian.little);
  wav.setRange(44, wav.length, samples);
  return wav;
}

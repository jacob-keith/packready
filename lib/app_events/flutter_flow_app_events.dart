// ignore_for_file: constant_identifier_names

import '/backend/schema/structs/index.dart';

/// Scope of where the event is being handled
enum FFAppEventScope {
  /// Event is being handled in the global scope
  GLOBAL,

  /// Event is being handled in the local scope
  LOCAL,
}

/// Base event class that all specific events inherit from
abstract class FFAppEvent {
  final DateTime timestamp;
  final String? debugId;
  final bool waitForCompletion;
  final FFAppEventScope scope;

  const FFAppEvent({
    required this.timestamp,
    required this.scope,
    this.debugId,
    this.waitForCompletion = true,
  });
}

/// Updates the Home checklist and date highlight.
class HomeTripSelectedEvent extends FFAppEvent {
  /// Structured data associated with HomeTripSelectedEvent
  final HomeTripSelectionStruct data;

  const HomeTripSelectedEvent({
    required this.data,
    super.debugId,
    super.waitForCompletion = true,
    required super.timestamp,
  }) : super(
          scope: FFAppEventScope.LOCAL,
        );
}

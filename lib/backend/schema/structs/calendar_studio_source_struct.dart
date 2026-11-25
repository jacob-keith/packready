// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct CalendarStudioSource
class CalendarStudioSourceStruct extends FFFirebaseStruct {
  CalendarStudioSourceStruct({
    /// CalendarStudioSource.sourceKey
    String? sourceKey,

    /// CalendarStudioSource.name
    String? name,

    /// CalendarStudioSource.provider
    String? provider,

    /// CalendarStudioSource.enabled
    bool? enabled,

    /// CalendarStudioSource.removable
    bool? removable,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _sourceKey = sourceKey,
        _name = name,
        _provider = provider,
        _enabled = enabled,
        _removable = removable,
        super(firestoreUtilData);

  // "sourceKey" field.
  String? _sourceKey;
  String get sourceKey => _sourceKey ?? '';
  set sourceKey(String? val) => _sourceKey = val;

  bool hasSourceKey() => _sourceKey != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "provider" field.
  String? _provider;
  String get provider => _provider ?? '';
  set provider(String? val) => _provider = val;

  bool hasProvider() => _provider != null;

  // "enabled" field.
  bool? _enabled;
  bool get enabled => _enabled ?? false;
  set enabled(bool? val) => _enabled = val;

  bool hasEnabled() => _enabled != null;

  // "removable" field.
  bool? _removable;
  bool get removable => _removable ?? false;
  set removable(bool? val) => _removable = val;

  bool hasRemovable() => _removable != null;

  static CalendarStudioSourceStruct fromMap(Map<String, dynamic> data) =>
      CalendarStudioSourceStruct(
        sourceKey: data['sourceKey'] as String?,
        name: data['name'] as String?,
        provider: data['provider'] as String?,
        enabled: data['enabled'] as bool?,
        removable: data['removable'] as bool?,
      );

  static CalendarStudioSourceStruct? maybeFromMap(dynamic data) => data is Map
      ? CalendarStudioSourceStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'sourceKey': _sourceKey,
        'name': _name,
        'provider': _provider,
        'enabled': _enabled,
        'removable': _removable,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'sourceKey': serializeParam(
          _sourceKey,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'provider': serializeParam(
          _provider,
          ParamType.String,
        ),
        'enabled': serializeParam(
          _enabled,
          ParamType.bool,
        ),
        'removable': serializeParam(
          _removable,
          ParamType.bool,
        ),
      }.withoutNulls;

  static CalendarStudioSourceStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      CalendarStudioSourceStruct(
        sourceKey: deserializeParam(
          data['sourceKey'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        provider: deserializeParam(
          data['provider'],
          ParamType.String,
          false,
        ),
        enabled: deserializeParam(
          data['enabled'],
          ParamType.bool,
          false,
        ),
        removable: deserializeParam(
          data['removable'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'CalendarStudioSourceStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CalendarStudioSourceStruct &&
        sourceKey == other.sourceKey &&
        name == other.name &&
        provider == other.provider &&
        enabled == other.enabled &&
        removable == other.removable;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([sourceKey, name, provider, enabled, removable]);
}

CalendarStudioSourceStruct createCalendarStudioSourceStruct({
  String? sourceKey,
  String? name,
  String? provider,
  bool? enabled,
  bool? removable,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CalendarStudioSourceStruct(
      sourceKey: sourceKey,
      name: name,
      provider: provider,
      enabled: enabled,
      removable: removable,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CalendarStudioSourceStruct? updateCalendarStudioSourceStruct(
  CalendarStudioSourceStruct? calendarStudioSource, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    calendarStudioSource
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCalendarStudioSourceStructData(
  Map<String, dynamic> firestoreData,
  CalendarStudioSourceStruct? calendarStudioSource,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (calendarStudioSource == null) {
    return;
  }
  if (calendarStudioSource.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && calendarStudioSource.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final calendarStudioSourceData =
      getCalendarStudioSourceFirestoreData(calendarStudioSource, forFieldValue);
  final nestedData =
      calendarStudioSourceData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      calendarStudioSource.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCalendarStudioSourceFirestoreData(
  CalendarStudioSourceStruct? calendarStudioSource, [
  bool forFieldValue = false,
]) {
  if (calendarStudioSource == null) {
    return {};
  }
  final firestoreData = mapToFirestore(calendarStudioSource.toMap());

  // Add any Firestore field values
  mapToFirestore(calendarStudioSource.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCalendarStudioSourceListFirestoreData(
  List<CalendarStudioSourceStruct>? calendarStudioSources,
) =>
    calendarStudioSources
        ?.map((e) => getCalendarStudioSourceFirestoreData(e, true))
        .toList() ??
    [];

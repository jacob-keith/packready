// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct HomeForecast
class HomeForecastStruct extends FFFirebaseStruct {
  HomeForecastStruct({
    /// HomeForecast.temperature
    String? temperature,

    /// HomeForecast.condition
    String? condition,

    /// HomeForecast.location
    String? location,

    /// HomeForecast.wmoCode
    int? wmoCode,

    /// HomeForecast.windMph
    double? windMph,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _temperature = temperature,
        _condition = condition,
        _location = location,
        _wmoCode = wmoCode,
        _windMph = windMph,
        super(firestoreUtilData);

  // "temperature" field.
  String? _temperature;
  String get temperature => _temperature ?? '';
  set temperature(String? val) => _temperature = val;

  bool hasTemperature() => _temperature != null;

  // "condition" field.
  String? _condition;
  String get condition => _condition ?? '';
  set condition(String? val) => _condition = val;

  bool hasCondition() => _condition != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  set location(String? val) => _location = val;

  bool hasLocation() => _location != null;

  // "wmoCode" field.
  int? _wmoCode;
  int get wmoCode => _wmoCode ?? 0;
  set wmoCode(int? val) => _wmoCode = val;

  void incrementWmoCode(int amount) => wmoCode = wmoCode + amount;

  bool hasWmoCode() => _wmoCode != null;

  // "windMph" field.
  double? _windMph;
  double get windMph => _windMph ?? 0.0;
  set windMph(double? val) => _windMph = val;

  void incrementWindMph(double amount) => windMph = windMph + amount;

  bool hasWindMph() => _windMph != null;

  static HomeForecastStruct fromMap(Map<String, dynamic> data) =>
      HomeForecastStruct(
        temperature: data['temperature'] as String?,
        condition: data['condition'] as String?,
        location: data['location'] as String?,
        wmoCode: castToType<int>(data['wmoCode']),
        windMph: castToType<double>(data['windMph']),
      );

  static HomeForecastStruct? maybeFromMap(dynamic data) => data is Map
      ? HomeForecastStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'temperature': _temperature,
        'condition': _condition,
        'location': _location,
        'wmoCode': _wmoCode,
        'windMph': _windMph,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'temperature': serializeParam(
          _temperature,
          ParamType.String,
        ),
        'condition': serializeParam(
          _condition,
          ParamType.String,
        ),
        'location': serializeParam(
          _location,
          ParamType.String,
        ),
        'wmoCode': serializeParam(
          _wmoCode,
          ParamType.int,
        ),
        'windMph': serializeParam(
          _windMph,
          ParamType.double,
        ),
      }.withoutNulls;

  static HomeForecastStruct fromSerializableMap(Map<String, dynamic> data) =>
      HomeForecastStruct(
        temperature: deserializeParam(
          data['temperature'],
          ParamType.String,
          false,
        ),
        condition: deserializeParam(
          data['condition'],
          ParamType.String,
          false,
        ),
        location: deserializeParam(
          data['location'],
          ParamType.String,
          false,
        ),
        wmoCode: deserializeParam(
          data['wmoCode'],
          ParamType.int,
          false,
        ),
        windMph: deserializeParam(
          data['windMph'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'HomeForecastStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is HomeForecastStruct &&
        temperature == other.temperature &&
        condition == other.condition &&
        location == other.location &&
        wmoCode == other.wmoCode &&
        windMph == other.windMph;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([temperature, condition, location, wmoCode, windMph]);
}

HomeForecastStruct createHomeForecastStruct({
  String? temperature,
  String? condition,
  String? location,
  int? wmoCode,
  double? windMph,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    HomeForecastStruct(
      temperature: temperature,
      condition: condition,
      location: location,
      wmoCode: wmoCode,
      windMph: windMph,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

HomeForecastStruct? updateHomeForecastStruct(
  HomeForecastStruct? homeForecast, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    homeForecast
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addHomeForecastStructData(
  Map<String, dynamic> firestoreData,
  HomeForecastStruct? homeForecast,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (homeForecast == null) {
    return;
  }
  if (homeForecast.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && homeForecast.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final homeForecastData =
      getHomeForecastFirestoreData(homeForecast, forFieldValue);
  final nestedData =
      homeForecastData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = homeForecast.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getHomeForecastFirestoreData(
  HomeForecastStruct? homeForecast, [
  bool forFieldValue = false,
]) {
  if (homeForecast == null) {
    return {};
  }
  final firestoreData = mapToFirestore(homeForecast.toMap());

  // Add any Firestore field values
  mapToFirestore(homeForecast.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getHomeForecastListFirestoreData(
  List<HomeForecastStruct>? homeForecasts,
) =>
    homeForecasts?.map((e) => getHomeForecastFirestoreData(e, true)).toList() ??
    [];

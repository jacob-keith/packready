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
import '/backend/schema/structs/index.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

Future<CityLookupResultStruct> currentCityAndCountry(
    BuildContext context) async {
  CityLookupResultStruct failure(String step, String detail) =>
      CityLookupResultStruct(
        message: 'Location unavailable. $detail',
        retryLabel: 'Try again · $step',
      );
  const permissionStep = 'Location permission';
  const coordinatesStep = 'Getting coordinates';
  const lookupStep = 'BigDataCloud city lookup';

  try {
    var permission = await Geolocator.checkPermission();
    // On web the position request prompts and preserves the browser's error code.
    if (!kIsWeb && permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if ((!kIsWeb && permission == LocationPermission.denied) ||
        permission == LocationPermission.deniedForever) {
      return failure(permissionStep, 'Location access was denied.');
    }
  } catch (_) {
    // A browser can provide coordinates even when it cannot query permission.
    if (!kIsWeb)
      return failure(permissionStep, 'Could not check location access.');
  }

  final Position position;
  try {
    position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.low,
        timeLimit: Duration(seconds: 25),
      ),
    );
  } on PermissionDeniedException {
    return failure(permissionStep, 'Location access was blocked.');
  } on TimeoutException {
    return failure(
        coordinatesStep, 'The device took too long to return a position.');
  } catch (_) {
    return failure(coordinatesStep, 'The device could not provide a position.');
  }

  try {
    final uri =
        Uri.https('api.bigdatacloud.net', '/data/reverse-geocode-client', {
      'latitude': position.latitude.toStringAsFixed(3),
      'longitude': position.longitude.toStringAsFixed(3),
      'localityLanguage': 'en',
    });
    final response = await http.get(uri).timeout(const Duration(seconds: 12));
    if (response.statusCode != 200) {
      return failure(
          lookupStep, 'BigDataCloud returned HTTP ${response.statusCode}.');
    }

    final data =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    final city = (data['city'] as String?)?.trim() ?? '';
    final locality =
        city.isEmpty ? (data['locality'] as String?)?.trim() ?? '' : city;
    final country = (data['countryName'] as String?)?.trim() ?? '';
    if (locality.isEmpty || country.isEmpty) {
      return failure(
          lookupStep, 'The city lookup returned an incomplete place name.');
    }
    return CityLookupResultStruct(
        message: '$locality, $country', retryLabel: '');
  } on TimeoutException {
    return failure(lookupStep, 'The city lookup timed out.');
  } on http.ClientException {
    return failure(lookupStep, 'Could not reach BigDataCloud.');
  } catch (_) {
    return failure(lookupStep, 'Could not read the city lookup response.');
  }
}

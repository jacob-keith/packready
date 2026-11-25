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

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<HomeForecastStruct> loadHomeForecast(
  DateTime date,
  bool allDay,
  String destination,
  String homeCity,
) async {
  final result = await PackReadyWeatherService.resolve(
    date: date,
    allDay: allDay,
    destination: destination,
    homeCity: homeCity,
  );
  if (result == null) return HomeForecastStruct();
  return HomeForecastStruct(
    temperature: '${result.tempF}\u00B0F',
    condition: result.conditionLabel,
    location: result.locationLabel,
    wmoCode: result.wmoCode,
    windMph: result.windSpeedMph,
  );
}

const double kPackReadyWindyMphThreshold = 18.0;

String packReadyShortWeatherLabel(int wmoCode, {double? windSpeedMph}) {
  final windy = (windSpeedMph ?? 0) >= kPackReadyWindyMphThreshold;
  switch (wmoCode) {
    case 0:
      return windy ? 'Windy' : 'Sunny';
    case 1:
      return windy ? 'Windy' : 'Mostly Clear';
    case 2:
      return windy ? 'Windy' : 'Partly Cloudy';
    case 3:
      return windy ? 'Windy' : 'Overcast';
    case 45:
      return 'Fog';
    case 48:
      return 'Rime Fog';
    case 51:
    case 53:
    case 55:
      return 'Drizzle';
    case 56:
    case 57:
      return 'Sleet';
    case 61:
      return 'Light Rain';
    case 63:
      return 'Rain';
    case 65:
      return 'Heavy Rain';
    case 66:
    case 67:
      return 'Freezing Rain';
    case 71:
      return 'Light Snow';
    case 73:
      return 'Snow';
    case 75:
    case 86:
      return 'Heavy Snow';
    case 77:
      return 'Snow Grains';
    case 80:
      return 'Light Showers';
    case 81:
      return 'Showers';
    case 82:
      return 'Heavy Showers';
    case 85:
      return 'Snow Showers';
    case 95:
      return 'Thunderstorm';
    case 96:
      return 'Hailstorm';
    case 99:
      return 'Heavy Hail';
    default:
      return windy ? 'Windy' : 'Cloudy';
  }
}

class PackReadyDayWeather {
  const PackReadyDayWeather({
    required this.dateKey,
    required this.tempF,
    required this.wmoCode,
    required this.windSpeedMph,
    required this.locationLabel,
    required this.isLocalFallback,
  });

  final String dateKey;
  final int tempF;
  final int wmoCode;
  final double windSpeedMph;
  final String locationLabel;
  final bool isLocalFallback;

  String get conditionLabel =>
      packReadyShortWeatherLabel(wmoCode, windSpeedMph: windSpeedMph);
}

class _GeoPoint {
  const _GeoPoint({required this.lat, required this.lon, required this.label});

  final double lat;
  final double lon;
  final String label;
}

class _ForecastCacheEntry {
  const _ForecastCacheEntry({
    required this.fetchedAt,
    required this.days,
    required this.hourly,
  });

  final DateTime fetchedAt;
  final Map<String, _RawDayForecast> days;
  final Map<String, Map<int, _RawDayForecast>> hourly;
}

class _RawDayForecast {
  const _RawDayForecast({
    required this.tempF,
    required this.wmoCode,
    required this.windSpeedMph,
  });

  final int tempF;
  final int wmoCode;
  final double windSpeedMph;
}

class PackReadyWeatherService {
  PackReadyWeatherService._();

  // Default PackReady local coordinates (same default as existing WeatherCall).
  static const _defaultPoint = _GeoPoint(
    lat: 41.4804,
    lon: -71.5226,
    label: 'Local',
  );
  static const _cacheTtl = Duration(minutes: 30);

  static final Map<String, _GeoPoint?> _geoCache = {};
  static final Map<String, Future<_GeoPoint?>> _geoInFlight = {};
  static final Map<String, _ForecastCacheEntry> _forecastCache = {};
  static final Map<String, Future<_ForecastCacheEntry?>> _forecastInFlight = {};

  static const _usStates = <String, String>{
    'AL': 'Alabama',
    'AK': 'Alaska',
    'AZ': 'Arizona',
    'AR': 'Arkansas',
    'CA': 'California',
    'CO': 'Colorado',
    'CT': 'Connecticut',
    'DE': 'Delaware',
    'FL': 'Florida',
    'GA': 'Georgia',
    'HI': 'Hawaii',
    'ID': 'Idaho',
    'IL': 'Illinois',
    'IN': 'Indiana',
    'IA': 'Iowa',
    'KS': 'Kansas',
    'KY': 'Kentucky',
    'LA': 'Louisiana',
    'ME': 'Maine',
    'MD': 'Maryland',
    'MA': 'Massachusetts',
    'MI': 'Michigan',
    'MN': 'Minnesota',
    'MS': 'Mississippi',
    'MO': 'Missouri',
    'MT': 'Montana',
    'NE': 'Nebraska',
    'NV': 'Nevada',
    'NH': 'New Hampshire',
    'NJ': 'New Jersey',
    'NM': 'New Mexico',
    'NY': 'New York',
    'NC': 'North Carolina',
    'ND': 'North Dakota',
    'OH': 'Ohio',
    'OK': 'Oklahoma',
    'OR': 'Oregon',
    'PA': 'Pennsylvania',
    'RI': 'Rhode Island',
    'SC': 'South Carolina',
    'SD': 'South Dakota',
    'TN': 'Tennessee',
    'TX': 'Texas',
    'UT': 'Utah',
    'VT': 'Vermont',
    'VA': 'Virginia',
    'WA': 'Washington',
    'WV': 'West Virginia',
    'WI': 'Wisconsin',
    'WY': 'Wyoming',
    'DC': 'District of Columbia',
  };

  static String _ymd(int year, int month, int day) =>
      '${year.toString().padLeft(4, '0')}-'
      '${month.toString().padLeft(2, '0')}-'
      '${day.toString().padLeft(2, '0')}';

  static String dateKeyOf(DateTime date) {
    final local = date.toLocal();
    return _ymd(local.year, local.month, local.day);
  }

  static bool isWithinForecastWindow(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final local = date.toLocal();
    final target = DateTime(local.year, local.month, local.day);
    final diff = target.difference(today).inDays;
    return diff >= 0 && diff < 16;
  }

  static String _coordKey(_GeoPoint point) =>
      '${point.lat.toStringAsFixed(2)},${point.lon.toStringAsFixed(2)}';

  static String _cleanPlace(String? raw) =>
      (raw ?? '').trim().replaceAll(RegExp(r'\s+'), ' ');

  static _RawDayForecast? _pickForecast(
    _ForecastCacheEntry entry,
    DateTime date, {
    required bool allDay,
  }) {
    final key = dateKeyOf(date);
    if (!allDay) {
      final local = date.toLocal();
      final floor = DateTime.utc(
        local.year,
        local.month,
        local.day,
        local.hour,
      );
      final ceil = floor.add(const Duration(hours: 1));
      final primary = local.minute >= 30 ? ceil : floor;
      final secondary =
          local.minute == 0 ? null : (local.minute >= 30 ? floor : ceil);
      final primarySlot =
          entry.hourly[_ymd(primary.year, primary.month, primary.day)]
              ?[primary.hour];
      if (primarySlot != null) return primarySlot;
      if (secondary != null) {
        final secondarySlot = entry.hourly[_ymd(
          secondary.year,
          secondary.month,
          secondary.day,
        )]?[secondary.hour];
        if (secondarySlot != null) return secondarySlot;
      }
    }
    return entry.days[key];
  }

  /// Synchronously returns cached weather for a trip if already available.
  static PackReadyDayWeather? peek({
    required DateTime date,
    bool allDay = false,
    String? destination,
    String? homeCity,
  }) {
    if (!isWithinForecastWindow(date)) return null;
    final key = dateKeyOf(date);
    final dest = _cleanPlace(destination);
    final home = _cleanPlace(homeCity);

    _GeoPoint? point;
    var isLocal = true;
    if (dest.isNotEmpty) {
      if (!_geoCache.containsKey(dest.toLowerCase())) return null;
      final matched = _geoCache[dest.toLowerCase()];
      if (matched != null) {
        point = matched;
        isLocal = false;
      }
    }
    if (point == null && home.isNotEmpty) {
      if (!_geoCache.containsKey(home.toLowerCase())) return null;
      point = _geoCache[home.toLowerCase()];
    }
    point ??= _defaultPoint;

    final entry = _forecastCache[_coordKey(point)];
    if (entry == null ||
        DateTime.now().difference(entry.fetchedAt) > _cacheTtl) {
      return null;
    }
    final raw = _pickForecast(entry, date, allDay: allDay);
    if (raw == null) return null;
    return PackReadyDayWeather(
      dateKey: key,
      tempF: raw.tempF,
      wmoCode: raw.wmoCode,
      windSpeedMph: raw.windSpeedMph,
      locationLabel: isLocal ? 'Local' : point.label,
      isLocalFallback: isLocal,
    );
  }

  /// Resolves destination (cached Open-Meteo geocoding with local fallback)
  /// and fetches the 16-day Open-Meteo hourly + daily forecast including wind speed.
  static Future<PackReadyDayWeather?> resolve({
    required DateTime date,
    bool allDay = false,
    String? destination,
    String? homeCity,
  }) async {
    if (!isWithinForecastWindow(date)) return null;
    final key = dateKeyOf(date);
    final dest = _cleanPlace(destination);
    final home = _cleanPlace(homeCity);

    _GeoPoint? point;
    var isLocal = true;

    if (dest.isNotEmpty) {
      final matched = await _geocode(dest);
      if (matched != null) {
        point = matched;
        isLocal = false;
      }
    }
    if (point == null && home.isNotEmpty) {
      point = await _geocode(home);
    }
    point ??= _defaultPoint;

    final forecast = await _fetchForecast(point);
    final raw =
        forecast == null ? null : _pickForecast(forecast, date, allDay: allDay);
    if (raw == null) return null;
    return PackReadyDayWeather(
      dateKey: key,
      tempF: raw.tempF,
      wmoCode: raw.wmoCode,
      windSpeedMph: raw.windSpeedMph,
      locationLabel: isLocal ? 'Local' : point.label,
      isLocalFallback: isLocal,
    );
  }

  static Future<_GeoPoint?> _geocode(String query) {
    final norm = query.toLowerCase();
    if (_geoCache.containsKey(norm)) return Future.value(_geoCache[norm]);
    return _geoInFlight.putIfAbsent(norm, () async {
      try {
        final result = await _geocodeUncached(query);
        _geoCache[norm] = result;
        return result;
      } catch (_) {
        _geoCache[norm] = null;
        return null;
      } finally {
        _geoInFlight.remove(norm);
      }
    });
  }

  static Future<_GeoPoint?> _geocodeUncached(String raw) async {
    // Parse "Street, City, ST 12345" or "City, ST" into clean search name + optional admin hint.
    final parts =
        raw.split(',').map((p) => p.trim()).where((p) => p.isNotEmpty).toList();
    String cityQuery = raw;
    String? adminHint;
    if (parts.length >= 2) {
      final last =
          parts.last.replaceAll(RegExp(r'\b\d{5}(?:-\d{4})?\b'), '').trim();
      final upper = last.toUpperCase();
      if (_usStates.containsKey(upper)) {
        adminHint = _usStates[upper];
        cityQuery = parts[parts.length - 2];
      } else if (last.length >= 2 && last.length <= 24) {
        adminHint = last;
        cityQuery = parts[parts.length - 2];
      } else {
        cityQuery = parts.first;
      }
    }
    cityQuery = cityQuery.replaceAll(RegExp(r'^\d+\s+'), '').trim();
    if (cityQuery.length < 2) return null;

    final uri = Uri.https('geocoding-api.open-meteo.com', '/v1/search', {
      'name': cityQuery,
      'count': '5',
      'language': 'en',
      'format': 'json',
    });
    final response = await http.get(uri).timeout(const Duration(seconds: 7));
    if (response.statusCode != 200) return null;
    final body = jsonDecode(response.body);
    if (body is! Map<String, dynamic>) return null;
    final results = body['results'];
    if (results is! List || results.isEmpty) return null;

    Map<String, dynamic>? picked;
    if (adminHint != null && adminHint.isNotEmpty) {
      final hintLower = adminHint.toLowerCase();
      for (final item in results.whereType<Map>()) {
        final map = Map<String, dynamic>.from(item);
        final admin1 = (map['admin1'] as String? ?? '').toLowerCase();
        final country = (map['country'] as String? ?? '').toLowerCase();
        final countryCode =
            (map['country_code'] as String? ?? '').toLowerCase();
        if (admin1 == hintLower ||
            admin1.contains(hintLower) ||
            country == hintLower ||
            countryCode == hintLower) {
          picked = map;
          break;
        }
      }
    }
    picked ??= Map<String, dynamic>.from(results.first as Map);
    final lat = (picked['latitude'] as num?)?.toDouble();
    final lon = (picked['longitude'] as num?)?.toDouble();
    final name = (picked['name'] as String? ?? cityQuery).trim();
    if (lat == null || lon == null) return null;
    return _GeoPoint(
      lat: lat,
      lon: lon,
      label: name.isEmpty ? cityQuery : name,
    );
  }

  static Future<_ForecastCacheEntry?> _fetchForecast(_GeoPoint point) {
    final key = _coordKey(point);
    final existing = _forecastCache[key];
    if (existing != null &&
        DateTime.now().difference(existing.fetchedAt) <= _cacheTtl) {
      return Future.value(existing);
    }
    return _forecastInFlight.putIfAbsent(key, () async {
      try {
        final uri = Uri.https('api.open-meteo.com', '/v1/forecast', {
          'latitude': point.lat.toStringAsFixed(4),
          'longitude': point.lon.toStringAsFixed(4),
          'hourly': 'temperature_2m,weather_code,wind_speed_10m',
          'daily':
              'temperature_2m_max,temperature_2m_min,weather_code,wind_speed_10m_max',
          'timezone': 'auto',
          'forecast_days': '16',
          'wind_speed_unit': 'mph',
          'temperature_unit': 'fahrenheit',
        });
        final response =
            await http.get(uri).timeout(const Duration(seconds: 8));
        if (response.statusCode != 200) return existing;
        final body = jsonDecode(response.body);
        if (body is! Map<String, dynamic>) return existing;
        final daily = body['daily'];
        if (daily is! Map<String, dynamic>) return existing;

        final times = (daily['time'] as List?) ?? const [];
        final highs = (daily['temperature_2m_max'] as List?) ?? const [];
        final lows = (daily['temperature_2m_min'] as List?) ?? const [];
        final codes = (daily['weather_code'] as List?) ?? const [];
        final winds = (daily['wind_speed_10m_max'] as List?) ?? const [];

        final days = <String, _RawDayForecast>{};
        final count = times.length;
        for (var i = 0; i < count; i++) {
          final dateStr = times[i]?.toString();
          if (dateStr == null || dateStr.isEmpty) continue;
          final hi = i < highs.length && highs[i] is num
              ? (highs[i] as num).toDouble()
              : null;
          final lo = i < lows.length && lows[i] is num
              ? (lows[i] as num).toDouble()
              : null;
          final code = i < codes.length && codes[i] is num
              ? (codes[i] as num).toInt()
              : null;
          final wind = i < winds.length && winds[i] is num
              ? (winds[i] as num).toDouble()
              : 0.0;
          if (code == null || (hi == null && lo == null)) continue;
          final displayTemp = (hi ?? lo!).round();
          days[dateStr] = _RawDayForecast(
            tempF: displayTemp,
            wmoCode: code,
            windSpeedMph: wind,
          );
        }

        final hourlyByDay = <String, Map<int, _RawDayForecast>>{};
        final hourly = body['hourly'];
        if (hourly is Map<String, dynamic>) {
          final hTimes = (hourly['time'] as List?) ?? const [];
          final hTemps = (hourly['temperature_2m'] as List?) ?? const [];
          final hCodes = (hourly['weather_code'] as List?) ?? const [];
          final hWinds = (hourly['wind_speed_10m'] as List?) ?? const [];
          for (var i = 0; i < hTimes.length; i++) {
            final timeStr = hTimes[i]?.toString();
            if (timeStr == null || timeStr.length < 13 || timeStr[10] != 'T') {
              continue;
            }
            final dateStr = timeStr.substring(0, 10);
            final hour = int.tryParse(timeStr.substring(11, 13));
            if (hour == null || hour < 0 || hour > 23) continue;
            final temp = i < hTemps.length && hTemps[i] is num
                ? (hTemps[i] as num).toDouble()
                : null;
            final code = i < hCodes.length && hCodes[i] is num
                ? (hCodes[i] as num).toInt()
                : null;
            final wind = i < hWinds.length && hWinds[i] is num
                ? (hWinds[i] as num).toDouble()
                : 0.0;
            if (code == null || temp == null) continue;
            hourlyByDay.putIfAbsent(dateStr, () => {})[hour] = _RawDayForecast(
              tempF: temp.round(),
              wmoCode: code,
              windSpeedMph: wind,
            );
          }
        }

        final entry = _ForecastCacheEntry(
          fetchedAt: DateTime.now(),
          days: days,
          hourly: hourlyByDay,
        );
        _forecastCache[key] = entry;
        return entry;
      } catch (_) {
        return existing;
      } finally {
        _forecastInFlight.remove(key);
      }
    });
  }
}

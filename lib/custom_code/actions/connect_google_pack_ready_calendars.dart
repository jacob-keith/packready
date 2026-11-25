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

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:http/http.dart' as http;

import '/custom_code/actions/load_pack_ready_calendar_events.dart'
    show
        CalendarAdapter,
        CalendarRead,
        CalendarSource,
        googleCalendarReconnectNotice;

const _webClientId =
    '917726439700-c9j5nilf0fvved1rbt6g35jemf3s2s05.apps.googleusercontent.com';
const _scopes = [
  'https://www.googleapis.com/auth/calendar.events.readonly',
  'https://www.googleapis.com/auth/calendar.calendarlist.readonly',
];
const _windowPastDays = 90;
const _windowFutureDays = 365;

String? _cleanText(Object? value, int limit) {
  if (value is! String) return null;
  final trimmed = value.trim();
  if (trimmed.isEmpty) return null;
  return trimmed.length <= limit ? trimmed : trimmed.substring(0, limit);
}

bool _isGoogleAutoCalendar(String id) =>
    id.contains('#holiday@') ||
    id.contains('#contacts@') ||
    id.contains('#other@');

Future<dynamic> connectGooglePackReadyCalendars() =>
    GoogleCalendarAdapter.connect();

class GoogleCalendarAdapter implements CalendarAdapter {
  GoogleCalendarAdapter._(this._token);
  final String _token;

  static Future<void>? _webInit;
  static bool _webReady = false;

  /// Pre-initializes Google Identity Services on web so clicking Connect opens
  /// the OAuth popup inside the synchronous user gesture without popup blocks.
  static Future<void> prewarm() {
    if (!kIsWeb) return Future.value();
    if (_webReady) return Future.value();
    return _webInit ??= GoogleSignInPlatform.instance
        .initWithParams(const SignInInitParameters(clientId: _webClientId))
        .then((_) {
      _webReady = true;
    }).catchError((Object error) {
      _webInit = null;
      _webReady = false;
      throw error;
    });
  }

  static Future<void> clearSession() async {
    try {
      if (kIsWeb) {
        if (_webReady) {
          await GoogleSignInPlatform.instance.clearAuthCache(token: '');
        }
      } else {
        await GoogleSignIn(scopes: _scopes).signOut();
      }
    } catch (_) {}
  }

  static String _errorCode(Object failure) {
    if (failure is PlatformException) return failure.code.trim();
    final raw = failure.toString().trim();
    if (raw.contains('.')) {
      final tail = raw.split('.').last.trim();
      if (tail.isNotEmpty) return tail;
    }
    return raw;
  }

  static Future<GoogleCalendarAdapter> connect() async {
    String? token;
    var granted = true;
    try {
      if (kIsWeb) {
        final client = GoogleSignInPlatform.instance;
        if (!_webReady) await prewarm();
        granted = await client
            .requestScopes(_scopes)
            .timeout(const Duration(minutes: 2));
        if (granted) {
          token = (await client.getTokens(
            email: '',
            shouldRecoverAuth: false,
          ))
              .accessToken;
        }
      } else {
        final client = GoogleSignIn(scopes: _scopes);
        final account = await client.signIn();
        token = (await account?.authentication)?.accessToken;
      }
    } on TimeoutException {
      throw const FormatException(
        'Google did not finish authorizing Calendar. Try connecting again.',
      );
    } on FormatException {
      rethrow;
    } catch (failure) {
      final code = _errorCode(failure);
      if (kDebugMode) {
        debugPrint('Calendar Google OAuth error ($code): $failure');
      }
      throw FormatException(switch (code) {
        'popup_failed_to_open' =>
          'Pop-up blocked. Allow pop-ups for this site, then tap Connect Google Calendar again.',
        'popup_closed' =>
          'Google sign-in closed before Calendar access was granted.',
        'access_denied' =>
          'Google Calendar permission was denied. Grant read-only Calendar access to connect.',
        'missing_required_parameter' =>
          'Google sign-in could not start. Reload and try again.',
        _ => 'Could not authorize Google Calendar'
            '${code.isNotEmpty && code.length <= 40 ? ' ($code)' : ''}. '
            'Try reconnecting.',
      });
    }
    if (!granted || token == null || token.isEmpty) {
      throw const FormatException(
        'Google Calendar read-only permission was not granted. Check all Calendar permission boxes and try again.',
      );
    }
    if (kDebugMode) {
      debugPrint('Calendar Google authorization returned a token');
    }
    return GoogleCalendarAdapter._(token);
  }

  Stream<Map<String, dynamic>> _pages(
    List<String> path,
    Map<String, String> parameters,
  ) async* {
    String? next;
    var page = 0;
    do {
      page++;
      final url = Uri(
        scheme: 'https',
        host: 'www.googleapis.com',
        pathSegments: path,
        queryParameters: {...parameters, if (next != null) 'pageToken': next},
      );
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $_token'
      }).timeout(const Duration(seconds: 25));
      if (kDebugMode) {
        debugPrint(
          'Calendar Google ${path.last} page $page: HTTP ${response.statusCode}',
        );
      }
      if (response.statusCode != 200) {
        throw FormatException(switch (response.statusCode) {
          401 => googleCalendarReconnectNotice,
          403 =>
            'Google denied Calendar access. Check the read-only Calendar permissions.',
          404 => 'Calendar was not found in this Google account.',
          final status => 'Google Calendar returned HTTP $status.',
        });
      }
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      for (final item in result['items'] as List? ?? const []) {
        if (item is Map<String, dynamic>) yield item;
      }
      next = result['nextPageToken'] as String?;
    } while (next?.isNotEmpty == true);
  }

  @override
  Future<List<CalendarSource>> sources() async {
    final results = <CalendarSource>[];
    await for (final item in _pages(
      ['calendar', 'v3', 'users', 'me', 'calendarList'],
      {
        'minAccessRole': 'reader',
        'maxResults': '250',
        'fields':
            'nextPageToken,items(id,summary,summaryOverride,backgroundColor,selected,primary,accessRole,hidden,deleted)',
      },
    )) {
      final id = item['id'];
      if (id is! String || id.isEmpty || item['deleted'] == true) continue;
      final role = item['accessRole'] as String? ?? '';
      final isOwnedOrWritable = role == 'owner' || role == 'writer';
      final defaultEnabled = item['primary'] == true ||
          item['selected'] == true ||
          (isOwnedOrWritable &&
              item['hidden'] != true &&
              !_isGoogleAutoCalendar(id));
      results.add(
        CalendarSource(
          id: id,
          provider: 'google',
          name: _cleanText(item['summaryOverride'], 120) ??
              _cleanText(item['summary'], 120) ??
              'Google Calendar',
          color: _cleanText(item['backgroundColor'], 16) ?? '#75A8DF',
          enabled: defaultEnabled,
        ),
      );
    }
    if (kDebugMode) {
      debugPrint(
        'Calendar Google calendarList: ${results.length} calendars '
        '(${results.where((s) => s.enabled).map((s) => s.name).join(', ')})',
      );
    }
    return results;
  }

  @override
  Future<CalendarRead> events(
    List<CalendarSource> calendars, {
    DateTime? rangeStart,
    DateTime? rangeEnd,
  }) async {
    if (calendars.isEmpty) {
      return (events: const <PackReadyCalendarEventStruct>[], warning: null);
    }
    final now = DateTime.now().toUtc();
    final timeMin =
        (rangeStart ?? now.subtract(const Duration(days: _windowPastDays)))
            .toUtc();
    final rawMax =
        (rangeEnd ?? now.add(const Duration(days: _windowFutureDays))).toUtc();
    final timeMax =
        rawMax.isAfter(timeMin) ? rawMax : timeMin.add(const Duration(days: 1));
    final events = <PackReadyCalendarEventStruct>[];
    String? warning;
    for (final calendar in calendars) {
      final calEvents = <PackReadyCalendarEventStruct>[];
      try {
        await for (final item in _pages(
          ['calendar', 'v3', 'calendars', calendar.id, 'events'],
          {
            'timeMin': timeMin.toIso8601String(),
            'timeMax': timeMax.toIso8601String(),
            'maxResults': '2500',
            'singleEvents': 'true',
            'showDeleted': 'false',
            'orderBy': 'startTime',
            'fields':
                'nextPageToken,items(id,status,summary,start,end,location,description,recurringEventId)',
          },
        )) {
          if (item['status'] == 'cancelled') continue;
          final start = item['start'] as Map?;
          final end = item['end'] as Map?;
          final id = item['id'];
          if (id is! String || id.isEmpty || start == null || end == null) {
            continue;
          }
          final startRaw = (start['dateTime'] ?? start['date']) as String?;
          final endRaw = (end['dateTime'] ?? end['date']) as String?;
          if (startRaw == null ||
              endRaw == null ||
              DateTime.tryParse(startRaw) == null ||
              DateTime.tryParse(endRaw) == null) {
            continue;
          }
          calEvents.add(
            PackReadyCalendarEventStruct(
              id: id,
              provider: 'google',
              calendarId: calendar.id,
              calendarName: calendar.name,
              title: _cleanText(item['summary'], 200) ?? 'Untitled event',
              start: startRaw,
              end: endRaw,
              allDay: start.containsKey('date'),
              location: _cleanText(item['location'], 240),
              notes: _cleanText(item['description'], 500),
              seriesId: _cleanText(item['recurringEventId'], 200),
            ),
          );
        }
        events.addAll(calEvents);
        if (kDebugMode) {
          final weeks = <String, int>{};
          for (final event in calEvents) {
            final start = DateTime.tryParse(event.start)?.toLocal();
            if (start == null) continue;
            final monday = DateTime(
              start.year,
              start.month,
              start.day - start.weekday + 1,
            );
            final date = monday.toIso8601String().substring(0, 10);
            weeks.update(date, (n) => n + 1, ifAbsent: () => 1);
          }
          debugPrint(
            'Calendar Google "${calendar.name}" (${calendar.id}) '
            '[${timeMin.toIso8601String().substring(0, 10)}..'
            '${timeMax.toIso8601String().substring(0, 10)}]: '
            '${calEvents.length} events across ${weeks.length} weeks: $weeks',
          );
        }
      } on FormatException catch (error) {
        warning ??= error.message;
        if (error.message == googleCalendarReconnectNotice) break;
      } on TimeoutException {
        warning ??= 'Refreshing Google Calendar timed out. Try again.';
      } on Exception {
        warning ??= 'Some Google calendars could not refresh.';
      }
    }
    return (events: events, warning: warning);
  }
}

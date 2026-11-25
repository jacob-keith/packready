import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';

import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../index.dart';
import '../../main.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    await _handlePushNotificationData(message.data);
  }

  Future _handlePushNotificationData(Map<String, dynamic> messageData) async {
    safeSetState(() => _loading = true);
    try {
      final initialPageName = messageData['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(messageData);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        if (mounted) {
          context.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        } else {
          appNavigatorKey.currentContext?.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        }
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      safeSetState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handleOpenedPushNotification();
    });
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'Signup': ParameterData.none(),
  'Settings': ParameterData.none(),
  'SubscriptionPlans': ParameterData.none(),
  'ActivityEditor': (data) async => ParameterData(
        allParams: {
          'listRef': getParameter<DocumentReference>(data, 'listRef'),
        },
      ),
  'Activities': (data) async => ParameterData(
        allParams: {
          'tabSlideOffset': getParameter<double>(data, 'tabSlideOffset'),
          'tabHandoff': getParameter<String>(data, 'tabHandoff'),
          'embedInTabShell': getParameter<bool>(data, 'embedInTabShell'),
        },
      ),
  'TemplateEditor': (data) async => ParameterData(
        allParams: {
          'templateRef': getParameter<DocumentReference>(data, 'templateRef'),
          'startName': getParameter<String>(data, 'startName'),
          'startActivity': getParameter<String>(data, 'startActivity'),
          'startStarter': getParameter<String>(data, 'startStarter'),
          'calendarPrompt': getParameter<bool>(data, 'calendarPrompt'),
          'calendarActivityMode':
              getParameter<bool>(data, 'calendarActivityMode'),
          'startFromAiDraft': getParameter<bool>(data, 'startFromAiDraft'),
        },
      ),
  'PackReadyAi': (data) async => ParameterData(
        allParams: {
          'embedInTabShell': getParameter<bool>(data, 'embedInTabShell'),
        },
      ),
  'Connections': (data) async => ParameterData(
        allParams: {
          'embedInTabShell': getParameter<bool>(data, 'embedInTabShell'),
        },
      ),
  'Templates': ParameterData.none(),
  'MyActivities': ParameterData.none(),
  'Login': ParameterData.none(),
  'Profile': (data) async => ParameterData(
        allParams: {
          'tabSlideOffset': getParameter<double>(data, 'tabSlideOffset'),
          'tabHandoff': getParameter<String>(data, 'tabHandoff'),
        },
      ),
  'testpage': ParameterData.none(),
  'PackingList': (data) async => ParameterData(
        allParams: {
          'listRef': getParameter<DocumentReference>(data, 'listRef'),
        },
      ),
  'ProfileSetupInfo': ParameterData.none(),
  'ChecklistRun': (data) async => ParameterData(
        allParams: {
          'templateRef': getParameter<DocumentReference>(data, 'templateRef'),
          'runName': getParameter<String>(data, 'runName'),
          'runActivity': getParameter<String>(data, 'runActivity'),
          'runStarter': getParameter<String>(data, 'runStarter'),
        },
      ),
  'HistoryPage': ParameterData.none(),
  'RemindersPage': (data) async => ParameterData(
        allParams: {
          'tabSlideOffset': getParameter<double>(data, 'tabSlideOffset'),
          'tabHandoff': getParameter<String>(data, 'tabHandoff'),
          'embedInTabShell': getParameter<bool>(data, 'embedInTabShell'),
        },
      ),
  'mainscreen': (data) async => ParameterData(
        allParams: {
          'tabSlideOffset': getParameter<double>(data, 'tabSlideOffset'),
          'tabHandoff': getParameter<String>(data, 'tabHandoff'),
          'embedHome': getParameter<bool>(data, 'embedHome'),
        },
      ),
  'PackReadyAiConfirmation': (data) async => ParameterData(
        allParams: <String, dynamic>{},
      ),
  'Editpage': ParameterData.none(),
  'Calendar': (data) async => ParameterData(
        allParams: {
          'embedInTabShell': getParameter<bool>(data, 'embedInTabShell'),
        },
      ),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}

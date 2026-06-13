String fcmNotificationServiceTemplate(String projectName) => '''
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/notification/notification_index.dart';

class FCMNotificationService {
  static final firebase = FirebaseMessaging.instance;
  static final localPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init(String icon) async {
    await messagingInit();
    if (!kIsWeb) await localInit(icon);
  }

  static Future<void> messagingInit() async => firebase.requestPermission();

  static Future<String?> generateToken() async {
    final vapidKey = dotenv.env['vapid_key'];
    return firebase.getToken(vapidKey: kIsWeb ? vapidKey : null);
  }

  static Future<void> localInit(String icon) async {
    final androidSettings = AndroidInitializationSettings(icon);
    const iosSettings = DarwinInitializationSettings();
    const linuxSettings = LinuxInitializationSettings(
      defaultActionName: 'Open notification',
    );
    final settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
      linux: linuxSettings,
    );

    await localPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await localPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveNotificationResponse,
    );
  }

  @pragma('vm:entry-point')
  static void onDidReceiveNotificationResponse(NotificationResponse response) {
    final payload = response.payload;
    if (payload != null && payload.isNotEmpty) {
      final data = jsonDecode(payload) as Json;
      final notification = NotificationItem.fromJson(data);
    }
  }

  static const androidNotificationDetails = AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    channelDescription: 'your_channel_description',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );

  static const iosNotificationDetails = DarwinNotificationDetails();

  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
    await localPlugin.show(0, title, body, notificationDetails, payload: payload);
  }
}

@pragma('vm:entry-point')
Future<void> fcmBackgroundHandler(RemoteMessage message) async {
  log('Handling a background message: \${message.messageId}');
}

String deviceType() {
  var deviceType = 'web';
  if (!kIsWeb) {
    deviceType = Platform.operatingSystem;
  }
  return deviceType;
}
''';

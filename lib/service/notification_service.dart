import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String? _fcmToken;
  String? get fcmToken => _fcmToken;

  Future<void> init() async {
    await _firebaseMessaging.requestPermission();

    _fcmToken = await _firebaseMessaging.getToken();
    print("FCM Token: $_fcmToken");

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);
    await _localNotificationsPlugin.initialize(initSettings);

    // Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground Message: ${message.notification?.title}");
      _showLocalNotification(message);
    });

    // Background & Terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Opened App via Notification: ${message.data}");
    });

    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      print("App launched by notification: ${initialMessage.data}");
    }
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'channel_id', 'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await _localNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? "Title",
      message.notification?.body ?? "Body",
      notificationDetails,
    );
  }
}

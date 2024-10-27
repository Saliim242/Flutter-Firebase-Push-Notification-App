import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_notification_app/controllers/auth_services.dart';
import 'package:flutter_notification_app/controllers/crud_services.dart';
import 'package:flutter_notification_app/main.dart';

class PushNotification {
  static final _firebaseMessage = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future init() async {
    await _firebaseMessage.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
    );

    // Init local Notifications
  }

  // get user device token
  static Future getUserDeviceToken() async {
    // get Our Decive token
    final token = await _firebaseMessage.getToken();
    if (token != null) {
      log('FCM Token: $token', name: "User Token ");
      print(token.toString());
    }

    bool isLogin = await AuthServices().isLoggedIn();

    if (isLogin) {
      // save token to database
      await CrudServices.saveToken(token!);
      print("User Token saved to database");
    }

    _firebaseMessage.onTokenRefresh.listen((onData) async {
      log('FCM Token Refreshed: $onData', name: "User Token Refreshed");
      print(onData.toString());
      if (isLogin) {
        // save token to database
        await CrudServices.saveToken(onData);
        print("User Token saved to database Refreshed");
      }
    });
  }

  static Future initLocalNotifications() async {
    const AndroidInitializationSettings initializationAndrioadSettings =
        AndroidInitializationSettings(
      "@mipmap/ic_launcher",
    );

    final DarwinInitializationSettings initializationSettingsDraw =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: (id, title, body, payload) => null);

    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: "Open Notifications");

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationAndrioadSettings,
      iOS: initializationSettingsDraw,
      linux: initializationSettingsLinux,
    );
    // request Notification Permission for android 13 and above

    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    // Initialize the Flutter Local Notifications Plugin with the provided InitializationSettings.
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
    );
  }

  static void onNotificationTap(NotificationResponse notificationResponse) {
    log('Notification tapped: $notificationResponse',
        name: "Notification Tapped");
    // Handle the notification response.
    // For example, open a specific activity based on the provided payload data.
    // For Android, you can use details.getNotification().activity to retrieve the activity to open.
    // For iOS, you can use details.notification.request.content.userInfo to retrieve the payload data.
    // Example:
    // await Navigator.push(context, MaterialPageRoute(builder: (context) => YourPage(payload: details.notification.request.content.userInfo)));
    navigatorKey.currentState!
        .pushNamed('/message', arguments: notificationResponse);
  }

  // Show Simple Notification
  static void showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'your chennel; id',
      'your chennel name',

      channelDescription: 'App Notifications Description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      //showWhen: true,

      // icon: 'launcher_icon',
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_notification_app/controllers/auth_services.dart';
import 'package:flutter_notification_app/controllers/notification_services.dart';
import 'package:flutter_notification_app/pages/home_page.dart';
import 'package:flutter_notification_app/pages/login_page.dart';

import 'firebase_options.dart';
import 'pages/massages_page.dart';
import 'pages/sign_up_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// function to listen background notifications
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    log('Background Message: ${message.notification?.title}, ${message.notification?.body}',
        name: "Background Message");
    // TODO: Process the message
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // initialize Firebase Messageing
  await PushNotification.init();

  // initialize local notification permissions
  await PushNotification.initLocalNotifications();

  // listen to firebase background messages  and notify the user
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  // When The user taps the background notification direcct to notivigation page
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    log('Notification opened: ${message.notification?.title}, ${message.notification?.body}',
        name: "Notification Opened");

    if (message.notification != null) {
      navigatorKey.currentState!.pushNamed('/message', arguments: message);
    }
    ;
  });

  // Handle fourground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    log('Message: ${message.notification?.title}, ${message.notification?.body}',
        name: "Message Received");
    ;

    String payloadData = jsonEncode(message.data);
    if (message.notification != null) {
      PushNotification.showSimpleNotification(
        title: message.notification!.title!,
        body: message.notification!.body!,
        payload: payloadData,
      );
    }
  });

  // Handle nofication for termination state
  RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    log('Notification terminated: ${message.notification?.title}, ${message.notification?.body}',
        name: "Notification Terminated");
    Future.delayed(Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed('/message', arguments: message);
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Local Notification App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      navigatorKey: navigatorKey,
      routes: {
        '/': (context) => CheckUser(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/message': (context) => MassagesPage(),
      },
    );
  }
}

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    super.initState();
    AuthServices().isLoggedIn().then((user) {
      if (user) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

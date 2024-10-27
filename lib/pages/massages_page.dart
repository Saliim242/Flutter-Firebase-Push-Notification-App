import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MassagesPage extends StatefulWidget {
  const MassagesPage({super.key});

  @override
  State<MassagesPage> createState() => _MassagesPageState();
}

class _MassagesPageState extends State<MassagesPage> {
  Map payload = {};
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments;

    // The Data payload Messages we get into Two types
    // for Backgroud and terminate state
    if (data is RemoteMessage) {
      payload = data.data;
    }
    if (data is NotificationResponse) {
      payload = jsonDecode(data.payload!);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Messages"),
      ),
      body: Center(
        child: Text(payload.toString()),
      ),
    );
  }
}

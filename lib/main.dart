import 'package:flutter/material.dart';
import 'package:flutter_notification_app/pages/login_page.dart';

import 'pages/sign_up_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Local Notification App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        //  '/about': (context) => AboutScreen(),
      },
    );
  }
}

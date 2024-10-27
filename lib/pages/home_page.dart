import 'package:flutter/material.dart';
import 'package:flutter_notification_app/controllers/auth_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await AuthServices().signOut();

              Navigator.pushReplacementNamed(context, '/login');
              // Perform logout action here
              // For demonstration purposes, we'll just navigate back to the Login Page
            },
          ),
        ],
      ),
    );
  }
}

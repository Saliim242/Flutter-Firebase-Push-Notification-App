import 'package:flutter/material.dart';
import 'package:flutter_notification_app/controllers/auth_services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoginButtonEnabled = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  // void signUpUser(BuildContext context, String email, String password) {
  //   AuthService().signUp(context, email, password);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Email"),
                  hintText: "Enter your email address",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Password"),
                  hintText: "Enter your password",
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  AuthServices.createAnAcountEmailAndPassword(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  ).then((onValue) {
                    if (onValue == "User created successfully") {
                      // Scaffold.of(context).showSnackBar(SnackBar(content: Text("User created successfully")));
                      // Navigate to Home page
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            onValue,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.blueGrey),
                  width: MediaQuery.of(context).size.width,
                  height: 65,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("I have already an account", style: TextStyle()),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to Sign In page
                    },
                    child:
                        Text("Sign In", style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

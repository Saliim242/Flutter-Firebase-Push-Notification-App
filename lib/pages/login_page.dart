import 'package:flutter/material.dart';
import 'package:flutter_notification_app/controllers/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  // SignIn Method
  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      // Simulate login API call
      // await Future.delayed(Duration(seconds: 2));
      await AuthServices()
          .loginAnAcountEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      )
          .then((value) {
        if (value == "User is signed in successfully") {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                value,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      });
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "email or password is required",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login",
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
                  onTap: _signIn,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.blueGrey),
                    width: MediaQuery.of(context).size.width,
                    height: 65,
                    child: Text(
                      "login",
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
                    Text("I don't have an account", style: TextStyle()),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/signup");
                      },
                      child:
                          Text("Sign Up", style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

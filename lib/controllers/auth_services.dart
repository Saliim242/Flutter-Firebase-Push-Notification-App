import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;

// Firebase authentication methods for user crreating
  static Future<String> createAnAcountEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return "User created successfully";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  // Firebase authentication methods for user signIn
  Future<String> loginAnAcountEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "User is signed in successfully";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  // Firebase authentication methods for user signOut
  Future signOut() async {
    try {
      await auth.signOut();
      return "User is signed out successfully";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  // check if the user is already authenticated or not
  Future<bool> isLoggedIn() async {
    var user = await auth.currentUser;
    return user != null;
  }
}

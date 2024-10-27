import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CrudServices {
  static User? user = FirebaseAuth.instance.currentUser;

  // Fuunction to save fcm Token

  static Future saveToken(String token) async {
    Map<String, dynamic> data = {
      'email': user!.email!,
      'token': token,
    };

    try {
      await FirebaseFirestore.instance
          .collection('user_data')
          .doc(user!.uid)
          .set(data);
    } catch (e) {
      print('Error saving token: $e');
    }
  }
}

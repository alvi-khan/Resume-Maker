import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_pixel_pioneers/services/authentication.dart';

class Database {
  static FirebaseFirestore db = FirebaseFirestore.instance;
  
  static Future<bool> setProfile(data) async{
    User? user = Authentication.auth.currentUser;
    if (user == null) return false;
    await db.collection("profile").doc(user.uid).set(data);
    return true;
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>>? getProfile() {
    User? user = Authentication.auth.currentUser;
    if (user == null) return null;
    return db.collection("profile").doc(user.uid).get();
  }
}
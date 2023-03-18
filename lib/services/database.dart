import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_pixel_pioneers/services/authentication.dart';

class Database {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<bool> setProfile(data) async {
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

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getEducation() async {
    User? user = Authentication.auth.currentUser;
    var results = await db.collection("education").where("uid", isEqualTo: user!.uid).get();
    return results.docs;
  }

  static Future<bool> setEducation(data) async {
    await db.collection("education").add(data);
    return true;
  }

  static Future<bool> setExperience(data) async {
    await db.collection("experience").add(data);
    return true;
  }

  static Future<bool> setSkills(data) async {
    await db.collection("skills").add(data);
    return true;
  }


  static Future<bool> setAchievements(data) async {
    await db.collection("achievements").add(data);
    return true;
  }
}
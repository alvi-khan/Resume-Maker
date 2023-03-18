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

  static void getEducation() {
    User? user = Authentication.auth.currentUser;
    final users = db.collection("education");
    final query = users.where("uid", isEqualTo: user!.uid);
    query.get().then((results) => {
      for (var doc in results.docs) {print(doc['Degree'])}
    });
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
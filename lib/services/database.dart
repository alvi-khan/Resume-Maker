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

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getEducation() async {
    User? user = Authentication.auth.currentUser;
    var results = await db
        .collection("education")
        .where("uid", isEqualTo: user!.uid)
        .get();
    return results.docs;
  }

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getExperience() async {
    User? user = Authentication.auth.currentUser;
    var results = await db
        .collection("experience")
        .where("uid", isEqualTo: user!.uid)
        .get();
    return results.docs;
  }

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getSkils() async {
    User? user = Authentication.auth.currentUser;
    var results =
        await db.collection("skills").where("uid", isEqualTo: user!.uid).get();
    return results.docs;
  }

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getAchievements() async {
    User? user = Authentication.auth.currentUser;
    var results = await db
        .collection("achievements")
        .where("uid", isEqualTo: user!.uid)
        .get();
    return results.docs;
  }

  static Future<bool> setEducation(data) async {
    User? user = Authentication.auth.currentUser;
    QuerySnapshot<Map<String, dynamic>> docs = await db.collection("education").where("uid", isEqualTo: user!.uid).limit(1).get();
    String docID = docs.docs[0].id;
    await db.collection("education").doc(docID).set(data);
    return true;
  }

  static Future<bool> setExperience(data) async {
    User? user = Authentication.auth.currentUser;
    QuerySnapshot<Map<String, dynamic>> docs = await db.collection("experience").where("uid", isEqualTo: user!.uid).limit(1).get();
    String docID = docs.docs[0].id;
    await db.collection("experience").doc(docID).set(data);
    return true;
  }

  static Future<bool> setSkills(data) async {
    User? user = Authentication.auth.currentUser;
    QuerySnapshot<Map<String, dynamic>> docs = await db.collection("skills").where("uid", isEqualTo: user!.uid).limit(1).get();
    String docID = docs.docs[0].id;
    await db.collection("skills").doc(docID).set(data);
    return true;
  }

  static Future<bool> setAchievements(data) async {
    User? user = Authentication.auth.currentUser;
    QuerySnapshot<Map<String, dynamic>> docs = await db.collection("achievements").where("uid", isEqualTo: user!.uid).limit(1).get();
    String docID = docs.docs[0].id;
    await db.collection("achievements").doc(docID).set(data);
    return true;
  }
}

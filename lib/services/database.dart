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

  static Future<DocumentSnapshot<Map<String, dynamic>>> getEducationDoc({required String docID}) async {
    var result = await db.collection("education").doc(docID).get();
    return result;
  }

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getEducation({String? resumeID}) async {
    print(resumeID);
    if (resumeID != null) {
      var resume = await db.collection("resumes").doc(resumeID).get();
      List<String> docs = List<String>.from(resume.data()!["education"] as List);
      var results = await db.collection("education").get();
      return results.docs.where((element) => docs.contains(element.id)).toList();
    }
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

  static Future<bool> setEducation(data, String? docID, {String? resumeID}) async {
    var newDocID;
    if (docID == null) {
      newDocID = (await db.collection("education").add(data)).id;
    } else {
      await db.collection("education").doc(docID).set(data);
    }

    if (resumeID != null && newDocID != null) {
      var data = await db.collection("resumes").doc(resumeID).get();
      List<String> edu = List<String>.from(data.data()!['education'] as List);
      edu.add(newDocID);
      db.collection("resumes").doc(resumeID).update({"education": edu});
    }
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

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
  getResumes() async {
    User? user = Authentication.auth.currentUser;
    var results = await db
        .collection("resumes")
        .where("uid", isEqualTo: user!.uid)
        .get();
    return results.docs;
  }
  
  static Future<String> createResume() async {
    User? user = Authentication.auth.currentUser;
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = await getEducation();
    List<String> ids = docs.map((e) => e.id).toList();
    DocumentReference<Map<String, dynamic>> resume = await db.collection("resumes").add({
      "uid": user!.uid,
      "education": ids,
    });
    return resume.id;
  }
}

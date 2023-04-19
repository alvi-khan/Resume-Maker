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

  static Future<String> getCompanyNameDoc({required String resumeID}) async {
    var result = await db.collection("resumes").doc(resumeID).get();
    String companyName = result.data()!["company_name"];

    if(companyName == "No Name"){
      return "";
    }
    else{
      return companyName;
    }
  }


  static Future<DocumentSnapshot<Map<String, dynamic>>> getSkillsDoc({required String docID}) async {
    var result = await db.collection("skills").doc(docID).get();
    return result;
  }


  static Future<DocumentSnapshot<Map<String, dynamic>>> getExperienceDoc({required String docID}) async {
    var result = await db.collection("experience").doc(docID).get();
    return result;
  }


  static Future<DocumentSnapshot<Map<String, dynamic>>> getAchievementsDoc({required String docID}) async {
    var result = await db.collection("achievements").doc(docID).get();
    return result;
  }



  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getEducation({String? resumeID}) async {
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

  static Future<String> getCompanyName({String? resumeID}) async {
    if (resumeID != null) {
      var resume = await db.collection("resumes").doc(resumeID).get();
      String docs = resume.data()!["company_name"];

      if(docs == "No Name"){
        return "No Name";
      }
      else{
        return docs;
      }

      // var doc = await db.collection("resumes").doc(resumeID).get();
      // if(doc.exists){
      //   Map<String, dynamic>? map = doc.data();
      //   if(map!.containsKey('company_name')){// Replace field by the field you want to check.
      //     print("ASE");
      //   }
      // }
    }
    else{
      return "NULL";
    }
  }


  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getExperience({String? resumeID}) async {
    if (resumeID != null) {
      var resume = await db.collection("resumes").doc(resumeID).get();
      List<String> docs = List<String>.from(resume.data()!["experience"] as List);
      var results = await db.collection("experience").get();
      return results.docs.where((element) => docs.contains(element.id)).toList();
    }
    User? user = Authentication.auth.currentUser;
    var results = await db
        .collection("experience")
        .where("uid", isEqualTo: user!.uid)
        .get();
    return results.docs;
  }


  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
    getSkills({String? resumeID}) async {
    if (resumeID != null) {
      var resume = await db.collection("resumes").doc(resumeID).get();
      List<String> docs = List<String>.from(resume.data()!["skills"] as List);
      var results = await db.collection("skills").get();
      return results.docs.where((element) => docs.contains(element.id)).toList();
    }
    User? user = Authentication.auth.currentUser;
    var results = await db
        .collection("skills")
        .where("uid", isEqualTo: user!.uid)
        .get();
    return results.docs;
  }


  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getAchievements({String? resumeID}) async {
    if (resumeID != null) {
      var resume = await db.collection("resumes").doc(resumeID).get();
      List<String> docs = List<String>.from(resume.data()!["achievements"] as List);
      var results = await db.collection("achievements").get();
      return results.docs.where((element) => docs.contains(element.id)).toList();
    }
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


  static Future<bool> setCompanyName(data, String? docID, {String? resumeID}) async {
    db.collection("resumes").doc(resumeID).update({"company_name": data["company_name"]});
    return true;
  }


  static Future<bool> setExperience(data, String? docID, {String? resumeID}) async {
    var newDocID;
    if (docID == null) {
      newDocID = (await db.collection("experience").add(data)).id;
    } else {
      await db.collection("experience").doc(docID).set(data);
    }

    if (resumeID != null && newDocID != null) {
      var data = await db.collection("resumes").doc(resumeID).get();
      List<String> experience = List<String>.from(data.data()!['experience'] as List);
      experience.add(newDocID);
      db.collection("resumes").doc(resumeID).update({"experience": experience});
    }
    return true;
  }


  static Future<bool> setSkills(data, String? docID, {String? resumeID}) async {
    var newDocID;
    if (docID == null) {
      newDocID = (await db.collection("skills").add(data)).id;
    } else {
      await db.collection("skills").doc(docID).set(data);
    }

    if (resumeID != null && newDocID != null) {
      var data = await db.collection("resumes").doc(resumeID).get();
      List<String> skills = List<String>.from(data.data()!['skills'] as List);
      skills.add(newDocID);
      db.collection("resumes").doc(resumeID).update({"skills": skills});
    }
    return true;
  }

  static Future<bool> setAchievements(data, String? docID, {String? resumeID}) async {
    var newDocID;
    if (docID == null) {
      newDocID = (await db.collection("achievements").add(data)).id;
    } else {
      await db.collection("achievements").doc(docID).set(data);
    }

    if (resumeID != null && newDocID != null) {
      var data = await db.collection("resumes").doc(resumeID).get();
      List<String> achievements = List<String>.from(data.data()!['achievements'] as List);
      achievements.add(newDocID);
      db.collection("resumes").doc(resumeID).update({"achievements": achievements});
    }
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
    List<QueryDocumentSnapshot<Map<String, dynamic>>> edu_docs = await getEducation();
    List<String> edu_ids = edu_docs.map((e) => e.id).toList();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> skills_docs = await getSkills();
    List<String> skills_ids = skills_docs.map((e) => e.id).toList();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> experience_docs = await getExperience();
    List<String> experience_ids = experience_docs.map((e) => e.id).toList();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> achievements_docs = await getAchievements();
    List<String> achievements_ids = achievements_docs.map((e) => e.id).toList();

    DocumentReference<Map<String, dynamic>> resume = await db.collection("resumes").add({
      "uid": user!.uid,
      "education": edu_ids,
      "company_name": "No Name",
      "skills": skills_ids,
      "experience": experience_ids,
      "achievements": achievements_ids,
    });
    return resume.id;
  }


  static void deleteResume(String? resumeID) async {
    await db.collection("resumes").doc(resumeID).delete();
  }


  static Future<bool> deleteEducationFromResume(String? resumeID, var docID) async {
    var data = await db.collection("resumes").doc(resumeID).get();
    List<String> edu = List<String>.from(data.data()!['education'] as List);
    edu.remove(docID);
    db.collection("resumes").doc(resumeID).update({"education": edu});

    return true;
  }


  static Future<bool> deleteSkillsFromResume(String? resumeID, var docID) async {
    var data = await db.collection("resumes").doc(resumeID).get();
    List<String> skills = List<String>.from(data.data()!['skills'] as List);
    skills.remove(docID);
    db.collection("resumes").doc(resumeID).update({"skills": skills});

    return true;
  }


  static Future<bool> deleteExperienceFromResume(String? resumeID, var docID) async {
    var data = await db.collection("resumes").doc(resumeID).get();
    List<String> experience = List<String>.from(data.data()!['experience'] as List);
    experience.remove(docID);
    db.collection("resumes").doc(resumeID).update({"experience": experience});

    return true;
  }


  static Future<bool> deleteAchievementsFromResume(String? resumeID, var docID) async {
    var data = await db.collection("resumes").doc(resumeID).get();
    List<String> achievements = List<String>.from(data.data()!['achievements'] as List);
    achievements.remove(docID);
    db.collection("resumes").doc(resumeID).update({"achievements": achievements});

    return true;
  }

}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:the_pixel_pioneers/components/edit_profile.dart';
import 'package:the_pixel_pioneers/components/edit_resume.dart';
import 'package:the_pixel_pioneers/components/preview.dart';
import 'package:the_pixel_pioneers/services/authentication.dart';

import '../services/database.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  List<QueryDocumentSnapshot<Map<String, dynamic>>> resumes = <QueryDocumentSnapshot<Map<String, dynamic>>>[];

  void getData() async {
    var results = await Database.getResumes();
    setState(() => resumes = results);
  }
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Resume Maker"),
            automaticallyImplyLeading: false,
            actions: [IconButton(onPressed: () => Authentication.auth.signOut(), icon: Icon(Icons.logout_rounded))],
        ),
        body:Column(
          children: [
            ProfileSection(),
            Resumes(resumes: resumes, onChange: () => getData()),
          ],
        ),
    );
  }
}

class Resumes extends StatelessWidget {
  const Resumes({super.key, required this.resumes, required this.onChange});

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> resumes;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(26), bottom: Radius.zero),
          color: Color(0xFFD9D9D9),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    const Text("My Resumes", style: TextStyle(fontSize: 24)),
                    const Spacer(),
                    IconButton(
                        onPressed: () async {
                          String id = await Database.createResume();
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => EditResume(docID: id)),
                          ).then((value) => onChange());
                        },
                        icon: const Icon(Icons.add_circle_rounded, color: Color(0xFF6356C7),
                          size: 36,
                        )
                    )
                  ],
                ),
                const SizedBox(height: 16),
                ...resumes.map((e) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Text(
                          e.data()['company_name'],
                          style: const TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () async => await showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36.0)
                          ),
                          builder: (BuildContext context) => Modal(resumeID: e.id)
                      ),
                          icon: const Icon(Icons.menu))
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Modal extends StatelessWidget {
  const Modal({
    super.key,
    this.resumeID
  });

  final String? resumeID;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(36.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 300,
            height: 50,
            child: TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Preview()),
                ),
                child: const Text("Preview Resume"),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF27AE60),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  )
                ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            height: 50,
            child: TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EditResume(docID: resumeID)),
                ),
                child: const Text("Edit Resume"),
              style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF2F80ED),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  )
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            height: 50,
            child: TextButton(
                onPressed: () async {
                  Database.deleteResume(resumeID);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
                },
                child: const Text("Delete Resume"),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFEB5757),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileSection extends StatefulWidget {
  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {

  String name="";
  String profession="";

  void getData() async {
    DocumentSnapshot<Map<String, dynamic>>? doc = await Database.getProfile();
    if (doc == null) {
      name = "Set Name";
      profession = "Set Profession";
    }
    else{
      name = doc.data()!['name'];
      profession = doc.data()!['profession'];
    }
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Image(image: AssetImage("assets/images/placeholder.png"), width: 150),
          const Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
              ),
              Text(profession, style: const TextStyle(fontSize: 12), textAlign: TextAlign.right),
              TextButton(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EditProfile()),
                  ).then((value) => getData()),
                  child: const Text("Edit Profile"),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade400,
                    foregroundColor: Colors.white,
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Resume Maker"),
          actions: [IconButton(onPressed: () => Authentication.auth.signOut(), icon: Icon(Icons.logout_rounded))],
        ),
        body:Column(
          children: [
            ProfileSection(),
            Resumes(),
          ],
        ),
    );
  }
}

class Resumes extends StatelessWidget {
  const Resumes({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(26), bottom: Radius.zero),
          color: Color(0xFFD9D9D9),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text("My Resumes", style: TextStyle(fontSize: 24)),
                  Spacer(),
                  IconButton(
                      onPressed: () => {},
                      icon: Icon(Icons.add_circle_rounded, color: Color(0xFF6356C7),
                        size: 36,
                      )
                  )
                ],
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      "Optimizely",
                        style: TextStyle(fontSize: 16)
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () async => await showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)
                        ),
                        builder: (BuildContext context) => Modal()
                    ),
                        icon: Icon(Icons.menu))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Modal extends StatelessWidget {
  const Modal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Preview()),
              ),
              child: Text("Preview Resume"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent.shade700),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              )
          ),
          TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditResume()),
              ),
              child: Text("Edit Resume"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent.shade700),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              )
          ),
          TextButton(
              onPressed: () => {},
              child: Text("Delete Resume"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent.shade400),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              )
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
          Image(image: AssetImage("assets/images/placeholder.png"), width: 150),
          Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(name, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
              ),
              Text(profession, style: TextStyle(fontSize: 12), textAlign: TextAlign.right),
              TextButton(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EditProfile()),
                  ),
                  child: Text("Edit Profile"),
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
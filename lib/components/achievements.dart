import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/authentication.dart';
import '../services/database.dart';

class Achievements extends StatefulWidget {
  const Achievements({super.key, this.docID, this.resumeID});
  final String? docID;
  final String? resumeID;

  @override
  State<Achievements> createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {

  TextEditingController _eventController = TextEditingController();
  TextEditingController _awardController = TextEditingController();


  void getData() async {
    if (widget.docID == null) return;

    DocumentSnapshot<Map<String, dynamic>> doc = await Database.getAchievementsDoc(docID: widget.docID!);
    _eventController.text = doc.data()!['event'];
    _awardController.text = doc.data()!['awards'];
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
        title: const Text('Achievements'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text(
                    'Occasion',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    controller: _eventController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Example- IUT CodeRush",
                    ),
                  ),
                  const SizedBox(
                    height: 26.0,
                  ),
                  const Text(
                    'Awards',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    controller: _awardController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Example- First runners up",
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RawMaterialButton(
                      fillColor: Colors.deepPurple,
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      onPressed: () async {
                        Database.deleteAchievementsFromResume(widget.resumeID, widget.docID);
                        Navigator.of(context).pop();
                      },
                      child: const Text("Delete",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RawMaterialButton(
                      fillColor: Colors.deepPurple,
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      onPressed: () async {
                        Map<String, String> data = {
                          'uid': Authentication.auth.currentUser!.uid,
                          'event': _eventController.text,
                          'awards': _awardController.text
                        };
                        Database.setAchievements(data, widget.docID, resumeID: widget.resumeID);
                        Navigator.of(context).pop();
                      },
                      child: const Text("Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

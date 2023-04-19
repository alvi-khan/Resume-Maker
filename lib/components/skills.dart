import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/authentication.dart';
import '../services/database.dart';

class Skills extends StatefulWidget {
  const Skills({super.key, this.docID, this.resumeID});
  final String? docID;
  final String? resumeID;

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  TextEditingController _skillNameController = TextEditingController();

  void getData() async {
    if (widget.docID == null) return;

    DocumentSnapshot<Map<String, dynamic>> doc = await Database.getSkillsDoc(docID: widget.docID!);
    _skillNameController.text = doc.data()!['description'];
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
        title: const Text('Skills'),
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
                    'Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    controller: _skillNameController,
                    minLines: 3,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:
                          "Enter a skill",
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
                        Database.deleteSkillsFromResume(widget.resumeID, widget.docID);
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
                          'description': _skillNameController.text
                        };
                        Database.setSkills(data, widget.docID, resumeID: widget.resumeID);
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

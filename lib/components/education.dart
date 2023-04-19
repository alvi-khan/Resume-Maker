import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/authentication.dart';
import '../services/database.dart';

class Education extends StatefulWidget {
  const Education({super.key, this.docID, this.resumeID});
  final String? docID;
  final String? resumeID;

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  TextEditingController _degreeController = TextEditingController();
  TextEditingController _institutionController = TextEditingController();
  TextEditingController _resultController = TextEditingController();
  TextEditingController _graduationDateController = TextEditingController();

  void getData() async {
    if (widget.docID == null) return;

    DocumentSnapshot<Map<String, dynamic>> doc = await Database.getEducationDoc(docID: widget.docID!);
    _degreeController.text = doc.data()!['Degree'];
    _institutionController.text = doc.data()!['Institution'];
    _resultController.text = doc.data()!['Result'];
    _graduationDateController.text = doc.data()!['Graduation_Date'];
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
        title: const Text('Education'),
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
                    'Degree',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    controller: _degreeController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Example- BSc in Engineering",
                    ),
                  ),
                  const SizedBox(
                    height: 26.0,
                  ),
                  const Text(
                    'Institution',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    controller: _institutionController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Example- IUT",
                    ),
                  ),
                  const SizedBox(
                    height: 26.0,
                  ),
                  const Text(
                    'Result',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    controller: _resultController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Examination score (CGPA)",
                    ),
                  ),
                  const SizedBox(
                    height: 26.0,
                  ),
                  const Text(
                    'Graduation Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    controller: _graduationDateController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "date/month/year",
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
                        await Database.deleteEducationFromResume(widget.resumeID, widget.docID);
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
                          'Degree': _degreeController.text,
                          'Graduation_Date': _graduationDateController.text,
                          'Institution': _institutionController.text,
                          'Result': _resultController.text
                        };
                        await Database.setEducation(data, widget.docID, resumeID: widget.resumeID);
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

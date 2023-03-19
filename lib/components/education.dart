import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/authentication.dart';
import '../services/database.dart';

class Education extends StatefulWidget {
  const Education({super.key, this.docID});
  final String? docID;

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

    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = await Database.getEducation();
    QueryDocumentSnapshot<Map<String, dynamic>>? thisDoc;
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in docs) {
      if (doc.id == widget.docID) {
        thisDoc = doc;
      }
    }
    if (thisDoc == null)  throw Exception("Document not found.");

    _degreeController.text = thisDoc.data()['Degree'];
    _institutionController.text = thisDoc.data()['Institution'];
    _resultController.text = thisDoc.data()['Result'];
    _graduationDateController.text = thisDoc.data()['Graduation_Date'];
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
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
                  ],
                ),
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: SizedBox(
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
                      Database.setEducation(data, widget.docID);
                      Navigator.of(context).pop();
                    },
                    child: const Text("Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

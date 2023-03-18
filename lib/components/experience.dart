import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/authentication.dart';
import '../services/database.dart';

class Experience extends StatefulWidget {
  const Experience({super.key, required this.docID});
  final String docID;

  @override
  State<Experience> createState() => _ExperienceState();
}

class _ExperienceState extends State<Experience> {
  TextEditingController _organizationController = TextEditingController();
  TextEditingController _positionController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _summaryController = TextEditingController();

  void getData() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = await Database.getExperience();
    QueryDocumentSnapshot<Map<String, dynamic>>? thisDoc;
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in docs) {
      if (doc.id == widget.docID) {
        thisDoc = doc;
      }
    }
    if (thisDoc == null)  throw Exception("Document not found.");

    _organizationController.text = thisDoc.data()['organization_name'];
    _positionController.text = thisDoc.data()['position'];
    _startDateController.text = thisDoc.data()['start_date'];
    _endDateController.text = thisDoc.data()['end_date'];
    _summaryController.text = thisDoc.data()['summary'];
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
        title: const Text('Experience'),
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
                      'Organization Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextField(
                      controller: _organizationController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Example- Nilavo Technologies ltd.",
                      ),
                    ),
                    const SizedBox(
                      height: 26.0,
                    ),
                    const Text(
                      'Position',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextField(
                      controller: _positionController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Example- Software Engineer",
                      ),
                    ),
                    const SizedBox(
                      height: 26.0,
                    ),
                    const Text(
                      'Start Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextField(
                      controller: _startDateController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "date/month/year",
                      ),
                    ),
                    const SizedBox(
                      height: 26.0,
                    ),
                    const Text(
                      'End Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextField(
                      controller: _endDateController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "date/month/year",
                      ),
                    ),
                    const SizedBox(
                      height: 26.0,
                    ),
                    const Text(
                      'Summary',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextField(
                      controller: _summaryController,
                      minLines: 3,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "A brief description of the works done",
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
                        'organization_name': _organizationController.text,
                        'position': _positionController.text,
                        'start_date': _startDateController.text,
                        'end_date': _endDateController.text,
                        'summary': _summaryController.text
                      };
                      Database.setExperience(data);
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
    ;
  }
}

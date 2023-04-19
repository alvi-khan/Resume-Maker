import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/authentication.dart';
import '../services/database.dart';

class Experience extends StatefulWidget {
  const Experience({super.key, this.docID, this.resumeID});
  final String? docID;
  final String? resumeID;

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
    if (widget.docID == null) return;

    DocumentSnapshot<Map<String, dynamic>> doc = await Database.getExperienceDoc(docID: widget.docID!);
    _organizationController.text = doc.data()!['organization_name'];
    _positionController.text = doc.data()!['position'];
    _startDateController.text = doc.data()!['start_date'];
    _endDateController.text = doc.data()!['end_date'];
    _summaryController.text = doc.data()!['summary'];
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
                        Database.deleteExperienceFromResume(widget.resumeID, widget.docID);
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
                          'organization_name': _organizationController.text,
                          'position': _positionController.text,
                          'start_date': _startDateController.text,
                          'end_date': _endDateController.text,
                          'summary': _summaryController.text
                        };
                        Database.setExperience(data, widget.docID, resumeID: widget.resumeID);
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
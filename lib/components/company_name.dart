import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/authentication.dart';
import '../services/database.dart';

class Company_name extends StatefulWidget {
  const Company_name({super.key, this.docID, this.resumeID});
  final String? docID;
  final String? resumeID;

  @override
  State<Company_name> createState() => _Company_nameState();
}

class _Company_nameState extends State<Company_name> {

  TextEditingController _companyNameController = TextEditingController();

  void getData() async {
    if (widget.docID == null) return;

    String doc = await Database.getCompanyNameDoc(resumeID: widget.docID!);
    _companyNameController.text = doc;
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
        title: const Text('Company Name'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
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
                      height: 15.0,
                    ),
                    TextField(
                      controller: _companyNameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Example- Optimizely",
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
                          Map<String, String> data = {
                            'company_name': _companyNameController.text
                          };
                          await Database.setCompanyName(data, widget.docID, resumeID: widget.docID);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
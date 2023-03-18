import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/database.dart';

class EditResume extends StatefulWidget {
  const EditResume({Key? key}) : super(key: key);

  @override
  State<EditResume> createState() => _EditResumeState();
}

class _EditResumeState extends State<EditResume> {

  void getData() async {
    Database.getEducation();
    // DocumentSnapshot? doc = await Database.getEducation();
    // if (doc == null) throw Exception("User Not Found!");
    // _nameController.text = doc['name'];
    // _mobileNumberController.text = doc['mobile'];
    // _linkedinUrlController.text = doc['linkedinurl'];
    // _experienceController.text = doc['experience'];
  }
  @override
  void initState() {
    getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditResumeScreen(),
    );
  }
}

class EditResumeScreen extends StatefulWidget {
  const EditResumeScreen({Key? key}) : super(key: key);

  @override
  State<EditResumeScreen> createState() => _EditResumeScreenState();
}

class _EditResumeScreenState extends State<EditResumeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Edit Resume')),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  //set border radius more than 50% of height and width to make circle
                ),
                color: Colors.white54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Education',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: RawMaterialButton(
                            fillColor: const Color(0xFF0069FE),
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            onPressed: () async {},
                            child: Text(
                              'Edit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 250,
                                    child: Text("TEST------------------------------------------------------------")
                                ),
                                Spacer(),
                                TextButton(
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  onPressed: (){

                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  //set border radius more than 50% of height and width to make circle
                ),
                color: Colors.white54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Skills',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: RawMaterialButton(
                            fillColor: const Color(0xFF0069FE),
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            onPressed: () async {},
                            child: Text(
                              'Edit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                      child: Column(
                        children: [
                          Text("About Skills"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  //set border radius more than 50% of height and width to make circle
                ),
                color: Colors.white54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Experience',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: RawMaterialButton(
                            fillColor: const Color(0xFF0069FE),
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            onPressed: () async {},
                            child: Text(
                              'Edit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                      child: Column(
                        children: [
                          Text("About Experience"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  //set border radius more than 50% of height and width to make circle
                ),
                color: Colors.white54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Achievement',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: RawMaterialButton(
                            fillColor: const Color(0xFF0069FE),
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            onPressed: () async {},
                            child: Text(
                              'Edit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                      child: Column(
                        children: [
                          Text("About Achievement"),
                        ],
                      ),
                    )
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







// const SizedBox(
// height: 50.0,
// ),
// Container(
// width: 150.0,
// child: RawMaterialButton(
//
// fillColor: const Color(0xFF0069FE),
// elevation: 0.0,
// padding: const EdgeInsets.symmetric(vertical: 20.0),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(12.0)
// ),
// onPressed: () {
//
// },
// child: const Text("Add Section",
// style: TextStyle(
// color: Colors.white,
// fontSize: 18.0,
// )),
// ),
// )
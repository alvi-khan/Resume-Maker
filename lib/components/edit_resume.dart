import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_pixel_pioneers/components/education.dart';
import 'package:the_pixel_pioneers/components/preview.dart';

import '../services/database.dart';

class EditResume extends StatefulWidget {
  const EditResume({Key? key, this.docID}) : super(key: key);
  final String? docID;

  @override
  State<EditResume> createState() => _EditResumeState();
}

class _EditResumeState extends State<EditResume> {

  List<QueryDocumentSnapshot<Map<String, dynamic>>> educationData = <QueryDocumentSnapshot<Map<String, dynamic>>>[];

  void getData() async {
    var results = await Database.getEducation(resumeID: widget.docID);
    setState(() => this.educationData = results);
  }
  @override
  void initState() {
    print("HERE" + widget.docID!);
    getData();
    super.initState();
  }


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
                          child: IconButton(
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => Education(resumeID: widget.docID)),
                              ).then((value) => getData()),
                              icon: Icon(Icons.add_circle_rounded, color: Color(0xFF6356C7),
                                size: 36,
                              )
                          )
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                      child: Column(
                        children: educationData.map((result) => Container(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 250,
                                  child: Text(result.data()['Degree'])
                              ),
                              Spacer(),
                              TextButton(
                                child: Text(
                                  "Edit",
                                  style: TextStyle(fontSize: 12),
                                ),
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => Education(docID: result.id)),
                                ).then((value) => getData()),
                              )
                            ],
                          ),
                        )).toList(),
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
                          child: IconButton(
                              onPressed: () => {},
                              icon: Icon(Icons.add_circle_rounded, color: Color(0xFF6356C7),
                                size: 36,
                              )
                          )
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
                          child: IconButton(
                              onPressed: () => {},
                              icon: Icon(Icons.add_circle_rounded, color: Color(0xFF6356C7),
                                size: 36,
                              )
                          )
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
                          child: IconButton(
                              onPressed: () => {},
                              icon: Icon(Icons.add_circle_rounded, color: Color(0xFF6356C7),
                                size: 36,
                              )
                          )
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
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: RawMaterialButton(
                  fillColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Preview()),
                  ),
                  child: Text(
                    'Preview',
                    style: TextStyle(
                        color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_pixel_pioneers/components/company_name.dart';
import 'package:the_pixel_pioneers/components/education.dart';
import 'package:the_pixel_pioneers/components/experience.dart';
import 'package:the_pixel_pioneers/components/skills.dart';
import 'package:the_pixel_pioneers/components/achievements.dart';
import 'package:the_pixel_pioneers/components/preview.dart';
import 'package:the_pixel_pioneers/components/profile.dart';

import '../services/database.dart';

class EditResume extends StatefulWidget {
  const EditResume({Key? key, this.docID}) : super(key: key);
  final String? docID;

  @override
  State<EditResume> createState() => _EditResumeState();
}

class _EditResumeState extends State<EditResume> {

  List<QueryDocumentSnapshot<Map<String, dynamic>>> educationData = <QueryDocumentSnapshot<Map<String, dynamic>>>[];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> skillsData = <QueryDocumentSnapshot<Map<String, dynamic>>>[];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> experienceData = <QueryDocumentSnapshot<Map<String, dynamic>>>[];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> achievementsData = <QueryDocumentSnapshot<Map<String, dynamic>>>[];
  String companyNameData = "No Name";

  void getData() async {
    var edu_results = await Database.getEducation(resumeID: widget.docID);
    var skills_results = await Database.getSkills(resumeID: widget.docID);
    var experience_results = await Database.getExperience(resumeID: widget.docID);
    var achievements_results = await Database.getAchievements(resumeID: widget.docID);
    var companyName_results = await Database.getCompanyName(resumeID: widget.docID);

    setState(() {
      educationData = edu_results;
      companyNameData = companyName_results;
      skillsData = skills_results;
      experienceData = experience_results;
      achievementsData = achievements_results;
    });
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
        title: const Center(child: Text('Edit Resume')),
        leading: BackButton(
          onPressed: () async {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Profile()),
            );
          }
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  //set border radius more than 50% of height and width to make circle
                ),
                color: Colors.white54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'Company Name',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: SizedBox(
                              width: 250,
                              child: Text(companyNameData)
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          child: const Text(
                            "Edit",
                            style: TextStyle(fontSize: 12),
                          ),
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Company_name(docID: widget.docID)),
                          ).then((value) => getData()),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
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
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Education',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: IconButton(
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => Education(resumeID: widget.docID)),
                              ).then((value) => getData()),
                              icon: const Icon(Icons.add_circle_rounded, color: Color(0xFF6356C7),
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
                              const Spacer(),
                              TextButton(
                                child: const Text(
                                  "Edit",
                                  style: TextStyle(fontSize: 12),
                                ),
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => Education(docID: result.id, resumeID: widget.docID,)),
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
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Skills',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: IconButton(
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => Skills(resumeID: widget.docID)),
                                ).then((value) => getData()),
                                icon: const Icon(Icons.add_circle_rounded, color: Color(0xFF6356C7),
                                  size: 36,
                                )
                            )
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                      child: Column(
                        children: skillsData.map((result) => Container(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 250,
                                  child: Text(result.data()['description'])
                              ),
                              const Spacer(),
                              TextButton(
                                child: const Text(
                                  "Edit",
                                  style: TextStyle(fontSize: 12),
                                ),
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => Skills(docID: result.id, resumeID: widget.docID,)),
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
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Experience',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: IconButton(
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => Experience(resumeID: widget.docID)),
                                ).then((value) => getData()),
                                icon: const Icon(Icons.add_circle_rounded, color: Color(0xFF6356C7),
                                  size: 36,
                                )
                            )
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                      child: Column(
                        children: experienceData.map((result) => Container(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 250,
                                  child: Text(result.data()['position'] + " at " + result.data()['organization_name'])
                              ),
                              const Spacer(),
                              TextButton(
                                child: const Text(
                                  "Edit",
                                  style: TextStyle(fontSize: 12),
                                ),
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => Experience(docID: result.id, resumeID: widget.docID,)),
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
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Achievements',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: IconButton(
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => Achievements(resumeID: widget.docID)),
                                ).then((value) => getData()),
                                icon: const Icon(Icons.add_circle_rounded, color: Color(0xFF6356C7),
                                  size: 36,
                                )
                            )
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                      child: Column(
                        children: achievementsData.map((result) => Container(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 250,
                                  child: Text(result.data()['awards'] + " in " + result.data()['event'])
                              ),
                              const Spacer(),
                              TextButton(
                                child: const Text(
                                  "Edit",
                                  style: TextStyle(fontSize: 12),
                                ),
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => Achievements(docID: result.id, resumeID: widget.docID,)),
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
                  child: const Text(
                    'Preview',
                    style: TextStyle(
                        color: Colors.white,
                      fontSize: 17,
                      // fontWeight: FontWeight.bold
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
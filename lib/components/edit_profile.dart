import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_pixel_pioneers/services/database.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _linkedinUrlController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();
  TextEditingController _professionController = TextEditingController();

  void getData() async {
    DocumentSnapshot? doc = await Database.getProfile();
    if (doc == null) throw Exception("User Not Found!");
    _nameController.text = doc['name'];
    _mobileNumberController.text = doc['mobile'];
    _linkedinUrlController.text = doc['linkedinurl'];
    _experienceController.text = doc['experience'];
    _professionController.text = doc['profession'];
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
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Name",
                    ),
                  ),
                  const SizedBox(
                    height: 26.0,
                  ),
                  TextField(
                    controller: _mobileNumberController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Mobile Number",
                    ),
                  ),
                  const SizedBox(
                    height: 26.0,
                  ),
                  TextField(
                    controller: _professionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Profession",
                    ),
                  ),
                  const SizedBox(
                    height: 26.0,
                  ),
                  TextField(
                    controller: _linkedinUrlController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Address",
                    ),
                  ),
                  const SizedBox(
                    height: 26.0,
                  ),
                  TextField(
                    controller: _linkedinUrlController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "LinkedIn URL",
                    ),
                  ),
                  const SizedBox(
                    height: 26.0,
                  ),
                  TextField(
                    controller: _experienceController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Experience",
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: RawMaterialButton(
              fillColor: const Color(0xFF6346F6),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              onPressed: () async {
                Map<String, String> data = {
                  'name': _nameController.text,
                  'mobile': _mobileNumberController.text,
                  'linkedinurl': _linkedinUrlController.text,
                  'experience': _experienceController.text
                };
                Database.setProfile(data);
                Navigator.of(context).pop();
              },
              child: const Text(
                "Update",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

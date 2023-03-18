import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditProfileScreen(),
    );
  }
}


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _mobileNumberController = TextEditingController();
    TextEditingController _linkedinUrlController = TextEditingController();
    TextEditingController _experienceController = TextEditingController();


    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: const Color(0xFF6346F6),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)
                ),
                onPressed: () async {
                  QueryDocumentSnapshot? flag;
                  await FirebaseFirestore.instance.collection('profile').get().then((QuerySnapshot querySnapshot) async {
                    querySnapshot.docs.forEach((doc) {
                      if(doc["mobile"] == _mobileNumberController.text){
                        flag = doc;
                      }
                    });
                  });
                  if(flag!=null){
                    flag?.reference.update({'name': _nameController.text, 'mobile': _mobileNumberController.text,
                      'linkedinurl': _linkedinUrlController.text, 'experience': _experienceController.text});
                  }
                  else{
                    FirebaseFirestore.instance
                        .collection('profile')
                        .add({'name': _nameController.text, 'mobile': _mobileNumberController.text,
                              'linkedinurl': _linkedinUrlController.text, 'experience': _experienceController.text});
                  }
                },
                child: const Text("Update",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

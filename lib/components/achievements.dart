import 'package:flutter/material.dart';

import '../services/authentication.dart';
import '../services/database.dart';

class Achievements extends StatefulWidget {
  const Achievements({super.key});

  @override
  State<Achievements> createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  TextEditingController _eventController = TextEditingController();
  TextEditingController _awardController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
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
                      'Occasion',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextField(
                      controller: _occasionController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Example- IUT CodeRush",
                      ),
                    ),
                    const SizedBox(
                      height: 26.0,
                    ),
                    const Text(
                      'Awards',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextField(
                      controller: _awardController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Example- First runners up",
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
                        'event': _eventController.text,
                        'awards': _awardController.text
                      };
                      Database.setAchievements(data);
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

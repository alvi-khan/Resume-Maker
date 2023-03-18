import 'package:flutter/material.dart';
import 'package:the_pixel_pioneers/templates/template1.dart';

class Preview extends StatefulWidget {
  const Preview({Key? key}) : super(key: key);

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Templates", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
            ),
            Row(
              children: [
                Container(color: Colors.grey, width: 40, height: 50),
                SizedBox(width: 20),
                Container(color: Colors.grey, width: 40, height: 50),
                SizedBox(width: 20),
                Container(color: Colors.grey, width: 40, height: 50),
                SizedBox(width: 20),
                Container(color: Colors.grey, width: 40, height: 50, child: IconButton(onPressed: () => {}, icon: Icon(Icons.add))),
              ],
            ),
            Text("Preview"),
            Image(image: AssetImage("assets/images/resume_sample.jpg")),
            TextButton(
                onPressed: () => Template1().generate(),
                child: Text("Download"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent.shade400),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                )
            ),
          ],
        ),
      ),
    );
  }
}

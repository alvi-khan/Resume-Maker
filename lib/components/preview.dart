import 'package:flutter/material.dart';
import 'package:the_pixel_pioneers/templates/template1.dart';
import 'package:the_pixel_pioneers/templates/template2.dart';

import '../templates/template.dart';

class Preview extends StatefulWidget {
  const Preview({Key? key}) : super(key: key);

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  Template template = Template1();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Templates", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  // ElevatedButton(
                  //   onPressed: (){},
                  //   style: ElevatedButton.styleFrom(
                  //       padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 30.0),
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(10.0)
                  //       ),
                  //   ),
                  //   child: Text(""),
                  // )
                  Container(color: Colors.grey, width: 40, height: 70),
                  SizedBox(width: 20),
                  Container(color: Colors.grey, width: 40, height: 50),
                  SizedBox(width: 20),
                  Container(color: Colors.grey, width: 40, height: 50),
                  SizedBox(width: 20),
                  Container(color: Colors.grey, width: 40, height: 50, child: IconButton(onPressed: () => {}, icon: Icon(Icons.add))),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Text("Preview", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 15),
                child: Image(image: AssetImage("assets/images/resume_sample.jpg"),),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextButton(
                    onPressed: () => template.generate(),
                    child: Text("Download"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent.shade700),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

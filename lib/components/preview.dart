import 'package:flutter/material.dart';

class Preview extends StatefulWidget {
  const Preview({Key? key}) : super(key: key);

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 36.0),
      child: Column(
        children: [
          Text("Templates"),
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
              onPressed: () => {},
              child: Text("Download"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent.shade400),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              )
          ),
        ],
      ),
    );
  }
}

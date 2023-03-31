import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:the_pixel_pioneers/templates/template1.dart';
import 'package:the_pixel_pioneers/templates/template2.dart';

import '../templates/template.dart';
import 'notification.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Preview extends StatefulWidget {
  const Preview({Key? key}) : super(key: key);

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  Template template = Template1();

  @override
  void initState() {
    super.initState();
    Notification1.initialize(flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Templates",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 13,
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
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/template3.jpg"),
                              fit: BoxFit.cover),
                        ),
                        child: SizedBox(
                            width: 40,
                            height: 70,
                            child: TextButton(
                                onPressed: () => template = Template1(),
                                child: Text(""))),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Template 1",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),

                  SizedBox(width: 20),
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/template4.jpg"),
                              fit: BoxFit.cover),
                        ),
                        child: SizedBox(
                            width: 40,
                            height: 70,
                            child: TextButton(
                                onPressed: () => template = Template2(),
                                child: Text(""))),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Template 2",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    children: [
                      Container(
                        color: Colors.grey,
                        child: SizedBox(
                            width: 40,
                            height: 70,
                            child: IconButton(
                                onPressed: () => {}, icon: Icon(Icons.add))),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Add",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Preview",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 15),
                child: Image(
                  image: AssetImage("assets/images/template1.jpg"),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextButton(
                    onPressed: () {
                      template.generate();
                      Notification1.showBigTextNotification(
                          title: "Status",
                          body: "Download Complete",
                          fln: flutterLocalNotificationsPlugin);
                    },
                    child: Text("Download"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.greenAccent.shade700),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

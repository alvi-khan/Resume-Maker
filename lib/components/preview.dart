import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:the_pixel_pioneers/templates/template1.dart';
import 'package:the_pixel_pioneers/templates/template2.dart';
import 'package:flutter_super_html_viewer/flutter_super_html_viewer.dart';

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
  String htmlData = "";

  void getHtmlData() async {
    String data = await template.getHtml();
    setState(() => htmlData = data);
  }

  @override
  void initState() {
    super.initState();
    Notification1.initialize(flutterLocalNotificationsPlugin);
    getHtmlData();
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
                            onPressed: () {
                              setState(() => template = Template1());
                              getHtmlData();
                            },
                            child: Text(""),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Template 1",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
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
                            onPressed: () {
                              setState(() => template = Template2());
                              getHtmlData();
                            },
                            child: Text(""),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Template 2",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
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
                            fontSize: 12, fontWeight: FontWeight.bold),
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
                child: htmlData == ""
                    ? Image(
                        image: AssetImage("assets/images/template1.jpg"),
                      )
                    : ResumePreview(htmlData: htmlData),
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

class ResumePreview extends StatelessWidget {
  const ResumePreview({
    super.key,
    required this.htmlData,
  });

  final String htmlData;

  // scrollable view in two directions allows inner container to be 'bigger' than screen
  // this results in the generated html  filling the 'bigger' screen properly
  // transform zooms out to fit the actual screen
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 300,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: 1920,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Transform(
              transform: Matrix4.identity() *
                  (MediaQuery.of(context).size.width / 1180),
              child: SizedBox(
                width: 1080,
                child: HtmlContentViewer(htmlContent: htmlData),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

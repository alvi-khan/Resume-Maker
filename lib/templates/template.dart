import 'dart:io';

import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';

abstract class Template {
  String getHtml();

  void generate() async {
    Directory? directory = await getExternalStorageDirectory();
    if  (directory == null) {
      throw Exception("Unable to access local storage.");
    }

    var targetPath = directory.path;
    Directory(targetPath).createSync(recursive: true);
    var targetFileName = "test-pdf.pdf";

    File output = await FlutterHtmlToPdf.convertFromHtmlContent(getHtml(), targetPath, targetFileName);
    output.createSync(recursive: true);
  }
}
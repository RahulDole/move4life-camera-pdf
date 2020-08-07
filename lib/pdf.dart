import 'dart:io';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFWidget extends StatelessWidget {
  final List<String> imageArray;

  PDFWidget({Key key, this.imageArray}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final pw.Document pdf = pw.Document(title: 'Agreement', author: "");

    imageArray.forEach((String imageElement) {
      final image = PdfImage.file(
        pdf.document,
        bytes: File(imageElement).readAsBytesSync(),
      );

      pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build:(pw.Context context) {
          return pw.Container(
            width: double.infinity,
            child: pw.FittedBox(child: pw.Image(image), fit: pw.BoxFit.fill)
          );
        }
      ));
    });

    return Container(
      height: 600,
      child: PdfPreview(
        allowSharing: false,
        allowPrinting: false,
        canChangePageFormat: false,
        build: (_) => pdf.save(),
      ),
    );
  }
}
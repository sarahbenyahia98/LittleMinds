import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:project_v1/models/pdf_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatefulWidget {
  final PdfModel pdfModel; // Replace with your Firebase Storage download URL

  const PdfViewerPage({Key? key, required this.pdfModel}) : super(key: key);

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.pdfModel.pdfName),
      ),
      body: SfPdfViewer.network(
        widget.pdfModel.pdfUrl,
        key: _pdfViewerKey,
      ),
    );
  }
}

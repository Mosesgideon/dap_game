import 'package:flutter/material.dart';
import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatelessWidget {
  const PdfViewer({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        tittleText: 'View document',
      ),
      body: SizedBox(
          child: SfPdfViewer.network(
        // initialZoomLevel: 10,
        canShowScrollStatus: false,
        pageLayoutMode: PdfPageLayoutMode.continuous,
        url,
      )),
    );
  }
}

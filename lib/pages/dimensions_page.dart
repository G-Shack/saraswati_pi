import 'package:flutter/material.dart';
import 'package:saraswati_pi/services/pdf_service.dart';
import 'package:saraswati_pi/widgets/table_template.dart';
import 'package:saraswati_pi/widgets/table_header2.dart';

class DimensionsPage extends StatelessWidget {
  final String billNo;
  final String dimension;
  DimensionsPage({super.key, required this.dimension, required this.billNo});
  final PdfService pdfService = PdfService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dimension ($dimension)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bill No: $billNo', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                TableTemplate(dimension: dimension),
                TableHeader(dimension: dimension),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bill = await pdfService.generatePdf(billNo);
          pdfService.savePdfFile("BillNO$billNo", bill);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

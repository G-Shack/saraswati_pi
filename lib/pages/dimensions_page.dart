import 'package:flutter/material.dart';
import 'package:saraswati_pi/widgets/table_template.dart';
import 'package:saraswati_pi/widgets/table_header2.dart';

class DimensionsPage extends StatelessWidget {
  final String billNo;
  final String dimension;
  const DimensionsPage(
      {super.key, required this.dimension, required this.billNo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dimension ($dimension)'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
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
    );
  }
}

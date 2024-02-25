import 'package:flutter/material.dart';
import 'package:saraswati_pi/widgets/table_header.dart';
import 'package:saraswati_pi/widgets/table_header2.dart';

class DimensionsPageMm extends StatelessWidget {
  const DimensionsPageMm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dimension (mm)'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                TableTemplate(),
                TableHeader(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

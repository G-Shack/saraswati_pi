import 'package:flutter/material.dart';

class DimensionsPageMm extends StatefulWidget {
  const DimensionsPageMm({super.key});

  @override
  State<DimensionsPageMm> createState() => _DimensionsPageMmState();
}

class _DimensionsPageMmState extends State<DimensionsPageMm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dimension (mm)'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
      ),
    );
  }
}

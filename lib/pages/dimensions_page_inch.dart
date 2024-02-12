import 'package:flutter/material.dart';

class DimensionsPageInch extends StatefulWidget {
  const DimensionsPageInch({super.key});

  @override
  State<DimensionsPageInch> createState() => _DimensionsPageInchState();
}

class _DimensionsPageInchState extends State<DimensionsPageInch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dimension (inch)'),
      ),
    );
  }
}

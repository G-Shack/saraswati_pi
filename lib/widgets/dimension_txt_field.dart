import 'package:flutter/material.dart';

class DimensionTxtField extends StatelessWidget {
  final TextEditingController controller;

  const DimensionTxtField({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.only(left: 6, right: 6),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.datetime,
        ),
      ),
    );
  }
}

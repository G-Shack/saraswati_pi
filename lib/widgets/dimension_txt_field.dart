import 'package:flutter/material.dart';

class DimensionTxtField extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  DimensionTxtField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TableCell(
        child: Padding(
      padding: EdgeInsets.only(left: 6, right: 6),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.datetime,
      ),
    ));
  }
}

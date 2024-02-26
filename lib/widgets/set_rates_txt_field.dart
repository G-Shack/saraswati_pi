import 'package:flutter/material.dart';

class SetRatesTxtField extends StatelessWidget {
  String name;
  TextEditingController controller = TextEditingController();
  SetRatesTxtField({super.key, required this.controller, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
              labelText: name,
              labelStyle: const TextStyle(fontSize: 18),
              border: const OutlineInputBorder()),
          style: const TextStyle(fontSize: 18),
          keyboardType: TextInputType.datetime,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

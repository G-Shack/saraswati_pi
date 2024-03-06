import 'package:flutter/material.dart';

class SetRatesTxtField extends StatelessWidget {
  String name1;
  String name2;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  SetRatesTxtField(
      {super.key,
      required this.controller1,
      required this.controller2,
      required this.name1,
      required this.name2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller1,
                decoration: InputDecoration(
                    labelText: name1,
                    labelStyle: const TextStyle(fontSize: 18),
                    border: const OutlineInputBorder()),
                style: const TextStyle(fontSize: 14),
                keyboardType: TextInputType.datetime,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextField(
                controller: controller2,
                decoration: InputDecoration(
                    labelText: name2,
                    labelStyle: const TextStyle(fontSize: 18),
                    border: const OutlineInputBorder()),
                style: const TextStyle(fontSize: 14),
                keyboardType: TextInputType.datetime,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class DimensionButton extends StatefulWidget {
  String text;
  DimensionButton({super.key, required this.text});

  @override
  State<DimensionButton> createState() => _DimensionButtonState(text: text);
}

class _DimensionButtonState extends State<DimensionButton> {
  String text;
  _DimensionButtonState({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 90,
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
        onTap: () {},
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DimensionButton extends StatelessWidget {
  final String btnTxt;
  final void Function()? fun;
  const DimensionButton({super.key, required this.btnTxt, required this.fun});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        fun!();
      },
      child: Container(
        height: 45,
        width: 90,
        decoration: BoxDecoration(
          color: Colors.amberAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
            child: Text(
          btnTxt,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
        )),
      ),
    );
  }
}

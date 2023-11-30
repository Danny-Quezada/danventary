import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  String text;
  double fontSize;
  VoidCallback function;
  Color color;
  double rounded;
  Size size;
  ButtonWidget(
      {super.key,
      required this.text,
      required this.size,
      required this.color,
      required this.rounded,
      required this.function,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: TextButton.styleFrom(
          backgroundColor: color,
          fixedSize: size,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(rounded)))),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
      ),
    );
  }
}

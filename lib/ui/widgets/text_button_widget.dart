import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  String text;
  double fontSize;
  VoidCallback function;
  Color color;

  TextButtonWidget(
      {super.key,
      required this.text,
      required this.color,
      required this.fontSize,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              fontFamily: "Karla"),
        ));
  }
}

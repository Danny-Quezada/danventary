import 'package:flutter/material.dart';
import 'package:inventory_control/ui/styles/styles.dart';

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
      style: TextButton.styleFrom(
        foregroundColor: color
      ),
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

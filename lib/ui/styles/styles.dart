import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Style{
  static TextStyle h1Style=const TextStyle(fontWeight: FontWeight.w900,fontSize: 15);
  static TextStyle h2Style=const TextStyle(fontSize: 13);
  static TextStyle h2RedStyle=const TextStyle(fontSize: 13,color: Colors.red,fontWeight: FontWeight.w600);
  static TextStyle textFormStyle=TextStyle(color: Colors.grey.shade300);
  static TextStyle textInput=TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.bold,fontSize: 15);
  static TextStyle h3StyleBoldBlue= TextStyle(color: Colors.blue.shade500,fontWeight: FontWeight.bold, fontSize: 11);
  static TextStyle h3StyleBold= TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.bold, fontSize: 11);
  static Color dashboardColor=Colors.purpleAccent;
  static Color productColor=CupertinoColors.systemYellow;
  static Color saleColor=CupertinoColors.activeGreen;
  static Color purchaseColor=CupertinoColors.systemBlue;
  static Color greyColor= CupertinoColors.systemGrey;

  static Color categoryColor=CupertinoColors.systemMint;
}
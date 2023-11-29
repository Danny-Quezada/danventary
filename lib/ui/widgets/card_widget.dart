import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inventory_control/domain/models/product.dart';
import 'package:inventory_control/ui/styles/styles.dart';

class CardWidget extends StatelessWidget {
  String? image;
  VoidCallback function;
  String title;
  String? description;
  int? quantity;
  CardWidget({required this.function, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(

        elevation: 0,
        margin: const EdgeInsets.only(top: 10),
        child: ListTile(
          leading:image!=null ?  Image.file(File(image!)) : null,
          onTap: function,
          title: Text(
            title,
            style: Style.h1Style,
          ),
          subtitle: description != null
              ? Text(
                  description!,
                  style: Style.h2Style,
                )
              : null,
          trailing: quantity != null
              ? CircleAvatar(
                  radius: 12,
                  child: Text(
                    quantity!.toString(),
                    style: Style.h1Style,
                  ),
                )
              : null,
        ));
  }
}

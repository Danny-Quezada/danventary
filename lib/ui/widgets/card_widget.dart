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
  String? status;
  String? category;
  CardWidget({required this.function, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        margin: const EdgeInsets.only(top: 16),
        child: ListTile(
          hoverColor: Style.productColor,
          leading: image != null
              ? Image.file(
                  File(image!),
                  fit: BoxFit.contain,
                )
              : null,
          onTap: function,
          title: Text(
            title,
            style: Style.h1Style,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 3,
              ),
              description != null
                  ? Text(
                      description!,
                      style: Style.h2Style,
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 5,
              ),
              category != null
                  ? RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Categoría: ', style: Style.h3StyleBoldBlue),
                        TextSpan(text: '$category', style: Style.h3Style),
                      ]),
                    )
                  : const SizedBox()
            ],
          ),
          trailing: quantity != null
              ? CircleAvatar(
                  foregroundColor: Colors.white,
                  backgroundColor: Style.productColor,
                  radius: quantity! > 99 ? 18 : 12,
                  child: Text(quantity!.toString(), style: Style.h1Style),
                )
              : null,
        ));
  }
}

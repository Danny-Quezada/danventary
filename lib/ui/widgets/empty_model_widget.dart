import 'package:flutter/cupertino.dart';
import 'package:inventory_control/ui/styles/styles.dart';

class EmptyModelWidget extends StatelessWidget {
  String model;
  EmptyModelWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/sadBoy.png",
          width: size.width * .64,
          height: size.height * .3,
        ),
        SizedBox(
            child: Text(
          "No hay productos por el momento, agrega $model",
          style: Style.h2RedStyle,
        ))
      ],
    );
  }
}

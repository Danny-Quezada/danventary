import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_control/domain/models/product.dart';
import 'package:inventory_control/provider/product_provider.dart';
import 'package:inventory_control/ui/styles/styles.dart';
import 'package:inventory_control/ui/widgets/card_widget.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "FABProduct",
        onPressed: () {},
        backgroundColor: Style.productColor,
        child: const Icon(CupertinoIcons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: productProvider.read(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                List<Product> products = snapshot.data!;
                if (products.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/sadBoy.png",
                          width: size.width * .64,
                          height: size.height * .3,
                        ),
                        SizedBox(
                            child: Text(
                          "No hay productos por el momento, agrega productos.",
                          style: Style.h2RedStyle,
                        ))
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    CardWidget cardWidget = CardWidget(
                        function: () {}, title: products[index].productName);
                    cardWidget.description = products[index].description;
                    cardWidget.quantity = products[index].quantity;
                    cardWidget.image =
                        products[index].productImages![0].urlImage;
                    return cardWidget;
                  },
                );
              } else if (snapshot.hasError) {
                return Container(
                  color: Colors.black,
                  width: 10,
                  height: 20,
                );
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}

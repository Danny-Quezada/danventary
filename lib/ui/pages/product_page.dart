import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_control/domain/models/product.dart';
import 'package:inventory_control/provider/product_provider.dart';
import 'package:inventory_control/ui/pages/create_product_page.dart';
import 'package:inventory_control/ui/styles/styles.dart';
import 'package:inventory_control/ui/widgets/card_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "FABProduct",
        onPressed: () async {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: CreateProductPage(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
          productProvider.imagesProducts = [];
        },
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
                  return const Center(
                    child: EmptyProductWidget(),
                  );
                }
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    CardWidget cardWidget =
                        createProductWidget(context, products[index]);
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

  CardWidget createProductWidget(BuildContext context, Product product) {
    CardWidget cardWidget = CardWidget(
        function: () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: CreateProductPage(product: product),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        },
        title: product.productName);
    cardWidget.description = product.description;
    cardWidget.quantity = product.quantity;
    cardWidget.image = product.productImages!.isEmpty
        ? null
        : product.productImages![0].urlImage;
    return cardWidget;
  }
}

class EmptyProductWidget extends StatelessWidget {
  const EmptyProductWidget({
    super.key,
  });

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
          "No hay productos por el momento, agrega productos.",
          style: Style.h2RedStyle,
        ))
      ],
    );
  }
}

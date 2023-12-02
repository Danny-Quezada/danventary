import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_control/domain/models/product.dart';

import 'package:inventory_control/provider/product_provider.dart';
import 'package:inventory_control/ui/pages/category_page.dart';
import 'package:inventory_control/ui/pages/create_product_page.dart';
import 'package:inventory_control/ui/styles/styles.dart';
import 'package:inventory_control/ui/widgets/card_widget.dart';
import 'package:inventory_control/ui/widgets/empty_model_widget.dart';
import 'package:inventory_control/ui/widgets/search_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: CategoryPage(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
                productProvider.imagesProducts = [];
              },
              icon: const Icon(Icons.category_outlined))
        ],
        title: searchBar(
            function: (value) {},
            controller: searchController,
            height: 35,
            padding: 0,
            iconColor: const Color(0xffABA5A5),
            backgroundColor: const Color(0xFFf2f2f2)),
      ),
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
      body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 2), child: ProductList()),
    );
  }


}

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    productProvider.read();

    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        if (value.products == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (value.products!.isEmpty) {
            return Center(child: EmptyModelWidget(model: "productos."));
          }
          List<Product> products = value.products!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              CardWidget cardWidget = createProductWidget(
                  context, products[(products.length - 1) - index]);
              return cardWidget;
            },
          );
        }
      },
    );
  }

  CardWidget createProductWidget(BuildContext context, Product product) {
    List<String> images = [];
    product.productImages!.forEach((element) {
      images.add(element.urlImage ?? "");
    });
    CardWidget cardWidget = CardWidget(
        function: () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: CreateProductPage(product: product, images: images),
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
        cardWidget.category=product.category!.categoryName;
    return cardWidget;
  }
}

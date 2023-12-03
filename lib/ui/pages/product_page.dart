import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:inventory_control/domain/models/product.dart';

import 'package:inventory_control/provider/product_provider.dart';
import 'package:inventory_control/ui/pages/category_page.dart';
import 'package:inventory_control/ui/pages/create_product_page.dart';
import 'package:inventory_control/ui/styles/styles.dart';
import 'package:inventory_control/ui/widgets/card_widget.dart';
import 'package:inventory_control/ui/widgets/empty_model_widget.dart';
import 'package:inventory_control/ui/widgets/flushbar_widget.dart';
import 'package:inventory_control/ui/widgets/search_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  TextEditingController searchController = TextEditingController();

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
              icon: Icon(
                Icons.category_outlined,
                color: Style.categoryColor,
              ))
        ],
        title: searchBar(
            function: (value) {
              productProvider.changeFind(value);
            },
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
      body: MessageListener<ProductProvider>(
        showError: (e) {
          flushbarWidget(
              context: context, title: "Error:", message: e, error: true);
        },
        showInfo: (e) {
          flushbarWidget(context: context, title: "Exito:", message: e);
        },
        child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 2), child: ProductList()),
      ),
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.read();
  }

  @override
  Widget build(BuildContext context) {
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

          List<Product> products = value.products!
              .where((element) =>
                  element.productName.toLowerCase().contains(value.name))
              .toList();
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
    cardWidget.category = product.category!.categoryName;
    return cardWidget;
  }
}

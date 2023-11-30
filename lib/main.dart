import 'package:flutter/material.dart';
import 'package:inventory_control/domain/interfaces/icategory_model.dart';
import 'package:inventory_control/domain/interfaces/iproduct_model.dart';
import 'package:inventory_control/infraestructure/category_repository.dart';
import 'package:inventory_control/infraestructure/product_repository.dart';
import 'package:inventory_control/provider/category_provider.dart';
import 'package:inventory_control/provider/product_provider.dart';
import 'package:inventory_control/ui/pages/principal_page.dart';
import 'package:inventory_control/ui/pages/product_page.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(MultiProvider(
    providers: [
      Provider<IProductModel>(
        create: (_) => ProductRepository(),
      ),
      ChangeNotifierProvider<ProductProvider>(
        create: (context) => ProductProvider(
            iProductModel: Provider.of<IProductModel>(context, listen: false)),
      ),
      Provider<ICategoryModel>(
        create: (_) => CategoryRepository(),
      ),
      ChangeNotifierProvider<CategoryProvider>(
        create: (context) => CategoryProvider(
            iCategoryModel:
                Provider.of<ICategoryModel>(context, listen: false)),
      ),
    ],
    child: MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => PrincipalPage(),
        "ProductPage": (context) => ProductPage()
      },
      themeMode: ThemeMode.light,
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      theme: ThemeData(
        canvasColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
          floatingActionButtonTheme:
              const FloatingActionButtonThemeData(elevation: 0),
          fontFamily: "Inter",
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.black,
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.white
          )),
    ),
  ));
}

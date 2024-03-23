import 'package:flutter/material.dart';
import 'package:inventory_control/domain/interfaces/icategory_model.dart';
import 'package:inventory_control/domain/interfaces/imoney_flow_model.dart';
import 'package:inventory_control/domain/interfaces/iproduct_model.dart';
import 'package:inventory_control/infraestructure/category_repository.dart';
import 'package:inventory_control/infraestructure/money_flow_repository.dart';
import 'package:inventory_control/infraestructure/product_repository.dart';
import 'package:inventory_control/provider/category_provider.dart';
import 'package:inventory_control/provider/money_flow_provider.dart';
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
      Provider<IMoneyFlowModel>(
        create: (_) => MoneyFlowRepository(),
      ),
      ChangeNotifierProvider<MoneyFlowProvider>(
        create: (context) => MoneyFlowProvider(
            iMoneyFlowModel:
                Provider.of<IMoneyFlowModel>(context, listen: false)),
      ),
    ],
    child: MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => PrincipalPage(),
        "ProductPage": (context) => ProductPage()
      },
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(useMaterial3: true,brightness: Brightness.dark,fontFamily: "Inter",),
      theme: ThemeData(
          cardTheme: const CardTheme(elevation: 2),
          canvasColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          floatingActionButtonTheme:
              const FloatingActionButtonThemeData(elevation: 0),
          fontFamily: "Inter",
         shadowColor: Colors.grey.shade300,
          
          appBarTheme: const AppBarTheme(
              foregroundColor: Colors.black,
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.white)),
    ),
  ));
}

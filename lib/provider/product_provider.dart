import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:inventory_control/domain/interfaces/icategory_model.dart';
import 'package:inventory_control/domain/interfaces/iproduct_model.dart';
import 'package:inventory_control/domain/models/product.dart';
import 'package:collection/collection.dart';

class ProductProvider extends ChangeNotifier with MessageNotifierMixin {
  List<Product> products = [];
  IProductModel iProductModel;

  ProductProvider({required this.iProductModel});

  Future<void> createProduct(Product T) async {
    try {
      int productId = await iProductModel.create(T);
      T.productId = productId;
      products.add(T);
      notifyInfo("Producto: ${T.productName} ha sido guardado correctamente.");
      notifyListeners();
    } catch (e) {
      notifyError(e);
    }
  }

  Future<List<Product>> read() async {
    try {
      if (products.isEmpty) {
        products = await iProductModel.read();
      }
      return products;
    } catch (e) {
      notifyError(e);
      return [];
    }
  }

  Future<void> delete(Product T, int index) async {
    try {
      String productName = await iProductModel.delete(T);
      T.status = 0;
      products[index] = T;
      notifyListeners();
      notifyInfo("Producto: $productName ha sido dado de baja");
    } catch (e) {
      notifyError(e);
    }
  }

  Future<void> update(Product T, int index) async {
    try {
      String productName = await iProductModel.update(T);
      products[index] = T;
      notifyListeners();
      notifyInfo("Producto: $productName ha sido actualizado");
    } catch (e) {
      notifyError(e);
    }
  }
}

import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:inventory_control/domain/interfaces/iproduct_model.dart';
import 'package:inventory_control/domain/models/product.dart';
import 'package:inventory_control/domain/models/product_category.dart';

class ProductProvider extends ChangeNotifier with MessageNotifierMixin {
  List<String> imagesProducts = [];
  List<Product>? products;
  IProductModel iProductModel;
  ProductCategory? productCategory;
  String name = "";

  changeProductCategory(ProductCategory category) {
    productCategory = category;
    notifyListeners();
  }

  ProductProvider({required this.iProductModel});

  changeList(List<String> images) async {
    imagesProducts.addAll(images);
    notifyListeners();
  }

  Future<int> createProduct(Product T) async {
    try {
      int productId = await iProductModel.create(T);
      T.productId = productId;
      products?.add(T);
      notifyInfo("Producto: ${T.productName} ha sido guardado correctamente.");
      notifyListeners();
      return productId;
    } catch (e) {
      notifyError(e);
      throw Exception(e);
    }
  }

  changeFind(String findName) {
    name = findName;
    notifyListeners();
  }

  Future<List<Product>?> read() async {
    try {
      if (products == null) {
        products = await iProductModel.read();
        notifyListeners();
      }
      return products;
    } catch (e) {
      notifyError(e);
      return [];
    }
  }

  Future<void> delete(Product T) async {
    try {
      String productName = await iProductModel.delete(T);
      T.status = 0;
      int index =
          products!.indexWhere((element) => element.productId == T.productId);
      products![index] = T;

      notifyListeners();
      notifyInfo("Producto: $productName ha sido dado de baja");
    } catch (e) {
      notifyError(e);
    }
  }

  Future<void> update(Product T) async {
    try {
      String productName = await iProductModel.update(T);
      int index =
          products!.indexWhere((element) => element.productId == T.productId);
      products![index] = T;
      notifyListeners();
      notifyInfo("Producto: $productName ha sido actualizado");
    } catch (e) {
      notifyError(e);
    }
  }
}

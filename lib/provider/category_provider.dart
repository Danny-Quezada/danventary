import 'package:flutter/foundation.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:inventory_control/domain/interfaces/icategory_model.dart';
import 'package:inventory_control/domain/models/product_category.dart';

class CategoryProvider extends ChangeNotifier with MessageNotifierMixin{
  List<ProductCategory>? categories;
  ICategoryModel iCategoryModel;

  CategoryProvider({required this.iCategoryModel});
   

  Future<void> createCategory(ProductCategory T) async {
    try {
      int categoryId = await iCategoryModel.create(T);
      T.categoryId = categoryId;
      categories?.add(T);
      notifyInfo("Categoria: ${T.categoryName} ha sido guardado correctamente.");
      notifyListeners();
    } catch (e) {
      notifyError(e);
    }
  }

  Future<List<ProductCategory>?> read() async {
    try {
      if (categories ==null) {
        categories = await iCategoryModel.read();
        notifyListeners();
      }
      return categories;
    } catch (e) {
      notifyError(e);
      return [];
    }
  }

  Future<void> delete(ProductCategory T) async {
    try {
      String categoryName = await iCategoryModel.delete(T);
      T.status = 0;
      int index=categories!.indexWhere((element) => element.categoryId==T.categoryId);
      categories![index] = T;
      notifyListeners();
      notifyInfo("Categoría: $categoryName ha sido dado de baja");
    } catch (e) {
      notifyError(e);
    }
  }

  Future<void> update(ProductCategory T) async {
    try {
      String categoryName = await iCategoryModel.update(T);
       int index=categories!.indexWhere((element) => element.categoryId==T.categoryId);
      categories![index] = T;
      notifyListeners();
      notifyInfo("Categoría: $categoryName ha sido actualizado");
    } catch (e) {
      notifyError(e);
    }
  }
}
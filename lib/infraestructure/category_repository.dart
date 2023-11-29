import 'package:flutter/foundation.dart';
import 'package:inventory_control/domain/db/inventory_db.dart';
import 'package:inventory_control/domain/interfaces/icategory_model.dart';
import 'package:inventory_control/domain/models/product_category.dart';

class CategoryRepository implements ICategoryModel{
   @override
  Future<int> create(ProductCategory t) async {
    var db = await InventoryDB.instace.database;
    int categoryId = 0;

    try {
      db.transaction((txn) async {
        categoryId = await txn.insert("Category", t.toMap());
       
      });
      return categoryId;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> delete(ProductCategory t) async {
    var db = await InventoryDB.instace.database;
    try {
      db.transaction((txn) async {
        t.status = 0;
        await txn.update("Category", t.toMap());
      });
      return t.categoryName;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ProductCategory>> read() async {
    List<ProductCategory> categories = [];
    var db = await InventoryDB.instace.database;
    try {
      List<Map> result = await db.rawQuery(
          "Select * from  Category");
      result.forEach((element) async {
        ProductCategory productCategory = ProductCategory.fromMap(element);
      
        categories.add(productCategory);
      });
      return categories;
    } catch (e) {
      throw Exception("Ocurrió un error a la hora de buscar los productos.");
    }
  }

  @override
  Future<String> update(ProductCategory t) async {
    var db = await InventoryDB.instace.database;
    try {
      db.transaction((txn) async {
          await txn.update("Category", t.toMap(),
            where: "CategoryId = ?", whereArgs: [t.categoryId]);
     
      });
      return t.categoryName;
    } catch (e) {
      return e.toString();
    }
  }

}
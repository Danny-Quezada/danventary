import 'package:inventory_control/domain/db/inventory_db.dart';
import 'package:inventory_control/domain/interfaces/iproduct_model.dart';
import 'package:inventory_control/domain/models/product.dart';
import 'package:inventory_control/domain/models/product_image.dart';

class ProductRepository implements IProductModel {
  @override
  Future<int> create(Product t) async {
    var db = await InventoryDB.instace.database;
    int productId = 0;

    try {
      db.transaction((txn) async {
        productId = await txn.insert("Product", t.toMap());
        if (t.productImages != null) {
          for (int i = 0; i < t.productImages!.length; i++) {
            txn.insert("ProductImage", t.productImages![i].toMap());
          }
        }
      });
      return productId;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> delete(Product t) async {
    var db = await InventoryDB.instace.database;
    try {
      db.transaction((txn) async {
        t.status = 0;
        await txn.update("Product", t.toMap());
      });
      return t.productName;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Product>> read() async {
    List<Product> products = [];
    var db = await InventoryDB.instace.database;
    try {
      List<Map> result = await db.rawQuery(
          "Select * from Product inner join Category on Product.categoryId=Category.categoryId");
      result.forEach((element) async {
        Product product = Product.toObject(element);
        List<Map> resultImage = await db.rawQuery(
            "SELECT * FROM ProductImage where ProductImage.productId=${element["productId"]}");
        result.forEach((elementImage) {
          product.productImages!.add(ProductImage.fromMap(elementImage));
        });
        products.add(product);
      });
      return products;
    } catch (e) {
      throw Exception("Ocurrió un error a la hora de buscar los productos.");
    }
  }

  @override
  Future<String> update(Product t) async {
    var db = await InventoryDB.instace.database;
    try {
      db.transaction((txn) async {
        await txn.update("Product", t.toMap(),
            where: "productId = ?", whereArgs: [t.productId]);
        await txn.delete("ProductImage",
            where: "productId = ?", whereArgs: [t.productId]);
        for (int i = 0; i < t.productImages!.length; i++) {
          await txn.insert("ProductImage", t.productImages![i].toMap());
        }
      });
      return t.productName;
    } catch (e) {
      return e.toString();
    }
  }
}

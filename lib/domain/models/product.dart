import 'package:inventory_control/domain/models/product_category.dart';

import 'product_image.dart';

class Product {
  int? productId;
  int quantity;
  String productName;
  String description;
  ProductCategory? category;
  double price;
  double salePrice;
  List<ProductImage>? productImages;
  int status=0;
  Product(this.productId, this.productImages,
      {status = true,
      required this.productName,
      required this.description,
      required this.price,
      required this.salePrice,
      this.category,
      required this.quantity});
  Map<String, dynamic> toMap() {
    return {
      "status": status,
      "productName": productName,
      "description": description,
      "price": price,
      "salePrice": salePrice,
      "categoryId": category?.categoryId ?? 0,
      "quantity": quantity
    };
  }

  static Product toObject(Map<dynamic, dynamic> objectMap) {

    return Product(
      
      objectMap["productId"], [],
      status: objectMap["status"],
        productName: objectMap["productName"],
        description: objectMap["description"],
        price: objectMap["price"],
        salePrice: objectMap["price"],
        quantity: objectMap["quantity"]);
  }
}

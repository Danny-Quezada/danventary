class ProductCategory {
  int? categoryId;
  String categoryName;
  int status=1;
  ProductCategory( {this.categoryId,required this.categoryName,status=1});

  Map<String, dynamic> toMap() {
    return { "categoryName": categoryName,"status": status};
  }

  static ProductCategory fromMap(Map<dynamic, dynamic> map) {
    return ProductCategory(
      categoryId: map["categoryId"] ?? 0,
  
        categoryName: map["categoryName"] ?? "",
        status: map["status"]);
  }
}

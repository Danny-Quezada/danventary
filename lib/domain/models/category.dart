class Category {
  int? categoryId;
  String categoryName;

  Category(this.categoryId, {required this.categoryName});

  Map<String, dynamic> toMap() {
    return {"categoryId": categoryId ?? 0, "categoryName": categoryName};
  }

  static Category fromMap(Map<dynamic, dynamic> map) {
    return Category(map["categoryId"] ?? 0,
        categoryName: map["categoryName"] ?? "");
  }
}

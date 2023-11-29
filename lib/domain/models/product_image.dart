class ProductImage{
  int? productImageId;
  int productId;
  String urlImage;

  ProductImage(this.productImageId,{required this.productId, required this.urlImage});


  Map<String, dynamic> toMap(){
    return {
      "productImageId": productImageId ?? 0,
      "productId": productId,
      "urlImage": urlImage
    };
  }
  static ProductImage fromMap(Map<dynamic,dynamic> map){
    return ProductImage(map["productImageId"],productId: map["productId"], urlImage: map["urlImage"]);
  }

}
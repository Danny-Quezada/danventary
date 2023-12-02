class ProductImage{
  int? productImageId;
  int? productId;
  String? urlImage;

  ProductImage({this.productImageId,required this.productId,  this.urlImage});


  Map<String, dynamic> toMap(){
    return {
     
      "productId": productId,
      "urlImage": urlImage
    };
  }
  static ProductImage fromMap(Map<dynamic,dynamic> map){
    return ProductImage(productImageId: map["productImageId"],productId: map["productId"], urlImage: map["urlImage"]);
  }
  static List<ProductImage> fromListString(List<String> imagesList){
    List<ProductImage> images=[];
    imagesList.forEach((element) { 
      images.add(ProductImage(productId: 0,urlImage: element));
    });
    return images;
  }
}
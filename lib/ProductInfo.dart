class ProductInfo {
  final String productID;
  final String name;
  final String photographer;
  final String imageURL;
  final String description;

  ProductInfo(
      {this.productID,
      this.name,
      this.photographer,
      this.imageURL,
      this.description});

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> itemInfo = json['itemInfo'];
    return ProductInfo(
      productID: itemInfo['productID'],
      name: itemInfo['name'],
      photographer: itemInfo['photographer'],
      imageURL: itemInfo['imageURL'],
      description: itemInfo['description'],
    );
  }
}
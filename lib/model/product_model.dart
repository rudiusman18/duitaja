class ProductModel {
  int? productId;
  String? productURL;
  String? productName;
  int? stock;
  String? description;
  int? price;

  ProductModel({
    required this.productId,
    required this.productURL,
    required this.productName,
    required this.stock,
    required this.description,
    required this.price,
  });
}

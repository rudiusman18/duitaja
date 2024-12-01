class ProductModel {
  int? productId;
  String? productCategory;
  String? productURL;
  String? productName;
  int? stock;
  String? description;
  int? price;
  int? discountPrice;
  String? status;

  ProductModel({
    required this.productId,
    required this.productCategory,
    required this.productURL,
    required this.productName,
    required this.stock,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.status,
  });
}

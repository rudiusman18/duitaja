// ignore_for_file: prefer_void_to_null

class DetailStockManagementModel {
  String? message;
  Payload? payload;

  DetailStockManagementModel({this.message, this.payload});

  DetailStockManagementModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    return data;
  }
}

class Payload {
  String? id;
  String? name;
  String? image;
  String? description;
  bool? status;
  bool? hasReceipt;
  int? currentQuantity;
  Null deletedAt;
  bool? isExpiredPromo;
  String? promoId;
  Category? category;

  Payload(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.status,
      this.hasReceipt,
      this.currentQuantity,
      this.deletedAt,
      this.isExpiredPromo,
      this.promoId,
      this.category});

  Payload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    status = json['status'];
    hasReceipt = json['has_receipt'];
    currentQuantity = json['current_quantity'];
    deletedAt = json['deleted_at'];
    isExpiredPromo = json['is_expired_promo'];
    promoId = json['promo_id'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    data['status'] = status;
    data['has_receipt'] = hasReceipt;
    data['current_quantity'] = currentQuantity;
    data['deleted_at'] = deletedAt;
    data['is_expired_promo'] = isExpiredPromo;
    data['promo_id'] = promoId;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

class Category {
  String? id;
  String? name;
  Null deletedAt;

  Category({this.id, this.name, this.deletedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

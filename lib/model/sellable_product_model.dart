// ignore_for_file: prefer_typing_uninitialized_variables, prefer_collection_literals

class SellableProductModel {
  String? message;
  List<Payload>? payload;
  Meta? meta;

  SellableProductModel({this.message, this.payload, this.meta});

  SellableProductModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['payload'] != null) {
      payload = <Payload>[];
      json['payload'].forEach((v) {
        payload!.add(Payload.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    if (payload != null) {
      data['payload'] = payload!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Payload {
  String? id;
  String? name;
  String? image;
  String? statusDisplay;
  int? currentQuantity;
  int? price;
  dynamic deletedAt;
  Category? category;
  Promo? promo;

  Payload(
      {this.id,
      this.name,
      this.image,
      this.statusDisplay,
      this.currentQuantity,
      this.price,
      this.deletedAt,
      this.category,
      this.promo});

  Payload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    statusDisplay = json['status_display'];
    currentQuantity = json['current_quantity'];
    price = json['price'];
    deletedAt = json['deleted_at'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    promo = json['promo'] != null ? Promo.fromJson(json['promo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['status_display'] = statusDisplay;
    data['current_quantity'] = currentQuantity;
    data['price'] = price;
    data['deleted_at'] = deletedAt;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (promo != null) {
      data['promo'] = promo!.toJson();
    }
    return data;
  }
}

class Category {
  String? id;
  String? name;
  dynamic deletedAt;

  Category({this.id, this.name, this.deletedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class Promo {
  String? id;
  String? name;
  String? startDate;
  String? endDate;
  int? amount;

  Promo({this.id, this.name, this.startDate, this.endDate, this.amount});

  Promo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['amount'] = amount;
    return data;
  }
}

class Meta {
  int? page;
  int? limit;
  int? totalData;
  int? totalPage;
  String? previousPage;
  String? nextPage;

  Meta(
      {this.page,
      this.limit,
      this.totalData,
      this.totalPage,
      this.previousPage,
      this.nextPage});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    totalData = json['total_data'];
    totalPage = json['total_page'];
    previousPage = json['previous_page'];
    nextPage = json['next_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['page'] = page;
    data['limit'] = limit;
    data['total_data'] = totalData;
    data['total_page'] = totalPage;
    data['previous_page'] = previousPage;
    data['next_page'] = nextPage;
    return data;
  }
}

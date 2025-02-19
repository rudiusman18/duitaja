class StockOpnameAvailableItemModel {
  String? message;
  List<Payload>? payload;

  StockOpnameAvailableItemModel({this.message, this.payload});

  StockOpnameAvailableItemModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['payload'] != null) {
      payload = <Payload>[];
      json['payload'].forEach((v) {
        payload!.add(Payload.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (payload != null) {
      data['payload'] = payload!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payload {
  String? id;
  int? quantity;
  String? expiredDate;
  String? name;

  Payload({this.id, this.quantity, this.expiredDate, this.name});

  Payload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    expiredDate = json['expired_date'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['expired_date'] = expiredDate;
    data['name'] = name;
    return data;
  }
}

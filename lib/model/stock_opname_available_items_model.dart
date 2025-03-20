// ignore_for_file: prefer_collection_literals, unnecessary_new, unnecessary_getters_setters

class StockOpnameAvailableItemModel {
  String? _message;
  List<Payload>? _payload;

  StockOpnameAvailableItemModel({String? message, List<Payload>? payload}) {
    if (message != null) {
      _message = message;
    }
    if (payload != null) {
      _payload = payload;
    }
  }

  String? get message => _message;
  set message(String? message) => _message = message;
  List<Payload>? get payload => _payload;
  set payload(List<Payload>? payload) => _payload = payload;

  StockOpnameAvailableItemModel.fromJson(Map<String, dynamic> json) {
    _message = json['message'];
    if (json['payload'] != null) {
      _payload = <Payload>[];
      json['payload'].forEach((v) {
        _payload!.add(new Payload.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = _message;
    if (_payload != null) {
      data['payload'] = _payload!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payload {
  String? _id;
  int? _quantity;
  String? _expiredDate;
  String? _name;
  String? _type;

  Payload(
      {String? id,
      int? quantity,
      String? expiredDate,
      String? name,
      String? type}) {
    if (id != null) {
      _id = id;
    }
    if (quantity != null) {
      _quantity = quantity;
    }
    if (expiredDate != null) {
      _expiredDate = expiredDate;
    }
    if (name != null) {
      _name = name;
    }
    if (type != null) {
      _type = type;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  int? get quantity => _quantity;
  set quantity(int? quantity) => _quantity = quantity;
  String? get expiredDate => _expiredDate;
  set expiredDate(String? expiredDate) => _expiredDate = expiredDate;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get type => _type;
  set type(String? type) => _type = type;

  Payload.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _quantity = json['quantity'];
    _expiredDate = json['expired_date'];
    _name = json['name'];
    _type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = _id;
    data['quantity'] = _quantity;
    data['expired_date'] = _expiredDate;
    data['name'] = _name;
    data['type'] = _type;
    return data;
  }
}

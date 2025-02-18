// ignore_for_file: unnecessary_getters_setters

class DetailStockOpnameModel {
  String? _message;
  Payload? _payload;

  DetailStockOpnameModel({String? message, Payload? payload}) {
    if (message != null) {
      _message = message;
    }
    if (payload != null) {
      _payload = payload;
    }
  }

  String? get message => _message;
  set message(String? message) => _message = message;
  Payload? get payload => _payload;
  set payload(Payload? payload) => _payload = payload;

  DetailStockOpnameModel.fromJson(Map<String, dynamic> json) {
    _message = json['message'];
    _payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = _message;
    if (_payload != null) {
      data['payload'] = _payload!.toJson();
    }
    return data;
  }
}

class Payload {
  String? _id;
  String? _title;
  String? _companyId;
  String? _createdAt;
  String? _changerName;
  List<Items>? _items;

  Payload(
      {String? id,
      String? title,
      String? companyId,
      String? createdAt,
      String? changerName,
      List<Items>? items}) {
    if (id != null) {
      _id = id;
    }
    if (title != null) {
      _title = title;
    }
    if (companyId != null) {
      _companyId = companyId;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (changerName != null) {
      _changerName = changerName;
    }
    if (items != null) {
      _items = items;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get companyId => _companyId;
  set companyId(String? companyId) => _companyId = companyId;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get changerName => _changerName;
  set changerName(String? changerName) => _changerName = changerName;
  List<Items>? get items => _items;
  set items(List<Items>? items) => _items = items;

  Payload.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _companyId = json['company_id'];
    _createdAt = json['created_at'];
    _changerName = json['changer_name'];
    if (json['items'] != null) {
      _items = <Items>[];
      json['items'].forEach((v) {
        _items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['title'] = _title;
    data['company_id'] = _companyId;
    data['created_at'] = _createdAt;
    data['changer_name'] = _changerName;
    if (_items != null) {
      data['items'] = _items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? _id;
  String? _stockOpnameId;
  int? _quantity;
  String? _stockId;
  String? _productType;
  int? _differenceQuantity;
  String? _name;

  Items(
      {String? id,
      String? stockOpnameId,
      int? quantity,
      String? stockId,
      String? productType,
      int? differenceQuantity,
      String? name}) {
    if (id != null) {
      _id = id;
    }
    if (stockOpnameId != null) {
      _stockOpnameId = stockOpnameId;
    }
    if (quantity != null) {
      _quantity = quantity;
    }
    if (stockId != null) {
      _stockId = stockId;
    }
    if (productType != null) {
      _productType = productType;
    }
    if (differenceQuantity != null) {
      _differenceQuantity = differenceQuantity;
    }
    if (name != null) {
      _name = name;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get stockOpnameId => _stockOpnameId;
  set stockOpnameId(String? stockOpnameId) => _stockOpnameId = stockOpnameId;
  int? get quantity => _quantity;
  set quantity(int? quantity) => _quantity = quantity;
  String? get stockId => _stockId;
  set stockId(String? stockId) => _stockId = stockId;
  String? get productType => _productType;
  set productType(String? productType) => _productType = productType;
  int? get differenceQuantity => _differenceQuantity;
  set differenceQuantity(int? differenceQuantity) =>
      _differenceQuantity = differenceQuantity;
  String? get name => _name;
  set name(String? name) => _name = name;

  Items.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _stockOpnameId = json['stock_opname_id'];
    _quantity = json['quantity'];
    _stockId = json['stock_id'];
    _productType = json['product_type'];
    _differenceQuantity = json['difference_quantity'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['stock_opname_id'] = _stockOpnameId;
    data['quantity'] = _quantity;
    data['stock_id'] = _stockId;
    data['product_type'] = _productType;
    data['difference_quantity'] = _differenceQuantity;
    data['name'] = _name;
    return data;
  }
}

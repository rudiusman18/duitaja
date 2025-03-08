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
  String? _changerName;
  List<Items>? _items;

  Payload(
      {String? id, String? title, String? changerName, List<Items>? items}) {
    if (id != null) {
      _id = id;
    }
    if (title != null) {
      _title = title;
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
  String? get changerName => _changerName;
  set changerName(String? changerName) => _changerName = changerName;
  List<Items>? get items => _items;
  set items(List<Items>? items) => _items = items;

  Payload.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
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
    data['changer_name'] = _changerName;
    if (_items != null) {
      data['items'] = _items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? _quantity;
  int? _systemQuantity;
  int? _realQuantity;
  int? _inputQuantity;
  int? _outputQuantity;
  String? _expiredDate;
  String? _name;

  Items(
      {int? quantity,
      int? systemQuantity,
      int? realQuantity,
      int? inputQuantity,
      int? outputQuantity,
      String? expiredDate,
      String? name}) {
    if (quantity != null) {
      _quantity = quantity;
    }
    if (systemQuantity != null) {
      _systemQuantity = systemQuantity;
    }
    if (realQuantity != null) {
      _realQuantity = realQuantity;
    }
    if (inputQuantity != null) {
      _inputQuantity = inputQuantity;
    }
    if (outputQuantity != null) {
      _outputQuantity = outputQuantity;
    }
    if (expiredDate != null) {
      _expiredDate = expiredDate;
    }
    if (name != null) {
      _name = name;
    }
  }

  int? get quantity => _quantity;
  set quantity(int? quantity) => _quantity = quantity;
  int? get systemQuantity => _systemQuantity;
  set systemQuantity(int? systemQuantity) => _systemQuantity = systemQuantity;
  int? get realQuantity => _realQuantity;
  set realQuantity(int? realQuantity) => _realQuantity = realQuantity;
  int? get inputQuantity => _inputQuantity;
  set inputQuantity(int? inputQuantity) => _inputQuantity = inputQuantity;
  int? get outputQuantity => _outputQuantity;
  set outputQuantity(int? outputQuantity) => _outputQuantity = outputQuantity;
  String? get expiredDate => _expiredDate;
  set expiredDate(String? expiredDate) => _expiredDate = expiredDate;
  String? get name => _name;
  set name(String? name) => _name = name;

  Items.fromJson(Map<String, dynamic> json) {
    _quantity = json['quantity'];
    _systemQuantity = json['system_quantity'];
    _realQuantity = json['real_quantity'];
    _inputQuantity = json['input_quantity'];
    _outputQuantity = json['output_quantity'];
    _expiredDate = json['expired_date'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = _quantity;
    data['system_quantity'] = _systemQuantity;
    data['real_quantity'] = _realQuantity;
    data['input_quantity'] = _inputQuantity;
    data['output_quantity'] = _outputQuantity;
    data['expired_date'] = _expiredDate;
    data['name'] = _name;
    return data;
  }
}

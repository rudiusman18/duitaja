// ignore_for_file: unnecessary_getters_setters

class DetailStockManagementModel {
  String? _message;
  Payload? _payload;

  DetailStockManagementModel({String? message, Payload? payload}) {
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

  DetailStockManagementModel.fromJson(Map<String, dynamic> json) {
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
  String? _name;
  String? _image;
  String? _description;
  bool? _status;
  bool? _hasReceipt;
  int? _currentQuantity;
  dynamic _deletedAt;
  bool? _isExpiredPromo;
  Category? _category;
  Promo? _promo;

  Payload(
      {String? id,
      String? name,
      String? image,
      String? description,
      bool? status,
      bool? hasReceipt,
      int? currentQuantity,
      dynamic deletedAt,
      bool? isExpiredPromo,
      Category? category,
      Promo? promo}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (image != null) {
      _image = image;
    }
    if (description != null) {
      _description = description;
    }
    if (status != null) {
      _status = status;
    }
    if (hasReceipt != null) {
      _hasReceipt = hasReceipt;
    }
    if (currentQuantity != null) {
      _currentQuantity = currentQuantity;
    }
    if (isExpiredPromo != null) {
      _isExpiredPromo = isExpiredPromo;
    }
    if (category != null) {
      _category = category;
    }
    if (promo != null) {
      _promo = promo;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get image => _image;
  set image(String? image) => _image = image;
  String? get description => _description;
  set description(String? description) => _description = description;
  bool? get status => _status;
  set status(bool? status) => _status = status;
  bool? get hasReceipt => _hasReceipt;
  set hasReceipt(bool? hasReceipt) => _hasReceipt = hasReceipt;
  int? get currentQuantity => _currentQuantity;
  set currentQuantity(int? currentQuantity) =>
      _currentQuantity = currentQuantity;
  dynamic get deletedAt => _deletedAt;
  set deletedAt(dynamic deletedAt) => _deletedAt = deletedAt;
  bool? get isExpiredPromo => _isExpiredPromo;
  set isExpiredPromo(bool? isExpiredPromo) => _isExpiredPromo = isExpiredPromo;
  Category? get category => _category;
  set category(Category? category) => _category = category;
  Promo? get promo => _promo;
  set promo(Promo? promo) => _promo = promo;

  Payload.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _description = json['description'];
    _status = json['status'];
    _hasReceipt = json['has_receipt'];
    _currentQuantity = json['current_quantity'];
    _deletedAt = json['deleted_at'];
    _isExpiredPromo = json['is_expired_promo'];
    _category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    _promo = json['promo'] != null ? Promo.fromJson(json['promo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['image'] = _image;
    data['description'] = _description;
    data['status'] = _status;
    data['has_receipt'] = _hasReceipt;
    data['current_quantity'] = _currentQuantity;
    data['deleted_at'] = _deletedAt;
    data['is_expired_promo'] = _isExpiredPromo;
    if (_category != null) {
      data['category'] = _category!.toJson();
    }
    if (_promo != null) {
      data['promo'] = _promo!.toJson();
    }
    return data;
  }
}

class Category {
  String? _id;
  String? _name;
  dynamic _deletedAt;

  Category({String? id, String? name, dynamic deletedAt}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (deletedAt != null) {
      _deletedAt = deletedAt;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  dynamic get deletedAt => _deletedAt;
  set deletedAt(dynamic deletedAt) => _deletedAt = deletedAt;

  Category.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['deleted_at'] = _deletedAt;
    return data;
  }
}

class Promo {
  String? _id;
  String? _name;
  String? _type;
  String? _startDate;
  String? _endDate;
  String? _companyId;
  int? _amount;

  Promo(
      {String? id,
      String? name,
      String? type,
      String? startDate,
      String? endDate,
      String? companyId,
      int? amount}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (type != null) {
      _type = type;
    }
    if (startDate != null) {
      _startDate = startDate;
    }
    if (endDate != null) {
      _endDate = endDate;
    }
    if (companyId != null) {
      _companyId = companyId;
    }
    if (amount != null) {
      _amount = amount;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get type => _type;
  set type(String? type) => _type = type;
  String? get startDate => _startDate;
  set startDate(String? startDate) => _startDate = startDate;
  String? get endDate => _endDate;
  set endDate(String? endDate) => _endDate = endDate;
  String? get companyId => _companyId;
  set companyId(String? companyId) => _companyId = companyId;
  int? get amount => _amount;
  set amount(int? amount) => _amount = amount;

  Promo.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _type = json['type'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _companyId = json['company_id'];
    _amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['type'] = _type;
    data['start_date'] = _startDate;
    data['end_date'] = _endDate;
    data['company_id'] = _companyId;
    data['amount'] = _amount;
    return data;
  }
}

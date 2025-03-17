// ignore_for_file: unnecessary_getters_setters

class PromoModel {
  String? _message;
  List<Payload>? _payload;
  Meta? _meta;

  PromoModel({String? message, List<Payload>? payload, Meta? meta}) {
    if (message != null) {
      _message = message;
    }
    if (payload != null) {
      _payload = payload;
    }
    if (meta != null) {
      _meta = meta;
    }
  }

  String? get message => _message;
  set message(String? message) => _message = message;
  List<Payload>? get payload => _payload;
  set payload(List<Payload>? payload) => _payload = payload;
  Meta? get meta => _meta;
  set meta(Meta? meta) => _meta = meta;

  PromoModel.fromJson(Map<String, dynamic> json) {
    _message = json['message'];
    if (json['payload'] != null) {
      _payload = <Payload>[];
      json['payload'].forEach((v) {
        _payload!.add(Payload.fromJson(v));
      });
    }
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = _message;
    if (_payload != null) {
      data['payload'] = _payload!.map((v) => v.toJson()).toList();
    }
    if (_meta != null) {
      data['meta'] = _meta!.toJson();
    }
    return data;
  }
}

class Payload {
  String? _id;
  String? _name;
  int? _amount;
  String? _startDate;
  String? _endDate;
  bool? _isAll;
  String? _type;
  String? _companyId;
  List<Products>? _products;

  Payload(
      {String? id,
      String? name,
      int? amount,
      String? startDate,
      String? endDate,
      bool? isAll,
      String? type,
      String? companyId,
      List<Products>? products}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (amount != null) {
      _amount = amount;
    }
    if (startDate != null) {
      _startDate = startDate;
    }
    if (endDate != null) {
      _endDate = endDate;
    }
    if (isAll != null) {
      _isAll = isAll;
    }
    if (type != null) {
      _type = type;
    }
    if (companyId != null) {
      _companyId = companyId;
    }
    if (products != null) {
      _products = products;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  int? get amount => _amount;
  set amount(int? amount) => _amount = amount;
  String? get startDate => _startDate;
  set startDate(String? startDate) => _startDate = startDate;
  String? get endDate => _endDate;
  set endDate(String? endDate) => _endDate = endDate;
  bool? get isAll => _isAll;
  set isAll(bool? isAll) => _isAll = isAll;
  String? get type => _type;
  set type(String? type) => _type = type;
  String? get companyId => _companyId;
  set companyId(String? companyId) => _companyId = companyId;
  List<Products>? get products => _products;
  set products(List<Products>? products) => _products = products;

  Payload.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _amount = json['amount'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _isAll = json['is_all'];
    _type = json['type'];
    _companyId = json['company_id'];
    if (json['products'] != null) {
      _products = <Products>[];
      json['products'].forEach((v) {
        _products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['amount'] = _amount;
    data['start_date'] = _startDate;
    data['end_date'] = _endDate;
    data['is_all'] = _isAll;
    data['type'] = _type;
    data['company_id'] = _companyId;
    if (_products != null) {
      data['products'] = _products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? _id;
  String? _name;
  String? _type;

  Products({String? id, String? name, String? type}) {
    if (id != null) {
      _id = id;
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
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get type => _type;
  set type(String? type) => _type = type;

  Products.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['type'] = _type;
    return data;
  }
}

class Meta {
  int? _page;
  int? _limit;
  int? _totalData;
  int? _totalPage;
  String? _previousPage;
  String? _nextPage;

  Meta(
      {int? page,
      int? limit,
      int? totalData,
      int? totalPage,
      String? previousPage,
      String? nextPage}) {
    if (page != null) {
      _page = page;
    }
    if (limit != null) {
      _limit = limit;
    }
    if (totalData != null) {
      _totalData = totalData;
    }
    if (totalPage != null) {
      _totalPage = totalPage;
    }
    if (previousPage != null) {
      _previousPage = previousPage;
    }
    if (nextPage != null) {
      _nextPage = nextPage;
    }
  }

  int? get page => _page;
  set page(int? page) => _page = page;
  int? get limit => _limit;
  set limit(int? limit) => _limit = limit;
  int? get totalData => _totalData;
  set totalData(int? totalData) => _totalData = totalData;
  int? get totalPage => _totalPage;
  set totalPage(int? totalPage) => _totalPage = totalPage;
  String? get previousPage => _previousPage;
  set previousPage(String? previousPage) => _previousPage = previousPage;
  String? get nextPage => _nextPage;
  set nextPage(String? nextPage) => _nextPage = nextPage;

  Meta.fromJson(Map<String, dynamic> json) {
    _page = json['page'];
    _limit = json['limit'];
    _totalData = json['total_data'];
    _totalPage = json['total_page'];
    _previousPage = json['previous_page'];
    _nextPage = json['next_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = _page;
    data['limit'] = _limit;
    data['total_data'] = _totalData;
    data['total_page'] = _totalPage;
    data['previous_page'] = _previousPage;
    data['next_page'] = _nextPage;
    return data;
  }
}

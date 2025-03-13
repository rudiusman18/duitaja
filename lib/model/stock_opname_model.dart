// ignore_for_file: prefer_collection_literals, unnecessary_getters_setters

class StockOpnameModel {
  String? _message;
  List<Payload>? _payload;
  Meta? _meta;

  StockOpnameModel({String? message, List<Payload>? payload, Meta? meta}) {
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

  StockOpnameModel.fromJson(Map<String, dynamic> json) {
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
  String? _title;
  String? _changerName;
  int? _amount;
  String? _createdAt;

  Payload(
      {String? id,
      String? title,
      String? changerName,
      int? amount,
      String? createdAt}) {
    if (id != null) {
      _id = id;
    }
    if (title != null) {
      _title = title;
    }
    if (changerName != null) {
      _changerName = changerName;
    }
    if (amount != null) {
      _amount = amount;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get changerName => _changerName;
  set changerName(String? changerName) => _changerName = changerName;
  int? get amount => _amount;
  set amount(int? amount) => _amount = amount;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;

  Payload.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _changerName = json['changer_name'];
    _amount = json['amount'];
    _createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = _id;
    data['title'] = _title;
    data['changer_name'] = _changerName;
    data['amount'] = _amount;
    data['created_at'] = _createdAt;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['page'] = _page;
    data['limit'] = _limit;
    data['total_data'] = _totalData;
    data['total_page'] = _totalPage;
    data['previous_page'] = _previousPage;
    data['next_page'] = _nextPage;
    return data;
  }
}

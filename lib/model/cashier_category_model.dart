class CashierCategoryModel {
  String? message;
  List<Payload>? payload;
  Meta? meta;

  CashierCategoryModel({this.message, this.payload, this.meta});

  CashierCategoryModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
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
  String? code;
  String? type;
  bool? status;

  Payload({this.id, this.name, this.code, this.type, this.status});

  Payload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    type = json['type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['type'] = type;
    data['status'] = status;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['total_data'] = totalData;
    data['total_page'] = totalPage;
    data['previous_page'] = previousPage;
    data['next_page'] = nextPage;
    return data;
  }
}

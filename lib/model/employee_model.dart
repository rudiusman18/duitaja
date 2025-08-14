// ignore_for_file: prefer_collection_literals

class EmployeeModel {
  String? message;
  List<Payload>? payload;
  Meta? meta;

  EmployeeModel({this.message, this.payload, this.meta});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
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
  String? employeeKey;
  bool? status;
  String? companyId;
  String? password;

  Payload(
      {this.id,
      this.name,
      this.employeeKey,
      this.status,
      this.companyId,
      this.password});

  Payload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    employeeKey = json['employee_key'];
    status = json['status'];
    companyId = json['company_id'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['employee_key'] = employeeKey;
    data['status'] = status;
    data['company_id'] = companyId;
    data['password'] = password;
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

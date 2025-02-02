// ignore_for_file: unnecessary_question_mark, prefer_collection_literals

class TaxModel {
  String? message;
  List<Payload>? payload;

  TaxModel({this.message, this.payload});

  TaxModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['payload'] != null) {
      payload = <Payload>[];
      json['payload'].forEach((v) {
        payload!.add(Payload.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    if (payload != null) {
      data['payload'] = payload!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payload {
  String? id;
  String? name;
  int? precentage;
  String? createdAt;
  Null? deletedAt;

  Payload(
      {this.id, this.name, this.precentage, this.createdAt, this.deletedAt});

  Payload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    precentage = json['precentage'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['precentage'] = precentage;
    data['created_at'] = createdAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

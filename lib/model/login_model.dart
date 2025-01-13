// ignore_for_file: prefer_collection_literals

class LoginModel {
  String? message;
  Payload? payload;

  LoginModel({this.message, this.payload});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    return data;
  }
}

class Payload {
  String? token;
  String? typeUser;

  Payload({this.token, this.typeUser});

  Payload.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    typeUser = json['type_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = token;
    data['type_user'] = typeUser;
    return data;
  }
}

// ignore_for_file: prefer_collection_literals

class ProfileModel {
  String? message;
  Payload? payload;

  ProfileModel({this.message, this.payload});

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
  Profile? profile;

  Payload({this.profile});

  Payload.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }
}

class Profile {
  String? id;
  String? username;
  String? phone;
  String? name;
  String? email;
  String? companyId;
  String? companyName;
  bool? isEmployee;

  Profile(
      {this.id,
      this.username,
      this.phone,
      this.name,
      this.email,
      this.companyId,
      this.companyName,
      this.isEmployee});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    isEmployee = json['is_employee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['phone'] = phone;
    data['name'] = name;
    data['email'] = email;
    data['company_id'] = companyId;
    data['company_name'] = companyName;
    data['is_employee'] = isEmployee;
    return data;
  }
}

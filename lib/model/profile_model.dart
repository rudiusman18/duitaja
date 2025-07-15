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
    final Map<String, dynamic> data = <String, dynamic>{};
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
    final Map<String, dynamic> data = <String, dynamic>{};
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
  String? rolePermission;
  Company? company;

  Profile(
      {this.id,
      this.username,
      this.phone,
      this.name,
      this.email,
      this.companyId,
      this.companyName,
      this.rolePermission,
      this.company});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    rolePermission = json['role_permission'];
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['phone'] = phone;
    data['name'] = name;
    data['email'] = email;
    data['company_id'] = companyId;
    data['company_name'] = companyName;
    data['role_permission'] = rolePermission;
    if (company != null) {
      data['company'] = company!.toJson();
    }
    return data;
  }
}

class Company {
  String? id;
  String? code;
  String? name;
  String? address;
  String? image;
  String? typeAccount;
  String? createdAt;
  String? updatedAt;

  Company(
      {this.id,
      this.code,
      this.name,
      this.address,
      this.image,
      this.typeAccount,
      this.createdAt,
      this.updatedAt});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    address = json['address'];
    image = json['image'];
    typeAccount = json['type_account'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['address'] = address;
    data['image'] = image;
    data['type_account'] = typeAccount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

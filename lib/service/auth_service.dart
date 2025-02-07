import 'dart:convert';

import 'package:duitaja/model/login_model.dart';
import 'package:duitaja/model/profile_model.dart';
import 'package:duitaja/shared/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Fungsi untuk melakukan post login
  Future<LoginModel> postLogin(
      {required String email, required String password}) async {
    var url = Uri.parse("$baseURL/auth/login");
    var header = {'Content-Type': 'application/json'};
    Map data = {
      "key": email,
      "password": password,
    };
    var body = jsonEncode(data);
    var response = await http.post(
      url,
      headers: header,
      body: body,
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      var data = jsonDecode(response.body);
      final LoginModel loginModel = LoginModel.fromJson(data);
      return loginModel;
    } else {
      var data = jsonDecode(response.body);
      throw Exception("${data['errors']}");
    }
  }

  // Fungsi untuk mendapatkan data profile pengguna
  Future<ProfileModel> getProfile({required String token}) async {
    var url = Uri.parse("$baseURL/auth/profile");
    var header = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: header);

    var data = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      ProfileModel profileModel = ProfileModel.fromJson(data);
      return profileModel;
    } else {
      throw Exception("${data['errors']}");
    }
  }

  // Fungsi untuk melakukan post register
  Future<void> postRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String companyName,
  }) async {
    var url = Uri.parse("$baseURL/auth/register");
    var header = {'Content-Type': 'application/json'};
    Map data = {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "company_name": companyName,
    };
    var body = jsonEncode(data);
    var response = await http.post(
      url,
      headers: header,
      body: body,
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      final data = jsonDecode(response.body);
      throw Exception(data['errors']);
    }
  }

// Fungsi yang digunakan untuk menyimpan data profile ke local
  Future<void> saveProfileData({
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("userAccount", "$email||$password");
  }

// Fungsi yang digunakan untuk mengambil data profile dari local
  Future<String?> getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("userAccount");
  }

// Fungsi yang digunakan untuk menghapus data profile dari local
  Future<void> removeProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("userAccount");
  }
}

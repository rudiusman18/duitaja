import 'dart:convert';

import 'package:duitaja/model/promo_model.dart';
import 'package:duitaja/shared/utils.dart';
import 'package:http/http.dart' as http;

class PromoService {
  Future<PromoModel> getAllPromos({required String token}) async {
    var url = Uri.parse("$baseURL/promos?limit=999999999");
    var header = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: header);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      var data = jsonDecode(response.body);
      PromoModel promoModel = PromoModel.fromJson(data);
      return promoModel;
    } else {
      var data = jsonDecode(response.body);
      throw ("${data["message"] == null || data["message"] == "" ? "Gagal mendapatkan data" : data["message"]}");
    }
  }
}

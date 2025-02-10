import 'dart:convert';

import 'package:duitaja/model/stock_management_model.dart';
import 'package:duitaja/shared/utils.dart';
import 'package:http/http.dart' as http;

class StockManagementService {
  Future<StockManagementModel> getAllStockManagement({
    required String token,
    required String page,
    required String limit,
    required String categoryId,
    required String inStatus,
    required String search,
  }) async {
    var url = Uri.parse(
        "$baseURL/sellable?page=$page&limit=$limit&category_id=$categoryId&in_status=$inStatus&search=$search");

    print("URL yang diakses adalah $url dengan token $token");
    var header = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: header);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      var data = jsonDecode(response.body);
      final StockManagementModel stockManagementModel =
          StockManagementModel.fromJson(data);
      return stockManagementModel;
    } else {
      var data = jsonDecode(response.body);
      throw Exception(
          "${data["message"] == null || data["message"] == "" ? "Gagal mendapatkan data" : data["message"]}");
    }
  }
}

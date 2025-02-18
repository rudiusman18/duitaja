import 'dart:convert';

import 'package:duitaja/model/detail_stock_opname_model.dart';
import 'package:duitaja/model/stock_opname_model.dart';
import 'package:duitaja/shared/utils.dart';
import 'package:http/http.dart' as http;

class StockOpnameService {
  Future<StockOpnameModel> getAllStockOpname({
    required String token,
    required String page,
    required String limit,
  }) async {
    var url = Uri.parse("$baseURL/stock-opname?page=$page&limit=$limit");

    var header = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var response = await http.get(url, headers: header);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      var data = jsonDecode(response.body);
      final StockOpnameModel stockOpnameModel = StockOpnameModel.fromJson(data);
      return stockOpnameModel;
    } else {
      var data = jsonDecode(response.body);
      throw Exception(
          "${data["message"] == null || data["message"] == "" ? "Gagal mendapatkan data" : data["message"]}");
    }
  }

  Future<DetailStockOpnameModel> getDetailStockOpname(
      {required String token, required String stockOpnameID}) async {
    var url = Uri.parse("$baseURL/stock-opname/$stockOpnameID");

    var header = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var response = await http.get(url, headers: header);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      var data = jsonDecode(response.body);
      final DetailStockOpnameModel detailStockOpnameModel =
          DetailStockOpnameModel.fromJson(data);
      return detailStockOpnameModel;
    } else {
      var data = jsonDecode(response.body);
      throw Exception(
          "${data["message"] == null || data["message"] == "" ? "Gagal mendapatkan data" : data["message"]}");
    }
  }
}

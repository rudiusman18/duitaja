import 'dart:convert';

import 'package:duidku/model/sale_history_model.dart';
import 'package:duidku/shared/utils.dart';
import 'package:http/http.dart' as http;

class SaleService {
  // Digunakan untuk mendapatkan data riwayat penjualan
  Future<SaleHistoryModel> getSaleHistory({
    required String token,
    required String page,
    required String limit,
    required String status,
    required String startDate,
    required String endDate,
  }) async {
    var url = Uri.parse(
        "$baseURL/invoice/sales/history?page=$page&limit=$limit&status=$status&start_date=$startDate&end_date=$endDate");
    var header = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: header);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      var data = jsonDecode(response.body);
      final SaleHistoryModel saleHistoryModel = SaleHistoryModel.fromJson(data);
      return saleHistoryModel;
    } else {
      var data = jsonDecode(response.body);
      throw Exception(
          "${data["message"] == null || data["message"] == "" ? "Gagal mendapatkan data" : data["message"]}");
    }
  }
}

import 'dart:convert';

import 'package:duitaja/model/detail_sale_history_model.dart';
import 'package:duitaja/model/sale_history_model.dart';
import 'package:duitaja/shared/utils.dart';
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
    required String search,
    required String inStatus,
  }) async {
    var url = Uri.parse(
        "$baseURL/invoice/sales/history?page=$page&limit=$limit&status=$status&start_date=$startDate&end_date=$endDate&search=$search&in_status=$inStatus");

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

  // Digunakan untuk mendapatkan data detail riwayat penjualan
  Future<DetailSaleHistoryModel> getDetailSaleHistory(
      {required String token, required String payloadId}) async {
    var url = Uri.parse("$baseURL/invoice/sales/history/$payloadId");
    var header = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: header);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      var data = jsonDecode(response.body);
      final DetailSaleHistoryModel detailSaleHistoryModel =
          DetailSaleHistoryModel.fromJson(data);
      return detailSaleHistoryModel;
    } else {
      var data = jsonDecode(response.body);
      throw Exception(
          "${data["message"] == null || data["message"] == "" ? "Gagal mendapatkan data" : data["message"]}");
    }
  }

  // Digunakan untuk melakukan refund data
  Future<void> putRefundSaleHistory(
      {required String token, required String payloadId}) async {
    var url = Uri.parse("$baseURL/invoice/refund/$payloadId");
    var header = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    var response = await http.put(url, headers: header);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      var data = jsonDecode(response.body);
      throw Exception(
          "${data["message"] == null || data["message"] == "" ? "Gagal mendapatkan data" : data["message"]}");
    }
  }
}

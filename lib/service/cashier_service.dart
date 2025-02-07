import 'dart:convert';

import 'package:duitaja/model/cashier_category_model.dart';
import 'package:duitaja/model/order_model.dart';
import 'package:duitaja/model/sellable_product_model.dart';
import 'package:duitaja/model/tax_model.dart';
import 'package:duitaja/shared/utils.dart';
import 'package:http/http.dart' as http;

class CashierService {
  // Fungsi untuk mengambil data produk yang dijual (tampil di bagian menu)
  Future<SellableProductModel> getSellableProduct({
    required String token,
    required String page,
    required String limit,
    required String categoryId,
    required String inStatus,
    required String search,
  }) async {
    var url = Uri.parse(
        "$baseURL/sellable?page=$page&limit=$limit&category_id=$categoryId&search=$search&in_status=$inStatus");
    var header = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: header);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      var data = jsonDecode(response.body);
      final SellableProductModel sellableProductModel =
          SellableProductModel.fromJson(data);
      return sellableProductModel;
    } else {
      var data = jsonDecode(response.body);
      throw Exception(
          "${data["message"] == null || data["message"] == "" ? "Gagal mendapatkan data" : data["message"]}");
    }
  }

// Fungsi yang digunakan untuk mengambil semua data pajak
  Future<TaxModel> getAllTax({required String token}) async {
    var url = Uri.parse("$baseURL/tax");

    var header = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var response = await http.get(url, headers: header);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      var data = jsonDecode(response.body);
      final TaxModel taxModel = TaxModel.fromJson(data);
      return taxModel;
    } else {
      var data = jsonDecode(response.body);
      throw Exception(
          "${data["message"] == null || data["message"] == "" ? "Gagal mendapatkan data" : data["message"]}");
    }
  }

// Digunakan untuk mengambil data kategori kasir
  Future<CashierCategoryModel> getAllCashierCategory(
      {required String token}) async {
    var url = Uri.parse("$baseURL/category?status=true");
    var header = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: header);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      var data = jsonDecode(response.body);
      final CashierCategoryModel cashierCategoryModel =
          CashierCategoryModel.fromJson(data);
      return cashierCategoryModel;
    } else {
      var data = jsonDecode(response.body);
      throw Exception(
          "${data["message"] == null || data["message"] == "" ? "Gagal mendapatkan data" : data["message"]}");
    }
  }

  // Digunakan untuk mengirim data pesanan
  Future<void> postOrder({
    required String token,
    required OrderModel orderModel,
  }) async {
    var url = Uri.parse("$baseURL/invoice/create");
    var header = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var response = await http.post(
      url,
      headers: header,
      body: jsonEncode(orderModel.toJson()),
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      var data = jsonDecode(response.body);
      throw Exception("${data['errors'] ?? data['message']}");
    }
  }
}

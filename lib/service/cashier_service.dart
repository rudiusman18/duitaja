import 'dart:convert';

import 'package:duidku/model/cashier_category_model.dart';
import 'package:duidku/model/order_model.dart';
import 'package:duidku/model/sellable_product_model.dart';
import 'package:duidku/model/tax_model.dart';
import 'package:duidku/shared/utils.dart';
import 'package:http/http.dart' as http;

class CashierService {
  // Fungsi untuk mengambil data produk yang dijual (tampil di bagian menu)
  Future<SellableProductModel> getSellableProduct({
    required String token,
    required String page,
    required String limit,
    required String categoryId,
  }) async {
    var url = Uri.parse(
        "$baseURL/sellable?page=$page&limit=$limit&category_id=$categoryId");
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

  Future<void> postOrder({
    required String token,
    required OrderModel order,
  }) async {}
}

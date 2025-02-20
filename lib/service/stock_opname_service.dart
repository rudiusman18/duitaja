import 'dart:convert';

import 'package:duitaja/model/detail_stock_opname_model.dart';
import 'package:duitaja/model/stock_opname_available_items_model.dart';
import 'package:duitaja/model/stock_opname_model.dart';
import 'package:duitaja/shared/utils.dart';
import 'package:http/http.dart' as http;
import 'package:duitaja/model/stock_opname_available_items_model.dart'
    as availableItem;

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

  Future<StockOpnameAvailableItemModel> getAllAvailableStockItem(
      {required String token}) async {
    var url = Uri.parse("$baseURL/stock-opname/available-stock");
    var header = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var response = await http.get(url, headers: header);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      var data = jsonDecode(response.body);
      final StockOpnameAvailableItemModel stockOpnameAvailableItemModel =
          StockOpnameAvailableItemModel.fromJson(data);
      return stockOpnameAvailableItemModel;
    } else {
      var data = jsonDecode(response.body);
      throw Exception(
          "${data["message"] == null || data["message"] == "" ? "Gagal mendapatkan data" : data["message"]}");
    }
  }

  Future<void> postReport({
    required String token,
    required String title,
    required List<availableItem.Payload> productDatas,
    required List<int> realStocks,
  }) async {
    var url = Uri.parse("$baseURL/stock-opname");
    var header = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    List<Map> dataItems = [];
    for (var index = 0; index < productDatas.length; index++) {
      if (dataItems.isEmpty) {
        dataItems = [
          {
            "quantity": realStocks[index],
            "stock_id": productDatas[index].id,
            "system_quantity": productDatas[index].quantity,
            "name": productDatas[index].name,
            "type": "makanan"
          }
        ];
      } else {
        dataItems.add({
          "quantity": realStocks[index],
          "stock_id": productDatas[index].id,
          "system_quantity": productDatas[index].quantity,
          "name": productDatas[index].name,
          "type": "makanan"
        });
      }
    }

    Map data = { 
      "title": title,
      "items": dataItems,
    };

    var body = jsonEncode(data);

    var response = await http.post(
      url,
      headers: header,
      body: body,
    );

    print(
        "token: $token, statusCode : ${response.statusCode}, dan body: ${response.body}");

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      var data = jsonDecode(response.body);
      return data['message'];
    } else {
      var data = jsonDecode(response.body);
      throw Exception("${data['errors']}");
    }
  }
}

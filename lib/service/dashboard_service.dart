import 'dart:convert';

import 'package:duitaja/model/dashboard_model.dart';
import 'package:duitaja/shared/utils.dart';
import 'package:http/http.dart' as http;

class DashboardService {
  Future<DashboardModel> getDashboard({
    required String token,
  }) async {
    var url = Uri.parse("$baseURL/dashboard/sales-resume");
    var header = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: header);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      var data = jsonDecode(response.body);
      DashboardModel dashboardModel = DashboardModel.fromJson(data);
      return dashboardModel;
    } else {
      var data = jsonDecode(response.body);
      throw ("${data["message"] == null || data["message"] == "" ? "Gagal mendapatkan data" : data["message"]}");
    }
  }
}

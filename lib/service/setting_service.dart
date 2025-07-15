import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:duitaja/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:mime/mime.dart';

import 'package:http_parser/http_parser.dart';

class SettingService {
  // Digunakan untuk mendapatkan data riwayat penjualan
  // Future<SaleHistoryModel> getSaleHistory({
  //   required String token,
  //   required String page,
  //   required String limit,
  //   required String status,
  //   required String startDate,
  //   required String endDate,
  //   required String search,
  //   required String inStatus,
  // }) async {
  //   var url = Uri.parse(
  //       "$baseURL/invoice/sales/history?page=$page&limit=$limit&status=$status&start_date=$startDate&end_date=$endDate&search=$search&in_status=$inStatus");

  //   var header = {
  //     'Authorization': 'Bearer $token',
  //     'Content-Type': 'application/json',
  //   };
  //   var response = await http.get(url, headers: header);

  //   if (response.statusCode >= 200 && response.statusCode <= 299) {
  //     var data = jsonDecode(response.body);
  //     final SaleHistoryModel saleHistoryModel = SaleHistoryModel.fromJson(data);
  //     return saleHistoryModel;
  //   } else {
  //     var data = jsonDecode(response.body);
  //     throw Exception(
  //         "${data["message"] == null || data["message"] == "" ? "Gagal mendapatkan data" : data["message"]}");
  //   }
  // }

  Future<void> uploadProfilePicture({
    required String token,
    required File imageFile,
    int quality = 60, // JPEG quality: 0 (worst) to 100 (best)
  }) async {
    try {
      final uri = Uri.parse("$baseURL/users/upload-avatar");

      // Decode original image (any format: JPG, PNG, WebP, etc.)
      final originalBytes = await imageFile.readAsBytes();
      final decodedImage = img.decodeImage(originalBytes);

      if (decodedImage == null) {
        throw Exception("❌ Failed to decode image");
      }

      // Resize (optional)
      // final resized = img.copyResize(decodedImage, width: 800); // if needed
      final compressedJpeg = img.encodeJpg(decodedImage, quality: quality);

      final headers = {
        'Authorization': 'Bearer $token',
      };

      final mimeType = 'image/jpeg'; // we always encode to JPEG
      final multipartFile = http.MultipartFile.fromBytes(
        'avatar', // 🔁 use correct field name expected by backend
        Uint8List.fromList(compressedJpeg),
        filename: 'avatar.jpg',
        contentType: MediaType('image', 'jpeg'),
      );

      final request = http.MultipartRequest('PUT', uri)
        ..headers.addAll(headers)
        ..files.add(multipartFile);

      final response = await request.send();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('✅ Compressed image uploaded successfully');
      } else {
        final respStr = await response.stream.bytesToString();
        final data = jsonDecode(respStr);
        throw Exception('❌ ${data["message"] ?? "Upload failed"}');
      }
    } catch (e) {
      throw Exception('❌ Error uploading image: $e');
    }
  }
}

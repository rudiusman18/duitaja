import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

// Digunakan untuk mengubah format number menjadi Rupiah
String formatCurrency(int number) {
  final formatter = NumberFormat.currency(
    locale: 'id', // Indonesian locale
    symbol: 'Rp. ', // Currency symbol
    decimalDigits: 0, // No decimal points
  );
  return formatter.format(number);
}

// Digunakan untuk meminta permission camera dan penyimpanan file
Future<bool> requestPermissions() async {
  var status = await Permission.camera.request();
  bool camerapermission = false;
  bool storagePermission = false;
  if (status.isGranted) {
    camerapermission = true;
    // The permission was granted, you can now access the camera.
  } else {
    // The permission was denied, handle appropriately.
    camerapermission = false;
  }

  var storageStatus = await Permission.storage.request();
  if (storageStatus.isGranted) {
    // Storage access granted.
    storagePermission = true;
  } else {
    // Storage access denied.
    storagePermission = false;
  }

  if (camerapermission == true && storagePermission == true) {
    return true;
  } else {
    return false;
  }
}

// Base URL yang digunakan untuk mengambil data
var baseURL = "https://be-duitaja.cahayateknik.works/api/v1";

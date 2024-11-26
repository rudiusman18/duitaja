import 'package:intl/intl.dart';

// Digunakan untuk mengubah format number menjadi Rupiah
String formatCurrency(int number) {
  final formatter = NumberFormat.currency(
    locale: 'id', // Indonesian locale
    symbol: 'Rp. ', // Currency symbol
    decimalDigits: 0, // No decimal points
  );
  return formatter.format(number);
}

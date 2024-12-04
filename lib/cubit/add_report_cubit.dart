import 'package:flutter_bloc/flutter_bloc.dart';

class AddReportCubit extends Cubit<Map<String, dynamic>> {
  AddReportCubit() : super({});

  void initAddReport(Map<String, dynamic> data) {
    emit(data);
  }

  void decreaseStock(Map<String, dynamic> data) {
    var stockData = data;
    if (stockData['amount'] != '1') {
      stockData['amount'] = "${int.parse(stockData['amount']) - 1}";
    }
    emit(stockData);
  }

  void increaseStock(Map<String, dynamic> data) {
    var stockData = data;
    stockData['amount'] = "${int.parse(stockData['amount']) + 1}";
    emit(stockData);
  }
}

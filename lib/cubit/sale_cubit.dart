import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:duidku/model/detail_sale_history_model.dart';
import 'package:duidku/model/sale_history_model.dart';
import 'package:duidku/service/sale_service.dart';
import 'package:meta/meta.dart';

part 'sale_state.dart';

class SaleCubit extends Cubit<SaleState> {
  SaleCubit() : super(SaleInitial());

  SaleHistoryModel get saleHistoryModel => state.saleHistoryModel;

  Future<void> allSalesHistory({
    required String token,
    required String page,
    required String limit,
    required String status,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final data = await SaleService().getSaleHistory(
          token: token,
          page: page,
          limit: limit,
          status: status,
          startDate: startDate,
          endDate: endDate);
      emit(SaleSuccess(data));
    } catch (e) {
      if (e.toString().contains("E_UNAUTHORIZE_ACCESS")) {
        emit(SaleTokenExpired());
      } else {
        emit(SaleFailure(e.toString()));
      }
    }
  }
}

class DetailSaleCubit extends Cubit<DetailSaleState> {
  DetailSaleCubit() : super(DetailSaleInitial());

  DetailSaleHistoryModel get detailSaleHistoryModel =>
      state.detailSaleHistoryModel;

  Future<void> detailSalesHistory(
      {required String token, required String payloadId}) async {
    emit(DetailSaleLoading());
    try {
      final data = await SaleService()
          .getDetailSaleHistory(token: token, payloadId: payloadId);
      emit(DetailSaleSuccess(data));
    } catch (e) {
      if (e.toString().contains("E_UNAUTHORIZE_ACCESS")) {
        emit(DetailSaleTokenExpired());
      } else {
        emit(DetailSaleFailure(e.toString()));
      }
    }
  }
}

class RefundSaleCubit extends Cubit<RefundSaleState> {
  RefundSaleCubit() : super(RefundSaleInitial());

  Future<void> refundSalesHistory({
    required String token,
    required String payloadId,
  }) async {
    emit(RefundSaleLoading());
    try {
      final _ = await SaleService()
          .putRefundSaleHistory(token: token, payloadId: payloadId);
      print("sukses");
      emit(RefundSaleSuccess());
    } catch (e) {
      print("gagal $e");
      if (e.toString().contains("E_UNAUTHORIZE_ACCESS")) {
        emit(RefundSaleTokenExpired());
      } else {
        emit(RefundSaleFailure(e.toString()));
      }
    }
  }
}

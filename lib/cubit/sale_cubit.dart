import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:duitaja/model/detail_sale_history_model.dart';
import 'package:duitaja/model/sale_history_model.dart';
import 'package:duitaja/service/sale_service.dart';
import 'package:meta/meta.dart';

part 'sale_state.dart';

class SaleCubit extends Cubit<SaleState> {
  SaleCubit() : super(SaleInitial());

  SaleHistoryModel get saleHistoryModel => state.saleHistoryModel;

  Future<void> resetSalesHistory() async {
    emit(SaleReset());
  }

  Future<void> allSalesHistory({
    required String token,
    required String page,
    required String limit,
    required String status,
    required String startDate,
    required String endDate,
    required String search,
    required String inStatus,
  }) async {
    emit(SaleLoading());
    try {
      final data = await SaleService().getSaleHistory(
        token: token,
        page: page,
        limit: limit,
        status: status,
        startDate: startDate,
        endDate: endDate,
        search: search,
        inStatus: inStatus,
      );
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

  Future<void> clearSalesHistory() async {
    emit(DetailSaleSuccess(DetailSaleHistoryModel()));
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
      emit(RefundSaleSuccess());
    } catch (e) {
      if (e.toString().contains("E_UNAUTHORIZE_ACCESS")) {
        emit(RefundSaleTokenExpired());
      } else {
        emit(RefundSaleFailure(e.toString()));
      }
    }
  }
}

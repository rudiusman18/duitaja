import 'package:bloc/bloc.dart';
import 'package:duitaja/model/detail_stock_management_model.dart';
import 'package:duitaja/model/stock_management_model.dart';
import 'package:duitaja/service/stock_management_service.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

part 'stock_management_state.dart';

class StockManagementCubit extends Cubit<StockManagementState> {
  StockManagementCubit() : super(StockManagementInitial());

  StockManagementModel get stockManagementModel => state.stockManagementModel;

  Future<void> stockManagementData({
    required String token,
    required String page,
    required String limit,
    required String categoryId,
    required String inStatus,
    required String search,
  }) async {
    emit(StockManagementLoading());
    try {
      var data = await StockManagementService().getAllStockManagement(
          token: token,
          page: page,
          limit: limit,
          categoryId: categoryId,
          inStatus: inStatus,
          search: search);
      emit(StockManagementSuccess(data));
    } catch (e) {
      if (e.toString().contains("E_UNAUTHORIZE_ACCESS")) {
        emit(StockManagementTokenExpired());
      } else {
        emit(StockManagementFailure(e.toString()));
      }
    }
  }

  Future<void> stockManagementReset() async {
    emit(StockManagementReset());
  }
}

class DetailStockManagementCubit extends Cubit<DetailStockManagementState> {
  DetailStockManagementCubit() : super(DetailStockManagementInitial());
  Future<void> detailStockManagementData(
      {required String token, required String productId}) async {
    emit(DetailStockManagementLoading());
    try {
      var data = await StockManagementService()
          .getDetailStockManagement(token: token, productId: productId);
      emit(DetailStockManagementSuccess(data));
    } catch (e) {
      if (e.toString().contains("E_UNAUTHORIZE_ACCESS")) {
        emit(DetailStockManagementTokenExpired());
      } else {
        emit(DetailStockManagementFailure(e.toString()));
      }
    }
  }

  Future<void> updateStockManagementData({
    required String token,
    required String productId,
    required String? promoId,
    required String? description,
    required String status,
    required String quantity,
  }) async {
    emit(DetailStockManagementLoading());
    try {
      var _ = await StockManagementService().putEditStock(
          token: token,
          productId: productId,
          promoId: promoId,
          description: description,
          status: status,
          quantity: quantity);

      emit(DetailStockManagementUpdateSuccess());
    } catch (e) {
      if (e.toString().contains("E_UNAUTHORIZE_ACCESS")) {
        emit(DetailStockManagementTokenExpired());
      } else {
        emit(DetailStockManagementFailure(e.toString()));
      }
    }
  }
}

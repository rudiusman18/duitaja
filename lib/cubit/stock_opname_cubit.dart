import 'package:bloc/bloc.dart';
import 'package:duitaja/model/detail_stock_opname_model.dart';
import 'package:duitaja/model/stock_opname_available_items_model.dart';
import 'package:duitaja/model/stock_opname_model.dart' as stock;
import 'package:duitaja/service/stock_opname_service.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

part 'stock_opname_state.dart';

class StockOpnameCubit extends Cubit<StockOpnameState> {
  StockOpnameCubit() : super(StockOpnameInitial());

  Future<void> allStockOpnameData({
    required String token,
    required String page,
    required String limit,
  }) async {
    emit(StockOpnameLoading());
    try {
      var data = await StockOpnameService()
          .getAllStockOpname(token: token, page: page, limit: limit);
      emit(StockOpnameSuccess(data));
    } catch (e) {
      if (e.toString().contains("E_UNAUTHORIZE_ACCESS")) {
        emit(StockOpnameTokenExpired());
      } else {
        emit(StockOpnameFailure(e.toString()));
      }
    }
  }
}

class StockOpnameDetailCubit extends Cubit<StockOpnameDetailState> {
  StockOpnameDetailCubit() : super(const StockOpnameDetailInitial());

  stock.Payload get stockData => state.stockOpnameModel ?? stock.Payload();

  setStockOpnameData({required stock.Payload stockOpnameData}) {
    emit(StockOpnameDetailInitial(stockOpnameData: stockOpnameData));
  }

  Future<void> detailStockOpname(
      {required String token, required String stockOpnameID}) async {
    emit(StockOpnameDetailLoading());
    try {
      var data = await StockOpnameService()
          .getDetailStockOpname(token: token, stockOpnameID: stockOpnameID);
      emit(StockOpnameDetailSuccess(data));
    } catch (e) {
      if (e.toString().contains("E_UNAUTHORIZE_ACCESS")) {
        emit(StockOpnameDetailTokenExpired());
      } else {
        emit(StockOpnameDetailFailure(e.toString()));
      }
    }
  }
}

class StockOpnameAvailableItemCubit
    extends Cubit<StockOpnameAvailableItemState> {
  StockOpnameAvailableItemCubit() : super(StockOpnameAvailableItemInitial());

  Future<void> allAvailableItem({required String token}) async {
    emit(StockOpnameAvailableItemLoading());
    try {
      var data =
          await StockOpnameService().getAllAvailableStockItem(token: token);
      emit(StockOpnameAvailableItemSuccess(data));
    } catch (e) {
      if (e.toString().contains("E_UNAUTHORIZE_ACCESS")) {
        emit(StockOpnameAvailableItemTokenExpired());
      } else {
        emit(StockOpnameAvailableItemFailure(e.toString()));
      }
    }
  }
}

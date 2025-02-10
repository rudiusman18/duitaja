import 'package:bloc/bloc.dart';
import 'package:duitaja/model/stock_management_model.dart';
import 'package:duitaja/service/stock_management_service.dart';
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
}

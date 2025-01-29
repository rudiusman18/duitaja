import 'package:bloc/bloc.dart';
import 'package:duidku/model/sellable_product_model.dart';
import 'package:duidku/service/cashier_service.dart';
import 'package:meta/meta.dart';

part 'product_menu_state.dart';

class ProductMenuCubit extends Cubit<ProductMenuState> {
  CashierService cashierService = CashierService();
  ProductMenuCubit() : super(ProductMenuInitial());

  SellableProductModel get sellableProductModel => state.sellableProductModel;

  Future<void> sellableProduct({
    required String token,
    required String page,
    required String limit,
  }) async {
    emit(ProductMenuLoading());
    try {
      // if (page == "1") {
      //   emit(ProductMenuInitial());
      // }
      final data = await cashierService.getSellableProduct(
          token: token, page: page, limit: limit);
      emit(ProductMenuSuccess(data));
    } catch (e) {
      if (e.toString().contains("E_UNAUTHORIZE_ACCESS")) {
        emit(ProductMenuTokenExpired());
      } else {
        emit(ProductMenuFailure(e.toString()));
      }
    }
  }
}

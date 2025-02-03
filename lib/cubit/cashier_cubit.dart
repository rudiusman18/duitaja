import 'package:bloc/bloc.dart';
import 'package:duidku/model/cashier_category_model.dart';
import 'package:duidku/model/tax_model.dart';
import 'package:duidku/service/cashier_service.dart';
import 'package:meta/meta.dart';
import 'package:duidku/model/product_model.dart';

import 'package:duidku/model/sellable_product_model.dart';

part 'cashier_state.dart';

class CashierCubit extends Cubit<CashierState> {
  CashierService cashierService = CashierService();
  CashierCubit() : super(CashierInitial());

  TaxModel get taxModel => state.taxtModel;

  Future<void> tax({required String token}) async {
    emit(CashierLoading());
    try {
      final data = await CashierService().getAllTax(token: token);
      emit(CashierSuccess(data));
    } catch (e) {
      if (e.toString().contains("E_UNAUTHORIZE_ACCESS")) {
        emit(CashierTokenExpired());
      } else {
        emit(CashierFailure(e.toString()));
      }
    }
  }
}

class IndexCashierFilterCubit extends Cubit<IndexCashierFilterState> {
  IndexCashierFilterCubit() : super(IndexCashierFilterInitial());
  CashierCategoryModel get cashierCategoryModel => state.cashierCategoryModel;
  int get cashierCategoryIndex => state.categoryIndex;

  void setIndex(int index) {
    emit(IndexCashierFilterIndex(index, state.cashierCategoryModel));
  }

  Future<void> category({required String token}) async {
    emit(IndexCashierFilterLoading(state.categoryIndex));
    try {
      final data = await CashierService().getAllCashierCategory(token: token);
      emit(IndexCashierFilterSuccess(state.categoryIndex, data));
    } catch (e) {
      if (e.toString().contains("E_UNAUTHORIZE_ACCESS")) {
        emit(IndexCashierFilterTokenExpired());
      } else {
        emit(IndexCashierFilterFailure(state.categoryIndex, e.toString()));
      }
    }
  }
}

class ProductCartCubit extends Cubit<List<ProductModel>> {
  ProductCartCubit() : super([]);

  void addProduct(List<ProductModel> products) {
    emit(products);
  }
}

class ProductMenuCubit extends Cubit<ProductMenuState> {
  CashierService cashierService = CashierService();
  ProductMenuCubit() : super(ProductMenuInitial());

  SellableProductModel get sellableProductModel => state.sellableProductModel;

  Future<void> sellableProduct({
    required String token,
    required String page,
    required String limit,
    required String categoryId,
  }) async {
    emit(ProductMenuLoading());
    try {

      final data = await cashierService.getSellableProduct(
        token: token,
        page: page,
        limit: limit,
        categoryId: categoryId,
      );
      emit(ProductMenuSuccess(data));
    } catch (e) {
      if (e.toString().contains("E_UNAUTHORIZE_ACCESS")) {
        emit(ProductMenuTokenExpired());
      } else {
        emit(ProductMenuFailure(e.toString()));
      }
    }
  }

  void addProducts(List<SellableProductModel> products) {}
}

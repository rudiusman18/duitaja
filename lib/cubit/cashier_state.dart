part of 'cashier_cubit.dart';

@immutable
sealed class CashierState {
  final TaxModel taxtModel;
  const CashierState(this.taxtModel);
}

class CashierInitial extends CashierState {
  CashierInitial() : super(TaxModel());
}

final class CashierLoading extends CashierState {
  CashierLoading() : super(TaxModel());
}

final class CashierSuccess extends CashierState {
  final TaxModel taxModel;
  const CashierSuccess(this.taxModel) : super(taxModel);
}

final class CashierFailure extends CashierState {
  final String error;
  CashierFailure(this.error) : super(TaxModel());
}

final class CashierTokenExpired extends CashierState {
  CashierTokenExpired() : super(TaxModel());
}

@immutable
class ProductMenuState {
  final SellableProductModel sellableProductModel;
  const ProductMenuState(this.sellableProductModel);
}

final class ProductMenuInitial extends ProductMenuState {
  ProductMenuInitial() : super(SellableProductModel());
}

final class ProductMenuLoading extends ProductMenuState {
  ProductMenuLoading() : super(SellableProductModel());
}

final class ProductMenuSuccess extends ProductMenuState {
  final SellableProductModel sellableData;
  const ProductMenuSuccess(this.sellableData) : super(sellableData);
}

final class ProductMenuFailure extends ProductMenuState {
  final String error;
  ProductMenuFailure(this.error) : super(SellableProductModel());
}

final class ProductMenuTokenExpired extends ProductMenuState {
  ProductMenuTokenExpired() : super(SellableProductModel());
}

@immutable
class IndexCashierFilterState {
  final int categoryIndex;
  final CashierCategoryModel cashierCategoryModel;
  const IndexCashierFilterState(this.categoryIndex, this.cashierCategoryModel);
}

final class IndexCashierFilterIndex extends IndexCashierFilterState {
  final int index;
  final CashierCategoryModel cashierCategoryModel;
  const IndexCashierFilterIndex(this.index, this.cashierCategoryModel)
      : super(index, cashierCategoryModel);
}

final class IndexCashierFilterInitial extends IndexCashierFilterState {
  IndexCashierFilterInitial() : super(0, CashierCategoryModel());
}

final class IndexCashierFilterLoading extends IndexCashierFilterState {
  final int index;
  IndexCashierFilterLoading(this.index) : super(index, CashierCategoryModel());
}

final class IndexCashierFilterSuccess extends IndexCashierFilterState {
  final int index;
  final CashierCategoryModel categoryModel;
  const IndexCashierFilterSuccess(this.index, this.categoryModel)
      : super(index, categoryModel);
}

final class IndexCashierFilterFailure extends IndexCashierFilterState {
  final int index;
  final String error;
  IndexCashierFilterFailure(this.index, this.error)
      : super(index, CashierCategoryModel());
}

final class IndexCashierFilterTokenExpired extends IndexCashierFilterState {
  IndexCashierFilterTokenExpired() : super(0, CashierCategoryModel());
}

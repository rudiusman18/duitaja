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

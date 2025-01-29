part of 'product_menu_cubit.dart';

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

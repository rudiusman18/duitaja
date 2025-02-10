part of 'stock_management_cubit.dart';

@immutable
class StockManagementState {
  final StockManagementModel stockManagementModel;
  const StockManagementState(this.stockManagementModel);
}

final class StockManagementInitial extends StockManagementState {
  StockManagementInitial() : super(StockManagementModel());
}

final class StockManagementLoading extends StockManagementState {
  StockManagementLoading() : super(StockManagementModel());
}

final class StockManagementSuccess extends StockManagementState {
  final StockManagementModel stockManagementData;
  const StockManagementSuccess(this.stockManagementData)
      : super(stockManagementData);
}

final class StockManagementFailure extends StockManagementState {
  final String error;
  StockManagementFailure(this.error) : super(StockManagementModel());
}

final class StockManagementTokenExpired extends StockManagementState {
  StockManagementTokenExpired() : super(StockManagementModel());
}

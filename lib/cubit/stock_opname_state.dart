part of 'stock_opname_cubit.dart';

@immutable
sealed class StockOpnameState {}

final class StockOpnameInitial extends StockOpnameState {}

final class StockOpnameLoading extends StockOpnameState {}

final class StockOpnameSuccess extends StockOpnameState {
  final stock.StockOpnameModel stockOpnameData;
  StockOpnameSuccess(this.stockOpnameData);
}

final class StockOpnameFailure extends StockOpnameState {
  final String error;
  StockOpnameFailure(this.error);
}

final class StockOpnameTokenExpired extends StockOpnameState {}

@immutable
sealed class StockOpnameDetailState {
  final stock.Payload? stockOpnameModel;
  const StockOpnameDetailState({this.stockOpnameModel});
}

final class StockOpnameDetailInitial extends StockOpnameDetailState {
  final stock.Payload? stockOpnameData;
  const StockOpnameDetailInitial({this.stockOpnameData})
      : super(stockOpnameModel: stockOpnameData);
}

final class StockOpnameDetailLoading extends StockOpnameDetailState {}

final class StockOpnameDetailSuccess extends StockOpnameDetailState {
  final DetailStockOpnameModel detailStockOpnameData;
  const StockOpnameDetailSuccess(this.detailStockOpnameData);
}

final class StockOpnameDetailFailure extends StockOpnameDetailState {
  final String error;
  const StockOpnameDetailFailure(this.error);
}

final class StockOpnameDetailTokenExpired extends StockOpnameDetailState {}

part of 'sale_cubit.dart';

@immutable
final class SaleState {
  final SaleHistoryModel saleHistoryModel;
  const SaleState(this.saleHistoryModel);
}

final class SaleInitial extends SaleState {
  SaleInitial() : super(SaleHistoryModel());
}

final class SaleLoading extends SaleState {
  SaleLoading() : super(SaleHistoryModel());
}

final class SaleSuccess extends SaleState {
  final SaleHistoryModel saleHistoryData;
  const SaleSuccess(this.saleHistoryData) : super(saleHistoryData);
}

final class SaleFailure extends SaleState {
  final String error;
  SaleFailure(this.error) : super(SaleHistoryModel());
}

final class SaleTokenExpired extends SaleState {
  SaleTokenExpired() : super(SaleHistoryModel());
}

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

@immutable
final class DetailSaleState {
  final DetailSaleHistoryModel detailSaleHistoryModel;
  const DetailSaleState(this.detailSaleHistoryModel);
}

final class DetailSaleInitial extends DetailSaleState {
  DetailSaleInitial() : super(DetailSaleHistoryModel());
}

final class DetailSaleLoading extends DetailSaleState {
  DetailSaleLoading() : super(DetailSaleHistoryModel());
}

final class DetailSaleSuccess extends DetailSaleState {
  final DetailSaleHistoryModel detailData;
  const DetailSaleSuccess(this.detailData) : super(detailData);
}

final class DetailSaleFailure extends DetailSaleState {
  final String error;
  DetailSaleFailure(this.error) : super(DetailSaleHistoryModel());
}

final class DetailSaleTokenExpired extends DetailSaleState {
  DetailSaleTokenExpired() : super(DetailSaleHistoryModel());
}

@immutable
final class RefundSaleState {}

final class RefundSaleInitial extends RefundSaleState {}

final class RefundSaleLoading extends RefundSaleState {}

final class RefundSaleSuccess extends RefundSaleState {}

final class RefundSaleFailure extends RefundSaleState {
  final String error;
  RefundSaleFailure(this.error);
}

final class RefundSaleTokenExpired extends RefundSaleState {}

part of 'dashboard_cubit.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

final class DashboardSuccess extends DashboardState {
  final DashboardModel dashboardModel;
  DashboardSuccess(this.dashboardModel);
}

final class DashboardFailure extends DashboardState {
  final String error;
  DashboardFailure(this.error);
}

final class DashboardTokenExpired extends DashboardState {}

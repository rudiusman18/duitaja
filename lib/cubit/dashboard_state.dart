part of 'dashboard_cubit.dart';

@immutable
sealed class DashboardState {
  final DashboardModel dashboardModelData;
  const DashboardState({required this.dashboardModelData});
}

final class DashboardInitial extends DashboardState {
  DashboardInitial() : super(dashboardModelData: DashboardModel());
}

final class DashboardLoading extends DashboardState {
  DashboardLoading() : super(dashboardModelData: DashboardModel());
}

final class DashboardSuccess extends DashboardState {
  final DashboardModel dashboardModel;
  const DashboardSuccess(this.dashboardModel)
      : super(dashboardModelData: dashboardModel);
}

final class DashboardFailure extends DashboardState {
  final String error;
  DashboardFailure(this.error) : super(dashboardModelData: DashboardModel());
}

final class DashboardTokenExpired extends DashboardState {
  DashboardTokenExpired() : super(dashboardModelData: DashboardModel());
}

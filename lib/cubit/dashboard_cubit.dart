import 'package:bloc/bloc.dart';
import 'package:duitaja/model/dashboard_model.dart';
import 'package:duitaja/service/dashboard_service.dart';
import 'package:meta/meta.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

  Future<void> dashboardData({
    required String token,
  }) async {
    emit(DashboardLoading());
    try {
      DashboardModel data = await DashboardService().getDashboard(token: token);

      emit(DashboardSuccess(data));
    } catch (e) {
      if (e.toString().contains("E_UNAUTHORIZE_ACCESS")) {
        emit(DashboardTokenExpired());
      } else {
        emit(DashboardFailure(e.toString()));
      }
    }
  }
}

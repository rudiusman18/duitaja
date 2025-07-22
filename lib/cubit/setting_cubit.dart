import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:duitaja/model/log_activity_model.dart';
import 'package:duitaja/service/setting_service.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());
}

class ActivityLogCubit extends Cubit<ActivityLogState> {
  ActivityLogCubit() : super(ActivityLogInitial());

  void getActivityLog({required String token}) async {
    emit(ActivityLogLoading());
    try {
      LogActivityModel logActivityModel =
          await SettingService().getLogActivity(token: token);
      emit(ActivityLogSuccess(logActivityModel));
    } catch (e) {
      if (e.toString().contains("E_UNAUTHORIZE_ACCESS")) {
        emit(ActivityLogTokenExpired());
      } else {
        emit(ActivityLogFailure(e.toString()));
      }
    }
  }
}

class UploadProfilePictCubit extends Cubit<UploadProfilePictState> {
  UploadProfilePictCubit() : super(UploadProfilePictInitial());

  void uploadProfilePict(
      {required String token, required File imageFile}) async {
    emit(UploadProfilePictLoading());
    try {
      final _ = await SettingService().uploadProfilePicture(
        token: token,
        imageFile: imageFile,
      );
      emit(UploadProfilePictSuccess());
    } catch (e) {
      print("Error dengan isi $e");

      if (e.toString().contains("E_UNAUTHORIZE_ACCESS")) {
        emit(UploadProfilePictTokenExpired());
      } else {
        emit(UploadProfilePictFailure(e.toString()));
      }
    }
  }
}

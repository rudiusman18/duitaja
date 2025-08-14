part of 'setting_cubit.dart';

sealed class SettingState {}

final class SettingInitial extends SettingState {}

sealed class ActivityLogState {
  final LogActivityModel logActivityModel;
  const ActivityLogState({required this.logActivityModel});
}

final class ActivityLogInitial extends ActivityLogState {
  ActivityLogInitial() : super(logActivityModel: LogActivityModel());
}

final class ActivityLogLoading extends ActivityLogState {
  ActivityLogLoading() : super(logActivityModel: LogActivityModel());
}

final class ActivityLogSuccess extends ActivityLogState {
  final LogActivityModel logActivityModelData;
  ActivityLogSuccess(this.logActivityModelData)
      : super(logActivityModel: logActivityModelData);
}

final class ActivityLogFailure extends ActivityLogState {
  final String error;
  ActivityLogFailure(this.error) : super(logActivityModel: LogActivityModel());
}

final class ActivityLogTokenExpired extends ActivityLogState {
  ActivityLogTokenExpired() : super(logActivityModel: LogActivityModel());
}

sealed class UploadProfilePictState {}

final class UploadProfilePictInitial extends UploadProfilePictState {}

final class UploadProfilePictLoading extends UploadProfilePictState {}

final class UploadProfilePictSuccess extends UploadProfilePictState {}

final class UploadProfilePictFailure extends UploadProfilePictState {
  final String error;
  UploadProfilePictFailure(this.error);
}

final class UploadProfilePictTokenExpired extends UploadProfilePictState {}

abstract class EmployeeState {}

final class EmployeeInitial extends EmployeeState {}

part of 'setting_cubit.dart';

sealed class SettingState {}

final class SettingInitial extends SettingState {}

sealed class ActivityLogState {}

final class ActivityLogInitial extends ActivityLogState {}

sealed class UploadProfilePictState {}

final class UploadProfilePictInitial extends UploadProfilePictState {}

final class UploadProfilePictLoading extends UploadProfilePictState {}

final class UploadProfilePictSuccess extends UploadProfilePictState {}

final class UploadProfilePictFailure extends UploadProfilePictState {
  final String error;
  UploadProfilePictFailure(this.error);
}

final class UploadProfilePictTokenExpired extends UploadProfilePictState {}

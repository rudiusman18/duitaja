// ignore_for_file: annotate_overrides, overridden_fields

part of 'auth_cubit.dart';

class AuthState {
  final ProfileModel profileModel;
  const AuthState(this.profileModel);
}

final class AuthInitial extends AuthState {
  AuthInitial() : super(ProfileModel());
}

final class AuthLoading extends AuthState {
  AuthLoading() : super(ProfileModel());
}

final class LoginSuccess extends AuthState {
  final ProfileModel profileModel;
  const LoginSuccess(this.profileModel) : super(profileModel);
}

final class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error) : super(ProfileModel());
}

final class RegisterSuccess extends AuthState {
  RegisterSuccess() : super(ProfileModel());
}

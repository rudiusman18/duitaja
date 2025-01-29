// ignore_for_file: annotate_overrides, overridden_fields

part of 'auth_cubit.dart';

class AuthState {
  final ProfileModel profileModel;
  final String? token;
  const AuthState(this.profileModel, this.token);
}

final class AuthInitial extends AuthState {
  AuthInitial() : super(ProfileModel(), null);
}

final class AuthLoading extends AuthState {
  AuthLoading() : super(ProfileModel(), null);
}

final class LoginSuccess extends AuthState {
  final ProfileModel profileModel;
  final String? token;
  const LoginSuccess(this.profileModel, this.token)
      : super(profileModel, token);
}

final class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error) : super(ProfileModel(), null);
}

final class RegisterSuccess extends AuthState {
  RegisterSuccess() : super(ProfileModel(), null);
}

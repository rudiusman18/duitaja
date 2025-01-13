import 'package:bloc/bloc.dart';
import 'package:duidku/model/profile_model.dart';
import 'package:duidku/service/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthService authService = AuthService();

  AuthCubit() : super(AuthInitial());

  ProfileModel get profileModel => state.profileModel;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final data =
          await authService.postLogin(email: email, password: password);
      final profileData =
          await authService.getProfile(token: data.payload?.token ?? "");
      emit(LoginSuccess(profileData));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String phoneNumber,
    required String email,
    required String companyName,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final _ = await authService.postRegister(
        name: name,
        email: email,
        password: password,
        phone: phoneNumber,
        companyName: companyName,
      );
      emit(RegisterSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}

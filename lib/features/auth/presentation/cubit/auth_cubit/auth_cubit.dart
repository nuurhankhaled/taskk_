import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/features/auth/data/repo/auth_repo.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;

  AuthCubit(this._authRepo) : super(AuthInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future<void> login() async {
    emit(LoginLoading());
    final result = await _authRepo.login(
      emailController.text,
      passwordController.text,
    );
    result.when(
      success: (_) {
        emailController.clear();
        passwordController.clear();
        emit(LoginSuccess());
      },
      failure: (error) => emit(LoginFailure(error)),
    );
  }

  Future<void> signup() async {
    emit(SignupLoading());
    final result = await _authRepo.register(
      emailController.text,
      passwordController.text,
    );
    result.when(
      success: (_) {
        emailController.clear();
        passwordController.clear();
        emit(SignupSuccess());
      },
      failure: (error) => emit(SignupFailure(error)),
    );
  }

  Future<void> logout() async {
    emit(LoginLoading());
    final result = await _authRepo.logout();
    result.when(
      success: (_) => emit(AuthInitial()),
      failure: (error) => emit(LoginFailure(error)),
    );
  }
}

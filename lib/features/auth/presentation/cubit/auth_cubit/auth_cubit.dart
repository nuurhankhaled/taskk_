import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/features/auth/data/repo/auth_repo.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;

  AuthCubit(this._authRepo) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    final result = await _authRepo.login(email, password);
    result.when(
      success: (_) => emit(LoginSuccess()),
      failure: (error) => emit(LoginFailure(error)),
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

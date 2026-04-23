import 'package:test_project/core/network/network/api_result.dart';

import 'package:test_project/features/auth/data/remote/auth_data_source.dart';

class AuthRepo {
  final AuthRemoteDataSource _authDataSource;

  AuthRepo(this._authDataSource);

  Future<AppResult<void>> login(String email, String password) async {
    try {
      await _authDataSource.login(email, password);
      return AppResult.success(null);
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }

  Future<AppResult<void>> register(String email, String password) async {
    try {
      await _authDataSource.register(email, password);
      return AppResult.success(null);
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }

  Future<AppResult<void>> logout() async {
    try {
      await _authDataSource.logout();
      return AppResult.success(null);
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }

  bool get isLoggedIn => _authDataSource.isLoggedIn;
}

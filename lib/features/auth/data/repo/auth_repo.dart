import 'package:test_project/core/network/network/api_result.dart';
import 'package:test_project/features/auth/data/local/user_local_data_source.dart';
import 'package:test_project/features/auth/data/models/user_model.dart';
import 'package:test_project/features/auth/data/remote/auth_data_source.dart';

class AuthRepo {
  final AuthRemoteDataSource _authDataSource;
  final UserLocalDataSource _userLocalDataSource;

  AuthRepo(this._authDataSource, this._userLocalDataSource);

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

  Future<AppResult<void>> saveUser(UserModel user) async {
    try {
      await _userLocalDataSource.saveUser(user);
      return AppResult.success(null);
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }

  AppResult<UserModel?> getUser() {
    try {
      return AppResult.success(_userLocalDataSource.getUser());
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }

  Future<AppResult<void>> deleteUser() async {
    try {
      await _userLocalDataSource.deleteUser();
      return AppResult.success(null);
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }

  bool get isLoggedIn => _authDataSource.isLoggedIn;
  bool get hasUser => _userLocalDataSource.hasUser;
}

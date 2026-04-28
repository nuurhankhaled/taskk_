import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:test_project/features/auth/data/models/user_model.dart';

class UserLocalDataSource {
  final Box _box;
  UserLocalDataSource(this._box);

  Future<void> saveUser(UserModel user) =>
      _box.put('user', jsonEncode(user.toJson()));

  UserModel? getUser() {
    final data = _box.get('user');
    if (data == null) return null;
    return UserModel.fromJson(jsonDecode(data as String));
  }

  Future<void> deleteUser() => _box.delete('user');

  bool get hasUser => _box.containsKey('user');
}

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<void> activateSession();
  Future<UserModel?> getCachedUser();
  Future<UserModel?> getActiveUser();
  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;
  static const String _userKey = 'CACHED_USER_KEY';
  static const String _sessionKey = 'ACTIVE_SESSION_KEY';

  AuthLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> cacheUser(UserModel user) async {
    final jsonString = jsonEncode(user.toJson());
    await secureStorage.write(key: _userKey, value: jsonString);
    await secureStorage.write(key: _sessionKey, value: 'true');
  }

  @override
  Future<void> activateSession() async {
    await secureStorage.write(key: _sessionKey, value: 'true');
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final jsonString = await secureStorage.read(key: _userKey);
    if (jsonString != null) {
      return UserModel.fromJson(jsonDecode(jsonString));
    }

    return null;
  }

  @override
  Future<UserModel?> getActiveUser() async {
    final isActive = await secureStorage.read(key: _sessionKey) == 'true';
    if (!isActive) return null;
    return getCachedUser();
  }

  @override
  Future<void> clearSession() async {
    await secureStorage.delete(key: _sessionKey);
  }
}

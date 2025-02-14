import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  // Manejo de tokens
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: 'accessToken', value: accessToken);
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'accessToken');
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refreshToken');
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: 'accessToken');
    await _storage.delete(key: 'refreshToken');
  }

  // Manejo de datos de usuario
  Future<void> saveUserData(String userData) async {
    await _storage.write(key: 'userData', value: userData);
  }

  Future<String?> getUserData() async {
    return await _storage.read(key: 'userData');
  }

  Future<void> clearUserData() async {
    await _storage.delete(key: 'userData');
  }
}

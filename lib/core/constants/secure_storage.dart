import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = FlutterSecureStorage();

  // Save data
  Future<void> saveData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Read data
  Future<String?> readData(String key) async {
    return await _storage.read(key: key);
  }

  // Delete specific key
  Future<void> deleteData(String key) async {
    await _storage.delete(key: key);
  }

  // Clear all data
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
  
  Future<void> storeToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

   Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

   Future<void> deleteToken() async {
    await _storage.delete(key: 'auth_token');
  }
}

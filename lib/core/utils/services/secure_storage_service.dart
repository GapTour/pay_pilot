import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage storage;
  SecureStorageService(this.storage);

  Future<bool> write(String key, String value) async {
    try {
      await storage.write(
        key: key,
        value: value,
        aOptions: const AndroidOptions(encryptedSharedPreferences: true),
      );
      return true;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return false;
    }
  }

  Future<String?> read(String key, {String? defaultValue}) async {
    try {
      final String? value = await storage.read(
        key: key,
        aOptions: const AndroidOptions(encryptedSharedPreferences: true),
      );
      return value ?? defaultValue;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return defaultValue;
    }
  }

  Future<bool> delete(String key) async {
    try {
      await storage.delete(
        key: key,
        aOptions: const AndroidOptions(encryptedSharedPreferences: true),
      );
      return true;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return false;
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iron_vault/models/credentials.dart';
import 'dart:convert';

class SecureStorage {
  final _secureStorage = FlutterSecureStorage();

  Future<void> saveCredentials(Credentials credentials) async {
    await _secureStorage.write(key: credentials.title!, value: jsonEncode(credentials));
  }

  Future<String?> getCredentials(String credentialsKey) async {
    return await _secureStorage.read(key: credentialsKey);
  }

  Future<Map<String, String>> getAllCredentials() async {
    return await _secureStorage.readAll();
  }

  Future<void> deleteCredentials(String credentialsKey) async {
    return await _secureStorage.delete(key: credentialsKey);
  }

  Future<void> deleteAll() async {
    return await _secureStorage.deleteAll();
  }

  Future<bool?> credentialsExist(String credentialsKey) async {
    return await _secureStorage.containsKey(key: credentialsKey);
  }
}

final storageProvider = Provider((ref) => SecureStorage());

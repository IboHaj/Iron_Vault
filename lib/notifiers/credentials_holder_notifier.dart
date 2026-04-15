import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iron_vault/models/credentials.dart';
import 'package:iron_vault/services/secure_storage.dart';

class CredentialsHolderNotifier extends AsyncNotifier<List<Map<String, Credentials>>> {
  @override
  Future<List<Map<String, Credentials>>> build() async => await getAllCredentials();

  Future<List<Map<String, Credentials>>> getAllCredentials() async {
    var jsonCredentials = await ref.read(storageProvider).getAllCredentials();
    return jsonCredentials.entries
        .map((e) => {e.key: Credentials.fromJson(json.decode(e.value))})
        .toList();
  }

  Future<void> addCredentials(Credentials credentials) async {
    state = const AsyncValue.loading();
    await ref.read(storageProvider).saveCredentials(credentials);
    state = await AsyncValue.guard(() async => getAllCredentials());
  }

  Future<void> deleteCredentials(Credentials credentials) async {
    state = const AsyncValue.loading();
    await ref.read(storageProvider).deleteCredentials(credentials.title!);
    state = await AsyncValue.guard(() async => await getAllCredentials());
  }

  Future<void> deleteAll() async {
    state = const AsyncValue.loading();
    await ref.read(storageProvider).deleteAll();
    state = await AsyncValue.guard(() async => await getAllCredentials());
  }
}

final allCredentialsProvider =
    AsyncNotifierProvider<CredentialsHolderNotifier, List<Map<String, Credentials>>>(
      () => CredentialsHolderNotifier(),
    );

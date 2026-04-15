import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iron_vault/views/main_view.dart';

void main() {
  runApp(ProviderScope(child: MainView()));
}

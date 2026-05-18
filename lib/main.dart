import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iron_vault/services/shared_preferences.dart';
import 'package:iron_vault/utils/theme.dart';
import 'package:iron_vault/views/lockscreen_view.dart';
import 'package:iron_vault/views/main_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();

  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MaterialTheme().dark(),
        home: SharedPrefs.sharedPrefs?.getBool("App_Lock") ?? false ? LockscreenView() : MainView(),
      ),
    ),
  );
}

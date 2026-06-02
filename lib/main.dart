import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iron_vault/services/shared_preferences.dart';
import 'package:iron_vault/utils/theme.dart';
import 'package:iron_vault/views/lockscreen_view.dart';
import 'package:iron_vault/views/main_view.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();

  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MaterialTheme().dark(),
        locale: Locale(SharedPrefs.sharedPrefs?.getString("App_Lang") ?? "en_GB") ,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SharedPrefs.sharedPrefs?.getBool("App_Lock") ?? false ? LockscreenView() : MainView(),
      ),
    ),
  );
}

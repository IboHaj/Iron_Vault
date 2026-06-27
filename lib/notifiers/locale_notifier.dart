import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iron_vault/services/shared_preferences.dart';

class LocaleNotifier extends Notifier<Locale>{
  @override
  Locale build() {
    return Locale(SharedPrefs.sharedPrefs?.getString("App_Lang") ?? "en");
  }

  void updateLocale(String newLocale) {
    state = Locale(newLocale);
    SharedPrefs.sharedPrefs?.setString("App_Lang", newLocale);
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(() => LocaleNotifier());
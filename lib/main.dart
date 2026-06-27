import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iron_vault/services/shared_preferences.dart';
import 'package:iron_vault/utils/theme.dart';
import 'package:iron_vault/views/lockscreen_view.dart';
import 'package:iron_vault/views/main_view.dart';
import 'l10n/app_localizations.dart';
import 'notifiers/locale_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();

  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var locale = ref.watch(localeProvider).languageCode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MaterialTheme().dark(),
      locale: Locale(locale),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SharedPrefs.sharedPrefs?.getBool("App_Lock") ?? false ? LockscreenView() : MainView(),
    );
  }
}
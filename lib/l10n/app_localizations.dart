import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('ar', 'EG'),
    Locale('en'),
  ];

  /// No description provided for @iron_vault.
  ///
  /// In en, this message translates to:
  /// **'IRON VAULT'**
  String get iron_vault;

  /// No description provided for @credentials_secured.
  ///
  /// In en, this message translates to:
  /// **'CREDENTIALS SECURED:'**
  String get credentials_secured;

  /// No description provided for @main_view_string.
  ///
  /// In en, this message translates to:
  /// **'Credentials are encrypted and stored locally on your device'**
  String get main_view_string;

  /// No description provided for @search_the_vault.
  ///
  /// In en, this message translates to:
  /// **'SEARCH THE VAULT'**
  String get search_the_vault;

  /// No description provided for @vault.
  ///
  /// In en, this message translates to:
  /// **'VAULT'**
  String get vault;

  /// No description provided for @pass_generator.
  ///
  /// In en, this message translates to:
  /// **'PASS. GENERATOR'**
  String get pass_generator;

  /// No description provided for @password_generator.
  ///
  /// In en, this message translates to:
  /// **'PASSWORD GENERATOR'**
  String get password_generator;

  /// No description provided for @generated_password.
  ///
  /// In en, this message translates to:
  /// **'Generated Password'**
  String get generated_password;

  /// No description provided for @generate_password.
  ///
  /// In en, this message translates to:
  /// **'Click Generate To Create A New Password'**
  String get generate_password;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'COPY'**
  String get copy;

  /// No description provided for @generate.
  ///
  /// In en, this message translates to:
  /// **'GENERATE'**
  String get generate;

  /// No description provided for @password_complexity.
  ///
  /// In en, this message translates to:
  /// **'PASSWORD COMPLEXITY'**
  String get password_complexity;

  /// No description provided for @poor.
  ///
  /// In en, this message translates to:
  /// **'POOR'**
  String get poor;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @fine.
  ///
  /// In en, this message translates to:
  /// **'FINE'**
  String get fine;

  /// No description provided for @great.
  ///
  /// In en, this message translates to:
  /// **'GREAT'**
  String get great;

  /// No description provided for @excellent.
  ///
  /// In en, this message translates to:
  /// **'EXCELLENT'**
  String get excellent;

  /// No description provided for @password_length.
  ///
  /// In en, this message translates to:
  /// **'PASSWORD LENGTH'**
  String get password_length;

  /// No description provided for @alphabet.
  ///
  /// In en, this message translates to:
  /// **'ALPHABET'**
  String get alphabet;

  /// No description provided for @aabbcc.
  ///
  /// In en, this message translates to:
  /// **'AaBbCc'**
  String get aabbcc;

  /// No description provided for @numbers.
  ///
  /// In en, this message translates to:
  /// **'NUMBERS'**
  String get numbers;

  /// No description provided for @numbers_string.
  ///
  /// In en, this message translates to:
  /// **'0123'**
  String get numbers_string;

  /// No description provided for @symbols.
  ///
  /// In en, this message translates to:
  /// **'SYMBOLS'**
  String get symbols;

  /// No description provided for @symbols_string.
  ///
  /// In en, this message translates to:
  /// **'!@#\$%'**
  String get symbols_string;

  /// No description provided for @new_entry.
  ///
  /// In en, this message translates to:
  /// **'NEW ENTRY'**
  String get new_entry;

  /// No description provided for @forge_new_entry.
  ///
  /// In en, this message translates to:
  /// **'FORGE A NEW ENTRY'**
  String get forge_new_entry;

  /// No description provided for @new_entry_string.
  ///
  /// In en, this message translates to:
  /// **'Initialize a new set of Credentials.'**
  String get new_entry_string;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'TITLE'**
  String get title;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'USERNAME'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'PASSWORD'**
  String get password;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'REQ*'**
  String get required;

  /// No description provided for @password_generation_settings.
  ///
  /// In en, this message translates to:
  /// **'PASSWORD GENERATION SETTINGS'**
  String get password_generation_settings;

  /// No description provided for @extra_notes.
  ///
  /// In en, this message translates to:
  /// **'EXTRA NOTES'**
  String get extra_notes;

  /// No description provided for @notes_go_here.
  ///
  /// In en, this message translates to:
  /// **'Notes go here...'**
  String get notes_go_here;

  /// No description provided for @secure_entry.
  ///
  /// In en, this message translates to:
  /// **'SECURE ENTRY'**
  String get secure_entry;

  /// No description provided for @entry_details.
  ///
  /// In en, this message translates to:
  /// **'ENTRY DETAILS'**
  String get entry_details;

  /// No description provided for @current_entry.
  ///
  /// In en, this message translates to:
  /// **'CURRENT ENTRY'**
  String get current_entry;

  /// No description provided for @security_health.
  ///
  /// In en, this message translates to:
  /// **'SECURITY HEALTH'**
  String get security_health;

  /// No description provided for @date_created.
  ///
  /// In en, this message translates to:
  /// **'DATE CREATED'**
  String get date_created;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @security_protocols.
  ///
  /// In en, this message translates to:
  /// **'SECURITY PROTOCOLS'**
  String get security_protocols;

  /// No description provided for @pin_lock.
  ///
  /// In en, this message translates to:
  /// **'PIN LOCK'**
  String get pin_lock;

  /// No description provided for @pin_lock_string.
  ///
  /// In en, this message translates to:
  /// **'Setup a 6 Digit PIN as an additional layer of security.'**
  String get pin_lock_string;

  /// No description provided for @pin_unlock_string.
  ///
  /// In en, this message translates to:
  /// **'A pin is already setup, click here to change it, long press to remove it.'**
  String get pin_unlock_string;

  /// No description provided for @clipboard_clearing.
  ///
  /// In en, this message translates to:
  /// **'CLIPBOARD CLEARING'**
  String get clipboard_clearing;

  /// No description provided for @clipboard_clearing_string.
  ///
  /// In en, this message translates to:
  /// **'Clears clipboard after 30 seconds of copying credentials.'**
  String get clipboard_clearing_string;

  /// No description provided for @vault_preferences.
  ///
  /// In en, this message translates to:
  /// **'VAULT PREFERENCES'**
  String get vault_preferences;

  /// No description provided for @dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get dark_mode;

  /// No description provided for @dark_mode_string.
  ///
  /// In en, this message translates to:
  /// **'Ironclad Obsidian Theme'**
  String get dark_mode_string;

  /// No description provided for @system_language.
  ///
  /// In en, this message translates to:
  /// **'System Language'**
  String get system_language;

  /// No description provided for @data_operations.
  ///
  /// In en, this message translates to:
  /// **'DATA OPERATIONS'**
  String get data_operations;

  /// No description provided for @export_credentials.
  ///
  /// In en, this message translates to:
  /// **'Export Credentials'**
  String get export_credentials;

  /// No description provided for @wipe_the_vault.
  ///
  /// In en, this message translates to:
  /// **'Wipe the Vault'**
  String get wipe_the_vault;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'ar':
      {
        switch (locale.countryCode) {
          case 'EG':
            return AppLocalizationsArEg();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

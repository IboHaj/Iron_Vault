import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iron_vault/models/credentials.dart';
import 'package:iron_vault/notifiers/credentials_holder_notifier.dart';
import 'package:iron_vault/services/shared_preferences.dart';
import 'package:iron_vault/utils/utils.dart';
import 'package:iron_vault/widgets/custom_appbar.dart';
import 'package:iron_vault/widgets/custom_button.dart';
import 'package:iron_vault/widgets/custom_dialog.dart';
import 'package:iron_vault/widgets/custom_snackbar.dart';
import 'package:iron_vault/widgets/custom_tile_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsView extends HookConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var clearClipboard = useState(SharedPrefs.sharedPrefs?.getBool("Clear_Clipboard") ?? false);
    var currentLanguage = useState(SharedPrefs.sharedPrefs?.getString("App_Lang") ?? "English US");
    var useDarkTheme = useState(SharedPrefs.sharedPrefs?.getBool("Dark_Theme") ?? true);
    var pinStatus = useState(SharedPrefs.sharedPrefs?.getBool("App_Lock") ?? false);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(
          title: "SETTINGS",
          bgColor: Theme.of(context).colorScheme.shadow,
          leadingIcon: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              size: 28 * context.scaled,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        body: Container(
          width: context.screenWidth,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: Theme.of(context).colorScheme.surfaceContainerLowest,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                padding: EdgeInsets.symmetric(horizontal: 12),
                alignment: .centerLeft,
                width: context.screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border(
                    left: BorderSide(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      width: 5,
                    ),
                  ),
                ),
                child: Text(
                  "SECURITY PROTOCOLS",
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.copyWith(fontSize: 24 * context.scaled),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: ShapeDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadiusGeometry.only(bottomRight: Radius.circular(12)),
                  ),
                ),
                child: Column(
                  spacing: 10,
                  mainAxisAlignment: .start,
                  mainAxisSize: .max,
                  children: [
                    ListTile(
                      title: Text(
                        "PIN LOCK",
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20 * context.scaled,
                        ),
                      ),
                      subtitle: Text(
                        pinStatus.value
                            ? "A pin is already setup, click here to change it, long press to remove it"
                            : "Setup a 6 Digit PIN as an additional layer of security",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 14 * context.scaled,
                          color: Theme.of(context).colorScheme.onSecondaryContainer,
                        ),
                      ),
                      onLongPress: () {
                        CustomDialog.showCustomWarningDialog(
                          context,
                          positiveLabel: "Cancel",
                          negativeLabel: "Remove",
                          content: "Are you sure you'd like to remove the current PIN?",
                          onTapPositive: () => Navigator.pop(context),
                          onTapNegative: () async {
                            var creds = await ref
                                .read(allCredentialsProvider.notifier)
                                .getCredentials("App_Lock");

                            await ref
                                .read(allCredentialsProvider.notifier)
                                .deleteCredentials(creds);
                            SharedPrefs.sharedPrefs?.setBool("App_Lock", false);
                            pinStatus.value = false;
                            if (context.mounted) Navigator.pop(context);
                          },
                          positiveIcon: Icons.cancel_sharp,
                          negativeIcon: Icons.check_circle_outline,
                        );
                      },
                      onTap: () async {
                        TextEditingController controller = TextEditingController();
                        if (pinStatus.value) {
                          var creds = await ref
                              .read(allCredentialsProvider.notifier)
                              .getCredentials("App_Lock");
                          if (context.mounted) {
                            CustomDialog.showPasswordDialog(context, controller, () {
                              if (controller.text == creds.password) {
                                Navigator.pop(context);
                                controller.clear();
                                CustomDialog.showPasswordDialog(context, controller, () async {
                                  ref
                                      .read(allCredentialsProvider.notifier)
                                      .addCredentials(
                                        Credentials(title: "App_Lock", password: controller.text),
                                      );
                                  var prefs = await SharedPreferences.getInstance();
                                  prefs.setBool("App_Lock", true);
                                  pinStatus.value = true;
                                  if (context.mounted) Navigator.pop(context);
                                });
                              } else {
                                CustomSnackbar.show(context, SnackBarUse.error, "Incorrect PIN");
                              }
                            }, changingPassword: true);
                          }
                        } else {
                          CustomDialog.showPasswordDialog(context, controller, () async {
                            ref
                                .read(allCredentialsProvider.notifier)
                                .addCredentials(
                                  Credentials(title: "App_Lock", password: controller.text),
                                );
                            var prefs = await SharedPreferences.getInstance();
                            prefs.setBool("App_Lock", true);
                            pinStatus.value = true;
                            if (context.mounted) Navigator.pop(context);
                          });
                        }
                      },
                    ),
                    CustomTileSwitch(
                      startingState: clearClipboard.value,
                      width: context.screenWidth,
                      onChanged: (value) async {
                        var prefs = await SharedPreferences.getInstance();
                        prefs.setBool("Clear_Clipboard", true);
                      },
                      title: "CLIPBOARD CLEARING",
                      subtitle: "Clears clipboard after 30 seconds of copying credentials",
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                padding: EdgeInsets.symmetric(horizontal: 12),
                alignment: .centerLeft,
                width: context.screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border(
                    left: BorderSide(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      width: 5,
                    ),
                  ),
                ),
                child: Text(
                  "VAULT PREFERENCES",
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.copyWith(fontSize: 24 * context.scaled),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                decoration: ShapeDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadiusGeometry.only(bottomRight: Radius.circular(12)),
                  ),
                ),
                child: Column(
                  spacing: 10,
                  mainAxisAlignment: .start,
                  children: [
                    CustomTileSwitch(
                      startingState: useDarkTheme.value,
                      width: context.screenWidth,
                      onChanged: (value) {},
                      title: "Dark Mode",
                      subtitle: "Ironclad Obsidian Theme",
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                      width: context.screenWidth,
                      child: Column(
                        crossAxisAlignment: .start,
                        mainAxisAlignment: .spaceEvenly,
                        spacing: 10,
                        children: [
                          Text(
                            "System Language",
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20 * context.scaled,
                            ),
                          ),
                          Container(
                            width: context.screenWidth, // Adjust width as needed
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceContainer,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.white10, width: 1),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                onChanged: (value) {},
                                items: [
                                  "English US",
                                  "Espanol",
                                  "Arabic",
                                ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                                value: "English US",
                                isExpanded: true,
                                dropdownColor: Theme.of(context).colorScheme.surfaceContainerLow,
                                icon: Icon(Icons.keyboard_arrow_down_outlined), // 3. Custom Icon
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Roboto', // Use a clean sans-serif font
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                padding: EdgeInsets.symmetric(horizontal: 12),
                alignment: .centerLeft,
                width: context.screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border(
                    left: BorderSide(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      width: 5,
                    ),
                  ),
                ),
                child: Text(
                  "DATA OPERATIONS",
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.copyWith(fontSize: 24 * context.scaled),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                decoration: ShapeDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadiusGeometry.only(bottomRight: Radius.circular(12)),
                  ),
                ),
                child: Column(
                  spacing: 10,
                  mainAxisAlignment: .center,
                  children: [
                    CustomButton(
                      icon: Icons.upload_file,
                      iconColor: Theme.of(context).colorScheme.primaryContainer,
                      label: "Export Credentials",
                      labelColor: Colors.white,
                      onTap: () {},
                      height: context.screenHeight * 0.075,
                      width: context.screenWidth,
                      color: Theme.of(context).colorScheme.surfaceContainerLow,
                    ),
                    CustomButton(
                      icon: Icons.delete_forever_sharp,
                      iconColor: Theme.of(context).colorScheme.onErrorContainer,
                      label: "Wipe the Vault",
                      labelColor: Theme.of(context).colorScheme.onErrorContainer,
                      onTap: () => CustomDialog.showCustomWarningDialog(
                        context,
                        positiveLabel: "Cancel",
                        negativeLabel: "Wipe",
                        content:
                            "Proceeding with this action will DELETE all credentials, are you sure?",
                        onTapNegative: () {
                          ref.read(allCredentialsProvider.notifier).deleteAll();
                          Navigator.pop(context);
                        },
                        onTapPositive: () => Navigator.pop(context),
                        positiveIcon: Icons.cancel_sharp,
                        negativeIcon: Icons.delete_forever_sharp,
                      ),
                      height: context.screenHeight * 0.075,
                      width: context.screenWidth,
                      color: Theme.of(context).colorScheme.errorContainer,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

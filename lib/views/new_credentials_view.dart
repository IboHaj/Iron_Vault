import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iron_vault/l10n/app_localizations.dart';
import 'package:iron_vault/models/credentials.dart';
import 'package:iron_vault/notifiers/credentials_holder_notifier.dart';
import 'package:iron_vault/utils/utils.dart';
import 'package:iron_vault/widgets/custom_appbar.dart';
import 'package:iron_vault/widgets/custom_button.dart';
import 'package:iron_vault/widgets/custom_snackbar.dart';
import 'package:iron_vault/widgets/custom_textfield.dart';

class NewCredentialsView extends HookConsumerWidget {
  const NewCredentialsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var serviceTEC = useTextEditingController();
    var identityTEC = useTextEditingController();
    var passwordTEC = useTextEditingController();
    var noteTEC = useTextEditingController();

    var useAlphabet = useState(false);
    var useNumbers = useState(false);
    var useSymbols = useState(false);
    var sliderValue = useState(8.0);

    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: CustomAppbar(
            leadingIcon: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_sharp,
                size: 28 * context.scaled,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            title: AppLocalizations.of(context)!.new_entry,
          ),
          body:  ListView(
              children: [
                Container(
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.scrim),
                  padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Column(
                    mainAxisAlignment: .start,
                    spacing: context.screenWidth > 400 ? 8 : 6,
                    children: [
                      SizedBox(
                        height: context.screenHeight * 0.07,
                        width: context.screenWidth,
                        child: Column(
                          crossAxisAlignment: .start,
                          spacing: context.screenWidth > 600 ? 8 : 4,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.forge_new_entry,
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 28 * context.scaled,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.new_entry_string,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 16 * context.scaled,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: context.screenHeight * 0.007,
                        width: context.screenWidth,
                        child: Row(
                          crossAxisAlignment: .start,
                          spacing: context.screenWidth > 600 ? 8 : 4,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Divider(
                                color: Theme.of(context).colorScheme.primaryContainer,
                                thickness: 3,
                              ),
                            ),
                            Expanded(flex: 6, child: Divider()),
                            Expanded(
                              flex: 1,
                              child: Divider(
                                color: Theme.of(context).colorScheme.onPrimary,
                                thickness: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Container(
                          decoration: ShapeDecoration(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadiusGeometry.only(topRight: Radius.circular(18)),
                            ),
                            color: Theme.of(context).colorScheme.secondaryContainer,
                          ),
                          child: Column(
                            mainAxisAlignment: .start,
                            children: [
                              CustomTextfield(
                                label: AppLocalizations.of(context)!.title,
                                controller: serviceTEC,
                                leadingIcon: Icons.public,
                                hintText: "e.g Gmail, GitHub, Twitter",
                              ),
                              CustomTextfield(
                                label: AppLocalizations.of(context)!.username,
                                controller: identityTEC,
                                leadingIcon: Icons.badge,
                                hintText: "username@domain.com",
                              ),
                              CustomTextfield(
                                label: AppLocalizations.of(context)!.password,
                                controller: passwordTEC,
                                leadingIcon: Icons.key,
                                obscureText: true,
                                isPassword: true,
                              ),
                              CustomButton(
                                icon: Icons.refresh,
                                iconColor: Theme.of(context).colorScheme.primaryContainer,
                                label: AppLocalizations.of(context)!.generate,
                                labelColor: Theme.of(context).colorScheme.primaryContainer,
                                onTap: () {
                                  if (useSymbols.value || useNumbers.value || useAlphabet.value) {
                                    passwordTEC.text = Utils.generatePassword(
                                      sliderValue.value.toInt(),
                                      useSymbols.value,
                                      useAlphabet.value,
                                      useNumbers.value,
                                    );
                                  } else {
                                    CustomSnackbar.show(
                                      context,
                                      SnackBarUse.info,
                                      "No password generation settings are active",
                                    );
                                  }
                                },
                                height: context.screenHeight * 0.07,
                                width: context.screenWidth,
                                color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                                  border: Border(
                                    left: BorderSide(
                                      color: Theme.of(context).colorScheme.primaryContainer,
                                      width: 3,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  spacing: 10,
                                  mainAxisSize: .min,
                                  mainAxisAlignment: .start,
                                  crossAxisAlignment: .center,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.password_generation_settings,
                                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                        fontSize: 20 * context.scaled,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: .spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.password_length,
                                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                            fontSize: 16 * context.scaled,
                                          ),
                                        ),
                                        Text(
                                          sliderValue.value.toInt().toString(),
                                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                            fontSize: 16 * context.scaled,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Slider(
                                      thumbColor: Theme.of(context).colorScheme.primaryContainer,
                                      activeColor: Theme.of(context).colorScheme.primaryContainer,
                                      value: sliderValue.value,
                                      min: 8.0,
                                      max: 40.0,
                                      divisions: 32,
                                      onChanged: (value) {
                                        sliderValue.value = value;
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                      child: Row(
                                        mainAxisAlignment: .spaceBetween,
                                        children: [
                                          Text(
                                            "8",
                                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                              fontSize: 16 * context.scaled,
                                            ),
                                          ),
                                          Text(
                                            "40",
                                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                              fontSize: 16 * context.scaled,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: .spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Checkbox(
                                                  value: useAlphabet.value,
                                                  onChanged: (value) {
                                                    useAlphabet.value = value!;
                                                  },
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!.aabbcc,
                                                  style: Theme.of(context).textTheme.labelSmall
                                                      ?.copyWith(fontSize: 16 * context.scaled),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Checkbox(
                                                  value: useNumbers.value,
                                                  onChanged: (value) {
                                                    useNumbers.value = value!;
                                                  },
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!.numbers_string,
                                                  style: Theme.of(context).textTheme.labelSmall
                                                      ?.copyWith(fontSize: 16 * context.scaled),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Checkbox(
                                                  value: useSymbols.value,
                                                  onChanged: (value) {
                                                    useSymbols.value = value!;
                                                  },
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!.symbols_string,
                                                  style: Theme.of(context).textTheme.labelSmall
                                                      ?.copyWith(fontSize: 16 * context.scaled),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                indent: context.screenWidth * 0.05,
                                endIndent: context.screenWidth * 0.05,
                              ),
                              CustomTextfield(
                                label: AppLocalizations.of(context)!.extra_notes,
                                controller: noteTEC,
                                isRequired: false,
                                maxLines: 3,
                                hintText: AppLocalizations.of(context)!.notes_go_here,
                              ),
                              CustomButton(
                                label: AppLocalizations.of(context)!.secure_entry,
                                iconColor: Theme.of(context).colorScheme.shadow,
                                icon: Icons.lock,
                                labelColor: Theme.of(context).colorScheme.shadow,
                                onTap: () async {
                                  await ref
                                      .read(allCredentialsProvider.notifier)
                                      .addCredentials(
                                        Credentials(
                                          title: serviceTEC.text,
                                          username: identityTEC.text,
                                          password: passwordTEC.text,
                                          note: noteTEC.text,
                                          dateCreated: DateTime.now(),
                                          favorited: false,
                                        ),
                                      );
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                    CustomSnackbar.show(
                                      context,
                                      SnackBarUse.success,
                                      "New Entry Created!",
                                    );
                                  }
                                },
                                height: context.screenHeight * 0.07,
                                width: context.screenWidth,
                                color: Theme.of(context).colorScheme.primaryContainer,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}

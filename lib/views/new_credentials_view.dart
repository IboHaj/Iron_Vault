import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iron_vault/models/credentials.dart';
import 'package:iron_vault/notifiers/credentials_holder_notifier.dart';
import 'package:iron_vault/utils/theme.dart';
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
      child: MaterialApp(
        theme: MaterialTheme().dark(),
        home: Scaffold(
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
            appbarHeight: context.isMediumScreen || context.isTablet
                ? context.screenHeight * 0.065
                : context.screenHeight * 0.08,
            title: "IRON VAULT",
          ),
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.scrim),
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Column(
                mainAxisAlignment: .start,
                spacing: context.screenWidth > 400 ? 8 : 6,
                children: [
                  SizedBox(
                    height: context.screenHeight * 0.08,
                    width: context.screenWidth,
                    child: Column(
                      crossAxisAlignment: .start,
                      spacing: context.screenWidth > 600 ? 8 : 4,
                      children: [
                        Text(
                          "FORGE A NEW ENTRY",
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 28 * context.scaled,
                          ),
                        ),
                        Text(
                          "Initialize a new set of Credentials.",
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
                    height: context.screenWidth > 400
                        ? context.screenHeight * 1.18
                        : context.screenHeight * 1.46,
                    width: context.screenWidth,
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
                            label: "TITLE",
                            controller: serviceTEC,
                            leadingIcon: Icons.public,
                            hintText: "e.g Gmail, GitHub, Twitter",
                          ),
                          CustomTextfield(
                            label: "USERNAME",
                            controller: identityTEC,
                            leadingIcon: Icons.badge,
                            hintText: "username@domain.com",
                          ),
                          CustomTextfield(
                            label: "PASSWORD",
                            controller: passwordTEC,
                            leadingIcon: Icons.key,
                            obscureText: true,
                          ),
                          CustomButton(
                            icon: Icons.refresh,
                            iconColor: Theme.of(context).colorScheme.primaryContainer,
                            label: "GENERATE",
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
                            height: context.screenHeight * 0.085,
                            width: context.screenWidth,
                            color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                            height: context.screenWidth > 400
                                ? context.screenHeight * 0.34
                                : context.screenHeight * 0.41,
                            width: context.screenWidth,
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
                                  "PASSWORD GENERATION SETTINGS",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelMedium?.copyWith(fontSize: 20 * context.scaled),
                                ),
                                Row(
                                  mainAxisAlignment: .spaceBetween,
                                  children: [
                                    Text(
                                      "PASSWORD LENGTH",
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
                                              "AaBbCc",
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
                                              "0123",
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
                                              "!@#%",
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
                            label: "EXTRA NOTES",
                            controller: noteTEC,
                            isRequired: false,
                            maxLines: 5,
                            hintText: "Notes go here...",
                          ),
                          CustomButton(
                            label: "SECURE ENTRY",
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
                            height: context.screenHeight * 0.085,
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
          ),
        ),
      ),
    );
  }
}

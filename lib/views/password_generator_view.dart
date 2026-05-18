import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iron_vault/utils/utils.dart';
import 'package:iron_vault/widgets/custom_snackbar.dart';
import 'package:iron_vault/widgets/custom_tile_switch.dart';

class PasswordGeneratorView extends HookConsumerWidget {
  const PasswordGeneratorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var useAlphabet = useState(false);
    var useNumbers = useState(false);
    var useSymbols = useState(false);
    var sliderValue = useState(8.0);
    var passwordValue = useState("");
    var passwordStrength = useState(0);

    return Container(
      padding: const EdgeInsets.all(16),
      height: context.screenHeight,
      width: context.screenWidth,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisSize: .max,
            spacing: constraints.maxWidth > 600
                ? 16
                : constraints.maxWidth < 450
                ? 8
                : 12,
            children: [
              Container(
                height: constraints.maxHeight * 0.35,
                width: constraints.maxWidth,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                  border: Border(
                    left: BorderSide(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      width: 7,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: .center,
                  mainAxisAlignment: .spaceAround,
                  children: [
                    Text(
                      "Generated Password",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 24 * context.scaled,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        textAlign: TextAlign.center,
                        passwordValue.value.isEmpty
                            ? 'Click Generate To Create A New Password'
                            : passwordValue.value,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.surface,
                          fontSize: 24 * context.scaled,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 3,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: passwordValue.value));
                            CustomSnackbar.show(context, SnackBarUse.info, "Password copied!");
                          },
                          label: Text(
                            "COPY",
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: 24 * context.scaled,
                              color: Theme.of(context).colorScheme.primaryContainer,
                            ),
                          ),
                          icon: Icon(
                            Icons.copy,
                            size: 24 * context.scaled,
                            color: Theme.of(context).colorScheme.primaryContainer,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            if (useSymbols.value || useNumbers.value || useAlphabet.value) {
                              passwordValue.value = Utils.generatePassword(
                                sliderValue.value.toInt(),
                                useSymbols.value,
                                useAlphabet.value,
                                useNumbers.value,
                              );

                              passwordStrength.value = Utils.determinePasswordStrength(
                                passwordValue.value,
                              );
                            } else {
                              CustomSnackbar.show(
                                context,
                                SnackBarUse.error,
                                "No password generation settings are active",
                              );
                            }
                          },
                          label: Text(
                            "GENERATE",
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: 24 * context.scaled,
                              color: Theme.of(context).colorScheme.primaryContainer,
                            ),
                          ),
                          icon: Icon(
                            Icons.refresh,
                            size: 24 * context.scaled,
                            color: Theme.of(context).colorScheme.primaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.63,
                width: constraints.maxWidth,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return ListView(
                      children: [
                        SizedBox(
                          height: context.isTablet
                              ? context.screenHeight * 0.2
                              : context.isMediumScreen
                              ? context.screenHeight * 0.1
                              : context.screenHeight * 0.095,

                          child: Container(
                            padding: const EdgeInsetsGeometry.all(10),
                            margin: const EdgeInsetsGeometry.only(top: 10),
                            child: Column(
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: .spaceBetween,
                                  children: [
                                    Text(
                                      "PASSWORD COMPLEXITY",
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontSize: 20 * context.scaled,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      passwordStrength.value == 0
                                          ? "POOR"
                                          : passwordStrength.value == 1
                                          ? "OK"
                                          : passwordStrength.value == 2
                                          ? "FINE"
                                          : passwordStrength.value == 3
                                          ? "GREAT"
                                          : "EXCELLENT",
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: Theme.of(context).colorScheme.primaryContainer,
                                        fontSize: 20 * context.scaled,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  spacing: context.isTablet
                                      ? 20
                                      : context.isMediumScreen
                                      ? 10
                                      : 6,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: Theme.of(context).colorScheme.primaryContainer,
                                        child: Container(
                                          height: context.isTablet
                                              ? context.screenHeight * 0.05
                                              : context.isMediumScreen
                                              ? context.screenHeight * 0.015
                                              : context.screenHeight * 0.01,
                                          width: constraints.maxWidth * 0.2,
                                          color: passwordStrength.value > 0
                                              ? Theme.of(context).colorScheme.primaryContainer
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Theme.of(context).colorScheme.primaryContainer,
                                        child: Container(
                                          height: context.isTablet
                                              ? context.screenHeight * 0.05
                                              : context.isMediumScreen
                                              ? context.screenHeight * 0.015
                                              : context.screenHeight * 0.01,
                                          width: constraints.maxWidth * 0.2,
                                          color: passwordStrength.value > 1
                                              ? Theme.of(context).colorScheme.primaryContainer
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Theme.of(context).colorScheme.primaryContainer,
                                        child: Container(
                                          height: context.isTablet
                                              ? context.screenHeight * 0.05
                                              : context.isMediumScreen
                                              ? context.screenHeight * 0.015
                                              : context.screenHeight * 0.01,
                                          width: constraints.maxWidth * 0.2,
                                          color: passwordStrength.value > 2
                                              ? Theme.of(context).colorScheme.primaryContainer
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: context.isTablet
                                            ? context.screenHeight * 0.05
                                            : context.isMediumScreen
                                            ? context.screenHeight * 0.015
                                            : context.screenHeight * 0.01,
                                        width: constraints.maxWidth * 0.2,
                                        color: passwordStrength.value > 3
                                            ? Theme.of(context).colorScheme.primaryContainer
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsetsGeometry.all(15),
                          margin: const EdgeInsetsGeometry.symmetric(vertical: 10),
                          decoration: ShapeDecoration(
                            color: Theme.of(context).colorScheme.secondaryContainer,
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(12)),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Text(
                                    "PASSWORD LENGTH",
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontSize: 20 * context.scaled,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsetsGeometry.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(color: Colors.black),
                                    child: Text(
                                      sliderValue.value.toInt().toString(),
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: Theme.of(context).colorScheme.primaryContainer,
                                        fontSize: 20 * context.scaled,
                                      ),
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
                            ],
                          ),
                        ),
                        CustomTileSwitch(
                          width: constraints.maxWidth,
                          onChanged: (value) {
                            useAlphabet.value = value;
                          },
                          title: "ALPHABET",
                          subtitle: "AaBbCc",
                        ),
                        CustomTileSwitch(
                          width: constraints.maxWidth,
                          onChanged: (value) {
                            useNumbers.value = value;
                          },
                          title: "NUMBERS",
                          subtitle: "01234",
                        ),
                        CustomTileSwitch(
                          width: constraints.maxWidth,
                          onChanged: (value) {
                            useSymbols.value = value;
                          },
                          title: "SYMBOLS",
                          subtitle: "!@#\$%",
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

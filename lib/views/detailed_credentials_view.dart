import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iron_vault/models/credentials.dart';
import 'package:iron_vault/notifiers/credentials_holder_notifier.dart';
import 'package:iron_vault/utils/utils.dart';
import 'package:iron_vault/widgets/custom_appbar.dart';
import 'package:iron_vault/widgets/custom_snackbar.dart';
import 'package:iron_vault/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

class DetailedCredentialsView extends StatefulHookConsumerWidget {
  const DetailedCredentialsView({super.key, this.credentials});

  final Credentials? credentials;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailedCredentialsViewState();
}

class _DetailedCredentialsViewState extends ConsumerState<DetailedCredentialsView>
    with TickerProviderStateMixin {
  final key = GlobalKey<FormState>();
  late final TextEditingController titleTEC;
  late final TextEditingController usernameTEC;
  late final TextEditingController passwordTEC;
  late final TextEditingController noteTEC;
  late Credentials? copiedCredentials;

  late AnimationController circleController;
  late Animation<double> circleAnimation;
  late AnimationController keyController;
  late Animation<double> keyAnimation;

  @override
  void initState() {
    super.initState();
    copiedCredentials = widget.credentials;
    titleTEC = TextEditingController(text: copiedCredentials?.title);
    usernameTEC = TextEditingController(text: copiedCredentials?.username);
    passwordTEC = TextEditingController(text: copiedCredentials?.password);
    noteTEC = TextEditingController(text: copiedCredentials?.note);

    circleController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    keyController = AnimationController(vsync: this, duration: const Duration(seconds: 2));

    circleAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(circleController);
    keyAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(keyController);

    circleController.repeat();
    keyController.repeat();
  }

  @override
  void dispose() {
    circleController.dispose();
    keyController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DetailedCredentialsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.credentials != widget.credentials) {
      copiedCredentials = widget.credentials;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = useState(false);
    final useAlphabet = useState(false);
    final useNumbers = useState(false);
    final useSymbols = useState(false);
    final passwordStrength = useState(
      Utils.determinePasswordStrength(copiedCredentials!.password!),
    );
    final sliderValue = useState(8.0);

    return Scaffold(
      appBar: CustomAppbar(
        trailing: [
          isEdit.value
              ? IconButton(
                  onPressed: () {
                    if (copiedCredentials!.title! == titleTEC.text &&
                        copiedCredentials!.username! == usernameTEC.text &&
                        copiedCredentials!.password! == passwordTEC.text &&
                        copiedCredentials!.note! == noteTEC.text) {
                      isEdit.value = !isEdit.value;
                      CustomSnackbar.show(
                        context,
                        SnackBarUse.info,
                        "No changes have been made...",
                      );
                    } else {
                      if (copiedCredentials!.title! != titleTEC.text) {
                        ref
                            .read(allCredentialsProvider.notifier)
                            .deleteCredentials(copiedCredentials!);
                      }
                      copiedCredentials = Credentials(
                        title: titleTEC.text,
                        username: usernameTEC.text,
                        password: passwordTEC.text,
                        note: noteTEC.text,
                        dateCreated: copiedCredentials!.dateCreated!,
                      );
                      ref.read(allCredentialsProvider.notifier).addCredentials(copiedCredentials!);
                      isEdit.value = !isEdit.value;
                      CustomSnackbar.show(context, SnackBarUse.success, "Entry updated!");
                    }
                  },
                  icon: Icon(
                    Icons.save_sharp,
                    color: Theme.of(context).colorScheme.primary,
                    size: 28 * context.scaled,
                  ),
                )
              : IconButton(
                  onPressed: () => isEdit.value = !isEdit.value,
                  icon: Icon(
                    Icons.edit_sharp,
                    color: Theme.of(context).colorScheme.primary,
                    size: 28 * context.scaled,
                  ),
                ),
        ],
        appbarHeight: context.isMediumScreen || context.isTablet
            ? context.screenHeight * 0.065
            : context.screenHeight * 0.08,
        title: "ENTRY DETAILS",
        titleStyle: Theme.of(
          context,
        ).textTheme.headlineMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
        showLockIcon: false,
        centerTitle: true,
        bgColor: Theme.of(context).colorScheme.shadow,
        leadingIcon: isEdit.value
            ? IconButton(
                onPressed: () {
                  isEdit.value = !isEdit.value;
                  titleTEC.text = copiedCredentials!.title!;
                  usernameTEC.text = copiedCredentials!.username!;
                  passwordTEC.text = copiedCredentials!.password!;
                  noteTEC.text = copiedCredentials!.note!;
                },
                icon: Icon(
                  Icons.cancel_outlined,
                  size: 28 * context.scaled,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_sharp,
                  size: 28 * context.scaled,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
      ),
      backgroundColor: Theme.of(context).colorScheme.scrim,
      body: SingleChildScrollView(
        child: Column(
          spacing: context.isSmallScreen ? 8 : 12,
          children: [
            SizedBox(
              height: context.screenHeight * 0.15,
              width: context.screenWidth,
              child: Row(
                mainAxisAlignment: .end,
                children: [
                  Container(
                    margin: EdgeInsets.all(12),
                    height: context.screenHeight * 0.115,
                    width: context.screenWidth * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.zero,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    child: Center(
                      child: Container(
                        height: context.screenHeight * 0.0765,
                        width: context.screenWidth * 0.165,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.scrim,
                          borderRadius: BorderRadius.zero,
                        ),
                        child: Center(
                          child: Stack(
                            children: [
                              Center(
                                child: AnimatedBuilder(
                                  builder: (context, child) {
                                    return Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.identity()
                                        ..rotateY(keyAnimation.value)
                                        ..rotateZ(0.5),
                                      child: Icon(
                                        Icons.key_sharp,
                                        color: Colors.white,
                                        size: 24 * context.scaled,
                                      ),
                                    );
                                  },
                                  animation: keyController,
                                ),
                              ),
                              Center(
                                child: AnimatedBuilder(
                                  animation: circleController,
                                  builder: (context, child) => Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.identity()..rotateX(circleAnimation.value),
                                    child: Container(
                                      width: context.screenWidth * 0.155,
                                      height: context.screenHeight * 0.06,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white, width: 1.5),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.1),
                                            spreadRadius: 5,
                                            blurRadius: 3,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (!isEdit.value)
              SizedBox(
                height: context.screenHeight * 0.1,
                width: context.screenWidth,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: .end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12 * context.scaled),
                          child: Text(
                            "CURRENT ENTRY",
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                              fontSize: 20 * context.scaled,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: .center,
                      mainAxisAlignment: .end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32 * context.scaled),
                          child: GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: copiedCredentials!.title!));
                              CustomSnackbar.show(
                                context,
                                SnackBarUse.info,
                                "${copiedCredentials!.title!} copied!",
                              );
                            },
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              copiedCredentials!.title!.toUpperCase(),
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 36 * context.scaled,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              height: isEdit.value ? context.screenHeight * 0.625 : context.screenHeight * 0.5,
              width: context.screenWidth,
              decoration: ShapeDecoration(
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadiusGeometry.only(bottomRight: Radius.circular(18)),
                ),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Column(
                children: [
                  Visibility(
                    visible: isEdit.value,
                    child: CustomTextfield(label: "TITLE", controller: titleTEC),
                  ),
                  CustomTextfield(
                    label: "USERNAME",
                    controller: usernameTEC,
                    readOnly: !isEdit.value,
                  ),
                  CustomTextfield(
                    label: "PASSWORD",
                    controller: passwordTEC,
                    obscureText: true,
                    readOnly: !isEdit.value,
                    isPassword: true,
                    iconOnClick: () {
                      if (useSymbols.value || useAlphabet.value || useNumbers.value) {
                        passwordTEC.text = Utils.generatePassword(
                          sliderValue.value.toInt(),
                          useSymbols.value,
                          useAlphabet.value,
                          useNumbers.value,
                        );
                      } else {
                        CustomSnackbar.show(
                          context,
                          SnackBarUse.error,
                          "No password generation settings are enabled",
                        );
                      }
                    },
                  ),
                  CustomTextfield(
                    label: "EXTRA NOTES",
                    controller: noteTEC,
                    maxLines: 5,
                    readOnly: !isEdit.value,
                    isRequired: false,
                  ),
                ],
              ),
            ),
            if (!isEdit.value)
              Container(
                height: context.screenHeight * 0.35,
                width: context.screenWidth,
                margin: EdgeInsets.symmetric(horizontal: 10 * context.scaled),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.zero,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                  child: Column(
                    mainAxisAlignment: .spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Text(
                            "SECURITY HEALTH",
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontSize: 24 * context.scaled,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.shield_outlined,
                            size: 36 * context.scaled,
                            color: Theme.of(context).colorScheme.primaryContainer,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            passwordStrength.value <= 1
                                ? "POOR"
                                : passwordStrength.value == 2
                                ? "OK"
                                : passwordStrength.value == 3
                                ? "GREAT"
                                : "EXCELLENT",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontSize: 24 * context.scaled,
                              color: Theme.of(context).colorScheme.primaryContainer,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                  offset: Offset(0, 0),
                                ),
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                  offset: Offset(0, 0),
                                ),
                              ],
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
                                width: context.screenWidth * 0.2,
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
                                width: context.screenWidth * 0.2,
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
                                width: context.screenWidth * 0.2,
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
                              width: context.screenWidth * 0.2,
                              color: passwordStrength.value > 3
                                  ? Theme.of(context).colorScheme.primaryContainer
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                "DATE CREATED",
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontSize: 16 * context.scaled,
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                              ),
                              Text(
                                DateFormat.yMd().format(copiedCredentials!.dateCreated!).toString(),
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontSize: 12 * context.scaled,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            if (isEdit.value)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
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
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(fontSize: 16 * context.scaled),
                        ),
                        Text(
                          sliderValue.value.toInt().toString(),
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(fontSize: 16 * context.scaled),
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
                            style: Theme.of(
                              context,
                            ).textTheme.labelSmall?.copyWith(fontSize: 16 * context.scaled),
                          ),
                          Text(
                            "40",
                            style: Theme.of(
                              context,
                            ).textTheme.labelSmall?.copyWith(fontSize: 16 * context.scaled),
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
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelSmall?.copyWith(fontSize: 16 * context.scaled),
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
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelSmall?.copyWith(fontSize: 16 * context.scaled),
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
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelSmall?.copyWith(fontSize: 16 * context.scaled),
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
          ],
        ),
      ),
    );
  }
}

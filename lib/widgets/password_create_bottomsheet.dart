import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iron_vault/models/credentials.dart';
import 'package:iron_vault/notifiers/credentials_holder_notifier.dart';
import 'package:iron_vault/utils/utils.dart';
import 'package:iron_vault/widgets/custom_snackbar.dart';
import 'package:iron_vault/widgets/custom_textfield.dart';

class PasswordCreateBottomSheet extends ConsumerStatefulWidget {
  const PasswordCreateBottomSheet({
    super.key,
    required this.titleTEC,
    required this.usernameTEC,
    required this.passwordTEC,
    required this.noteTEC,
  });

  final TextEditingController titleTEC;
  final TextEditingController usernameTEC;
  final TextEditingController passwordTEC;
  final TextEditingController noteTEC;

  @override
  ConsumerState<PasswordCreateBottomSheet> createState() => _PasswordCreateBottomSheetState();
}

class _PasswordCreateBottomSheetState extends ConsumerState<PasswordCreateBottomSheet> {
  final key = GlobalKey<FormState>();
  OverlayEntry? entry;

  @override
  Widget build(BuildContext context) {
    return HookBuilder(
      builder: (ctx) {
        final isFavorite = useState(false);
        final useAlphabet = useState(false);
        final useNumbers = useState(false);
        final useSymbols = useState(false);
        final passwordLength = useState(8.0);

        return LayoutBuilder(
          builder: (context, constraints) => Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom,
              left: constraints.maxWidth > 600 ? 12 : 8,
              right: constraints.maxWidth > 600 ? 12 : 8,
              top: constraints.maxWidth > 600 ? 12 : 8,
            ),
            height: MediaQuery.of(ctx).size.height * 0.85,
            width: MediaQuery.of(ctx).size.width,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(ctx).size.height * 0.85,
                  width: MediaQuery.of(ctx).size.width,
                  child: Column(
                    mainAxisAlignment: .center,
                    mainAxisSize: .max,
                    crossAxisAlignment: .center,
                    spacing: constraints.maxWidth > 600 ? 18 : 12,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text("New Credentials", style: Theme.of(ctx).textTheme.labelLarge),
                      ),
                      Expanded(
                        flex: 17,
                        child: Form(
                          key: key,
                          child: Column(
                            spacing: 4,
                            mainAxisAlignment: .start,
                            mainAxisSize: .min,
                            crossAxisAlignment: .center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: CustomTextfield(
                                        label: "Title",
                                        controller: widget.titleTEC,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => isFavorite.value = !isFavorite.value,
                                      icon: Icon(
                                        isFavorite.value
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        size: constraints.maxWidth > 600 ? 48 : 32,
                                        color: isFavorite.value ? Colors.red : Colors.white,
                                      ),
                                      tooltip: "Favorite",
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: CustomTextfield(
                                  label: "Username",
                                  controller: widget.usernameTEC,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: CustomTextfield(
                                  label: "Password",
                                  controller: widget.passwordTEC,
                                  isPassword: true,
                                  iconOnClick: () {
                                    if (useSymbols.value || useNumbers.value || useAlphabet.value) {
                                      widget.passwordTEC.text = Utils.generatePassword(
                                        passwordLength.value.toInt(),
                                        useSymbols.value,
                                        useAlphabet.value,
                                        useNumbers.value,
                                      );
                                    } else {
                                      CustomSnackbar.show(
                                        ctx,
                                        SnackBarUse.info,
                                        "Please select one of the three password generation settings",
                                      );
                                    }
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: CustomTextfield(
                                  label: "Note",
                                  controller: widget.noteTEC,
                                  isRequired: false,
                                  maxLines: 5,
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.primaryContainer,
                                      width: 3,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: .min,
                                    mainAxisAlignment: .center,
                                    crossAxisAlignment: .center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Password Generation Settings",
                                          style: Theme.of(context).textTheme.labelLarge,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Current Password Length ${passwordLength.value.toInt()}",
                                          style: Theme.of(context).textTheme.labelMedium,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisSize: .min,
                                          children: [
                                            Expanded(
                                              child: Slider(
                                                value: passwordLength.value,
                                                onChanged: (value) => passwordLength.value = value,
                                                divisions: 32,
                                                max: 40,
                                                min: 8,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: .symmetric(
                                                  horizontal: constraints.maxWidth > 600 ? 36 : 20,
                                                ),
                                                child: Row(
                                                  mainAxisSize: .max,
                                                  crossAxisAlignment: .center,
                                                  mainAxisAlignment: .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "8",
                                                      style: Theme.of(
                                                        context,
                                                      ).textTheme.titleMedium,
                                                    ),
                                                    Text(
                                                      "40",
                                                      style: Theme.of(
                                                        context,
                                                      ).textTheme.titleMedium,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: constraints.maxWidth > 600 ? 18 : 10,
                                          ),
                                          child: Row(
                                            spacing: constraints.maxWidth > 600 ? 18 : 10,
                                            mainAxisAlignment: .spaceAround,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: useAlphabet.value
                                                      ? Theme.of(context).colorScheme.inversePrimary
                                                      : Theme.of(
                                                          context,
                                                        ).colorScheme.secondaryContainer,
                                                  borderRadius: .circular(14),
                                                ),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    splashFactory: NoSplash.splashFactory,
                                                  ),
                                                  onPressed: () =>
                                                      useAlphabet.value = !useAlphabet.value,
                                                  child: Text(
                                                    "AaBb",
                                                    style: Theme.of(context).textTheme.labelMedium
                                                        ?.copyWith(
                                                          fontSize: constraints.maxWidth > 600
                                                              ? 40
                                                              : 24,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: useNumbers.value
                                                      ? Theme.of(context).colorScheme.inversePrimary
                                                      : Theme.of(
                                                          context,
                                                        ).colorScheme.secondaryContainer,
                                                  borderRadius: .circular(14),
                                                ),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    splashFactory: NoSplash.splashFactory,
                                                  ),
                                                  onPressed: () =>
                                                      useNumbers.value = !useNumbers.value,
                                                  child: Text(
                                                    "1234",
                                                    style: Theme.of(context).textTheme.labelMedium
                                                        ?.copyWith(
                                                          fontSize: constraints.maxWidth > 600
                                                              ? 40
                                                              : 24,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: useSymbols.value
                                                      ? Theme.of(context).colorScheme.inversePrimary
                                                      : Theme.of(
                                                          context,
                                                        ).colorScheme.secondaryContainer,
                                                  borderRadius: .circular(14),
                                                ),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    splashFactory: NoSplash.splashFactory,
                                                  ),
                                                  onPressed: () =>
                                                      useSymbols.value = !useSymbols.value,
                                                  child: Text(
                                                    "#!@%",
                                                    style: Theme.of(context).textTheme.labelMedium
                                                        ?.copyWith(
                                                          fontSize: constraints.maxWidth > 600
                                                              ? 40
                                                              : 24,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: constraints.maxWidth > 600 ? 18 : 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Theme.of(ctx).colorScheme.onPrimary,
                          ),
                          child: TextButton.icon(
                            style: ButtonStyle(
                              splashFactory: NoSplash.splashFactory,
                              backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            onPressed: () async {
                              if (key.currentState!.validate()) {
                                if (ref.read(allCredentialsProvider).value != null &&
                                    widget.titleTEC.text.isNotEmpty &&
                                    ref
                                        .read(allCredentialsProvider)
                                        .value!
                                        .where((e) => e.keys.any((e) => e == widget.titleTEC.text))
                                        .isNotEmpty) {
                                  CustomSnackbar.show(
                                    ctx,
                                    SnackBarUse.error,
                                    "Credentials with this title already exist, please choose a unique title.",
                                  );
                                } else {
                                  await ref
                                      .read(allCredentialsProvider.notifier)
                                      .addCredentials(
                                        Credentials(
                                          title: widget.titleTEC.text,
                                          username: widget.usernameTEC.text,
                                          password: widget.passwordTEC.text,
                                          note: widget.noteTEC.text,
                                          favorited: isFavorite.value,
                                          dateCreated: DateTime.now(),
                                        ),
                                      );
                                  if (ctx.mounted) {
                                    Navigator.pop(ctx);
                                  }
                                }
                              } else {
                                CustomSnackbar.show(
                                  ctx,
                                  SnackBarUse.error,
                                  "Please fill in all required fields.",
                                );
                              }
                            },
                            label: Text(
                              "Save to the Vault",
                              style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                                fontSize: constraints.maxWidth > 600 ? 40 : 28,
                              ),
                            ),
                            icon: Icon(
                              Icons.save,
                              color: Colors.white,
                              size: constraints.maxWidth > 600 ? 40 : 28,
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
        );
      },
    );
  }
}

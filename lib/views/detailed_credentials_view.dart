import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iron_vault/models/credentials.dart';
import 'package:iron_vault/notifiers/credentials_holder_notifier.dart';
import 'package:iron_vault/widgets/custom_snackbar.dart';
import 'package:iron_vault/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

class DetailedCredentialsView extends StatefulHookConsumerWidget {
  const DetailedCredentialsView({super.key, this.credentials});

  final Credentials? credentials;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailedCredentialsViewState();
}

class _DetailedCredentialsViewState extends ConsumerState<DetailedCredentialsView> {
  final key = GlobalKey<FormState>();
  late final TextEditingController titleTEC;
  late final TextEditingController usernameTEC;
  late final TextEditingController passwordTEC;
  late final TextEditingController noteTEC;
  late Credentials? copiedCredentials;

  @override
  void initState() {
    super.initState();
    copiedCredentials = widget.credentials!;
    titleTEC = TextEditingController(text: copiedCredentials?.title);
    usernameTEC = TextEditingController(text: copiedCredentials?.username);
    passwordTEC = TextEditingController(text: copiedCredentials?.password);
    noteTEC = TextEditingController(text: copiedCredentials?.note);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = useState(false);
    final isFavorite = useState(copiedCredentials?.favorited ?? false);
    final passwordLength = useState(8.0);
    final useAlphabet = useState(false);
    final useNumbers = useState(false);
    final useSymbols = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit.value ? "Update Credentials" : " Details",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              if (isEdit.value) {
                titleTEC.text = copiedCredentials!.title!;
                usernameTEC.text = copiedCredentials!.username!;
                passwordTEC.text = copiedCredentials!.password!;
                noteTEC.text = copiedCredentials!.note!;
                isFavorite.value = copiedCredentials!.favorited!;
              }
              isEdit.value = !isEdit.value;
            },
            icon: Icon(
              isEdit.value ? Icons.cancel_outlined : Icons.edit,
              color: Colors.white,
              size: MediaQuery.sizeOf(context).width > 600 ? 32 : 24,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.only(
            top: constraints.maxWidth > 600 ? 16 : 8,
            left: constraints.maxWidth > 600 ? 16 : 8,
            right: constraints.maxWidth > 600 ? 16 : 8,
            bottom: isEdit.value
                ? constraints.maxHeight / 13
                : constraints.maxWidth > 600
                ? 16
                : 8,
          ),
          child: copiedCredentials == null
              ? Center(
                  child: Text(
                    "No Credentials currently selected.",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                )
              : SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: .min,
                      mainAxisAlignment: .spaceEvenly,
                      crossAxisAlignment: .center,
                      spacing: constraints.maxWidth > 600 ? 30 : 16,
                      children: [
                        SizedBox(
                          child: Column(
                            mainAxisSize: .min,
                            mainAxisAlignment: .spaceEvenly,
                            crossAxisAlignment: .center,
                            spacing: constraints.maxWidth > 600 ? 24 : 6,
                            children: [
                              Container(
                                padding: .symmetric(
                                  horizontal: constraints.maxWidth > 600 ? 56 : 40,
                                  vertical: constraints.maxWidth > 600 ? 44 : 30,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.inversePrimary,
                                  borderRadius: .circular(16),
                                ),
                                child: Text(
                                  "${copiedCredentials!.title![0].toUpperCase()}${copiedCredentials!.title?[1].toLowerCase() ?? ""}",
                                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontSize: constraints.maxWidth > 600 ? 80 : 60,
                                    fontWeight: .bold,
                                  ),
                                ),
                              ),
                              Text(
                                "Created on ${DateFormat.yMMMd().format(copiedCredentials!.dateCreated!)}",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Form(
                            key: key,
                            child: Column(
                              spacing: constraints.maxWidth > 600 ? 18 : 10,
                              mainAxisAlignment: .center,
                              crossAxisAlignment: .center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: CustomTextfield(
                                        label: "Title",
                                        controller: titleTEC,
                                        readOnly: !isEdit.value,
                                      ),
                                    ),
                                    Expanded(
                                      child: AbsorbPointer(
                                        absorbing: !isEdit.value,
                                        child: IconButton(
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
                                      ),
                                    ),
                                  ],
                                ),
                                CustomTextfield(
                                  label: "Username",
                                  controller: usernameTEC,
                                  readOnly: !isEdit.value,
                                ),
                                CustomTextfield(
                                  label: "Password",
                                  controller: passwordTEC,
                                  readOnly: !isEdit.value,
                                ),
                                CustomTextfield(
                                  label: "Note",
                                  controller: noteTEC,
                                  readOnly: !isEdit.value,
                                  maxLines: 5,
                                  isRequired: false,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isEdit.value,
                          child: Container(
                            height: constraints.maxHeight * 0.3,
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
                                                style: Theme.of(context).textTheme.titleMedium,
                                              ),
                                              Text(
                                                "40",
                                                style: Theme.of(context).textTheme.titleMedium,
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
                                                : Theme.of(context).colorScheme.secondaryContainer,
                                            borderRadius: .circular(14),
                                          ),
                                          child: TextButton(
                                            style: ButtonStyle(
                                              splashFactory: NoSplash.splashFactory,
                                            ),
                                            onPressed: () => useAlphabet.value = !useAlphabet.value,
                                            child: Text(
                                              "AaBb",
                                              style: Theme.of(context).textTheme.labelMedium
                                                  ?.copyWith(
                                                    fontSize: constraints.maxWidth > 600 ? 40 : 24,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: useNumbers.value
                                                ? Theme.of(context).colorScheme.inversePrimary
                                                : Theme.of(context).colorScheme.secondaryContainer,
                                            borderRadius: .circular(14),
                                          ),
                                          child: TextButton(
                                            style: ButtonStyle(
                                              splashFactory: NoSplash.splashFactory,
                                            ),
                                            onPressed: () => useNumbers.value = !useNumbers.value,
                                            child: Text(
                                              "1234",
                                              style: Theme.of(context).textTheme.labelMedium
                                                  ?.copyWith(
                                                    fontSize: constraints.maxWidth > 600 ? 40 : 24,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: useSymbols.value
                                                ? Theme.of(context).colorScheme.inversePrimary
                                                : Theme.of(context).colorScheme.secondaryContainer,
                                            borderRadius: .circular(14),
                                          ),
                                          child: TextButton(
                                            style: ButtonStyle(
                                              splashFactory: NoSplash.splashFactory,
                                            ),
                                            onPressed: () => useSymbols.value = !useSymbols.value,
                                            child: Text(
                                              "#!@%",
                                              style: Theme.of(context).textTheme.labelMedium
                                                  ?.copyWith(
                                                    fontSize: constraints.maxWidth > 600 ? 40 : 24,
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
        ),
      ),
      bottomSheet: Visibility(
        visible: isEdit.value,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
          ),
          height: MediaQuery.sizeOf(context).height / 14,
          width: MediaQuery.sizeOf(context).width,
          child: TextButton.icon(
            onPressed: () async {
              if (key.currentState!.validate()) {
                if (copiedCredentials!.title != titleTEC.text) {
                  await ref
                      .read(allCredentialsProvider.notifier)
                      .deleteCredentials(copiedCredentials!);
                }
                copiedCredentials = Credentials(
                  title: titleTEC.text,
                  username: usernameTEC.text,
                  password: passwordTEC.text,
                  note: noteTEC.text,
                  favorited: isFavorite.value,
                  dateCreated: copiedCredentials!.dateCreated,
                );
                await ref.read(allCredentialsProvider.notifier).addCredentials(copiedCredentials!);
              } else {
                CustomSnackbar.show(
                  context,
                  SnackBarUse.error,
                  "Please fill in all relevant fields",
                );
              }
            },
            label: Text("Save to the Vault", style: Theme.of(context).textTheme.titleLarge),
            icon: Icon(
              Icons.save,
              color: Colors.white,
              size: MediaQuery.sizeOf(context).width > 600 ? 48 : 32,
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

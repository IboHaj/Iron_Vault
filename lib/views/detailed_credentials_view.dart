import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iron_vault/models/credentials.dart';
import 'package:iron_vault/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

class DetailedCredentialsView extends HookConsumerWidget {
  const DetailedCredentialsView({super.key, this.credentials});

  final Credentials? credentials;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController titleTEC = TextEditingController(text: credentials?.title);
    final TextEditingController usernameTEC = TextEditingController(text: credentials?.username);
    final TextEditingController passwordTEC = TextEditingController(text: credentials?.password);
    final TextEditingController noteTEC = TextEditingController(text: credentials?.note);

    final isFavorite = useState(credentials?.favorited ?? false);
    final isEdit = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit.value ? "Update Credentials" : " Details",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () => isEdit.value = !isEdit.value,
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
          padding: EdgeInsets.all(constraints.maxWidth > 600 ? 16 : 8),
          child: credentials == null
              ? Center(
                  child: Text(
                    "No Credentials currently selected.",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: .min,
                    mainAxisAlignment: .spaceEvenly,
                    crossAxisAlignment: .center,
                    children: [
                      Column(
                        mainAxisSize: .min,
                        mainAxisAlignment: .spaceEvenly,
                        crossAxisAlignment: .center,
                        spacing: constraints.maxWidth > 600 ? 48 : 30,
                        children: [
                          Container(
                            padding: .symmetric(
                              horizontal: constraints.maxWidth > 600 ? 56 : 40,
                              vertical: constraints.maxWidth > 600 ? 48 : 30,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.inversePrimary,
                              borderRadius: .circular(16),
                            ),
                            child: Text(
                              "${titleTEC.text.isNotEmpty ? titleTEC.text[0].toUpperCase() : null}${titleTEC.text.isNotEmpty ? titleTEC.text[1] : null}",
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                fontSize: constraints.maxWidth > 600 ? 80 : 60,
                                fontWeight: .bold,
                              ),
                            ),
                          ),
                          Text(
                            "Created on ${DateFormat.yMMMd().format(credentials!.dateCreated!)}",
                          ),
                        ],
                      ),
                      Form(
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
                                      onPressed: () => isFavorite.value = !isFavorite.value!,
                                      icon: Icon(
                                        isFavorite.value!
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        size: constraints.maxWidth > 600 ? 48 : 32,
                                        color: isFavorite.value! ? Colors.red : Colors.white,
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
                    ],
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
          height: MediaQuery.sizeOf(context).height / 10,
          width: MediaQuery.sizeOf(context).width,
          child: TextButton.icon(
            onPressed: () {},
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

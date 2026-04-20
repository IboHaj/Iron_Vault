import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iron_vault/models/credentials.dart';
import 'package:iron_vault/notifiers/credentials_holder_notifier.dart';
import 'package:iron_vault/utils/utils.dart';
import 'package:iron_vault/views/detailed_credentials_view.dart';
import 'package:iron_vault/widgets/custom_snackbar.dart';

class CustomListTile extends ConsumerWidget {
  const CustomListTile({
    super.key,
    required this.credentials,
    this.isInSearch = false,
    this.isInTablet = false,
    this.onTap,
  });

  final Credentials credentials;
  final bool isInSearch;
  final bool isInTablet;
  final Function(Credentials)? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: context.screenWidth > 600 ? context.screenHeight * 0.4 : context.screenHeight * 0.2,
      width: context.screenWidth > 600 ? context.screenWidth * 0.4 : double.infinity,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailedCredentialsView(credentials: credentials),
          ),
        ),
        child: Card(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadiusGeometry.only(topRight: Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: .max,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: .start,
                    children: [
                      Column(
                        crossAxisAlignment: .start,
                        mainAxisAlignment: .center,
                        mainAxisSize: .max,
                        children: [
                          Text(
                            credentials.title!.toUpperCase(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            credentials.username!,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: .max,
                    mainAxisAlignment: .end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: credentials.password!));
                          CustomSnackbar.show(
                            context,
                            SnackBarUse.info,
                            "PASSWORD COPIED SUCCESSFULLY",
                          );
                        },
                        label: Text(
                          "CPY_PWD",
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            fontSize: 24,
                          ),
                        ),
                        icon: Icon(
                          Icons.copy,
                          color: Theme.of(context).colorScheme.primaryContainer,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

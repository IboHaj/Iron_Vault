import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iron_vault/l10n/app_localizations.dart';
import 'package:iron_vault/models/credentials.dart';
import 'package:iron_vault/notifiers/credentials_holder_notifier.dart';
import 'package:iron_vault/utils/utils.dart';
import 'package:iron_vault/views/detailed_credentials_view.dart';
import 'package:iron_vault/widgets/custom_dialog.dart';
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
      height: context.isTablet
          ? context.screenHeight * 0.4
          : context.isMediumScreen
          ? context.screenHeight * 0.2
          : context.screenHeight * 0.175,
      width: context.screenWidth > 600 ? context.screenWidth * 0.3 : double.infinity,
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
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(fontSize: 28 * context.scaled),
                          ),
                          Text(
                            credentials.username!,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 20 * context.scaled,
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
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () => CustomDialog.showCustomWarningDialog(
                          context,
                          content: "Are you sure you would like to delete these credentials?",
                          negativeLabel: "CANCEL",
                          positiveLabel: "DELETE",
                          onTapNegative: () => Navigator.of(context).pop(),
                          onTapPositive: () async {
                            await ref
                                .read(allCredentialsProvider.notifier)
                                .deleteCredentials(credentials);
                            if(context.mounted) Navigator.pop(context);
                          },
                          negativeIcon: Icons.cancel_outlined,
                          positiveIcon: Icons.delete_forever_sharp,
                        ),
                        label: Text(
                          AppLocalizations.of(context)!.delete,
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 24 * context.scaled,
                          ),
                        ),
                        icon: Icon(
                          Icons.delete_forever_sharp,
                          color: Theme.of(context).colorScheme.error,
                          size: 28 * context.scaled,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: credentials.password!));
                          CustomSnackbar.show(
                            context,
                            SnackBarUse.info,
                            "PASSWORD COPIED SUCCESSFULLY",
                          );
                          Future.delayed(Duration(seconds: 30), () {
                            Clipboard.setData(ClipboardData(text: ""));
                          });
                        },
                        label: Text(
                          AppLocalizations.of(context)!.copy_password,
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            fontSize: 24 * context.scaled,
                          ),
                        ),
                        icon: Icon(
                          Icons.copy,
                          color: Theme.of(context).colorScheme.primaryContainer,
                          size: 24 * context.scaled,
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

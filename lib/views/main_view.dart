import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iron_vault/views/new_credentials_view.dart';
import 'package:iron_vault/views/password_generator_view.dart';
import 'package:iron_vault/views/password_list_view.dart';
import 'package:iron_vault/views/settings_view.dart';
import 'package:iron_vault/widgets/custom_appbar.dart';
import 'package:iron_vault/widgets/password_create_bottomsheet.dart';

class MainView extends HookConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentDestination = useState(0);

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppbar(
            trailing: [
              Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsView()),
                    ),
                    icon: Icon(
                      Icons.settings,
                      color: Theme.of(context).colorScheme.primary,
                      size: 32,
                    ),
                  );
                },
              ),
            ],
            title: currentDestination.value == 0
                ? "IRON VAULT"
                : currentDestination.value == 1
                ? "PASSWORD GENERATOR"
                : "SETTINGS",
          ),
          body: [PasswordListView(), PasswordGeneratorView()][currentDestination.value],
          floatingActionButton: currentDestination.value == 0
              ? Builder(
                  builder: (context) {
                    return FloatingActionButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewCredentialsView()),
                      ),
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      child: Icon(Icons.add),
                    );
                  },
                )
              : null,
          bottomNavigationBar: HookBuilder(
            builder: (context) {
              return NavigationBar(
                height: 80,
                selectedIndex: currentDestination.value,
                onDestinationSelected: (value) => currentDestination.value = value,
                indicatorColor: Theme.of(context).colorScheme.primaryContainer,
                backgroundColor: Theme.of(context).colorScheme.onSecondaryFixed,
                labelTextStyle: WidgetStatePropertyAll(Theme.of(context).textTheme.labelSmall),
                destinations: [
                  NavigationDestination(
                    icon: Icon(Icons.password),
                    selectedIcon: Icon(
                      Icons.password,
                      color: Theme.of(context).colorScheme.onSecondaryFixed,
                    ),
                    label: "VAULT",
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(
                      Icons.shield,
                      color: Theme.of(context).colorScheme.onSecondaryFixed,
                    ),
                    label: "PASS. GENERATOR",
                    icon: Icon(Icons.shield),
                  ),
                ],
              );
            },
          ),
        ),
    );
  }
}

void addCredentialsBottomSheet(BuildContext ctx) {
  final TextEditingController titleTEC = TextEditingController();
  final TextEditingController usernameTEC = TextEditingController();
  final TextEditingController passwordTEC = TextEditingController();
  final TextEditingController noteTEC = TextEditingController();

  showModalBottomSheet(
    context: ctx,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    backgroundColor: Theme.of(ctx).colorScheme.surface,
    builder: (ctx) {
      return PasswordCreateBottomSheet(
        titleTEC: titleTEC,
        usernameTEC: usernameTEC,
        passwordTEC: passwordTEC,
        noteTEC: noteTEC,
      );
    },
  );
}

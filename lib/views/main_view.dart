import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iron_vault/models/credentials.dart';
import 'package:iron_vault/notifiers/credentials_holder_notifier.dart';
import 'package:iron_vault/utils/theme.dart';
import 'package:iron_vault/utils/utils.dart';
import 'package:iron_vault/views/detailed_credentials_view.dart';
import 'package:iron_vault/widgets/custom_appbar.dart';
import 'package:iron_vault/widgets/password_create_bottomsheet.dart';
import 'package:iron_vault/widgets/custom_list_tile.dart';

enum Filters { all, recent, favorites }

class MainView extends HookConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue values = ref.watch(allCredentialsProvider);
    var value = useState(0);
    var currentDestination = useState(0);
    var searchController = useSearchController();
    var isLandscape = useState(MediaQuery.of(context).orientation == Orientation.landscape);
    var isTablet = useState(MediaQuery.sizeOf(context).shortestSide > 600);
    ValueNotifier<Credentials?> currentlySelectedCredentials = useState(null);

    List<Credentials> recentList = [
      if (ref.read(allCredentialsProvider).value != null &&
          ref.read(allCredentialsProvider).value!.isNotEmpty)
        ref
            .watch(allCredentialsProvider)
            .value!
            .elementAt(ref.read(allCredentialsProvider).value!.length - 1)
            .values
            .first,
      if (ref.read(allCredentialsProvider).value != null &&
          ref.read(allCredentialsProvider).value!.length >= 2)
        ref
            .watch(allCredentialsProvider)
            .value!
            .elementAt(ref.read(allCredentialsProvider).value!.length - 2)
            .values
            .first,
      if (ref.read(allCredentialsProvider).value != null &&
          ref.read(allCredentialsProvider).value!.length >= 3)
        ref
            .watch(allCredentialsProvider)
            .value!
            .elementAt(ref.read(allCredentialsProvider).value!.length - 3)
            .values
            .first,
    ];

    List<Map<String, Credentials>> favorites = [
      if (ref.read(allCredentialsProvider).value != null)
        ...ref.watch(allCredentialsProvider).value!.where((e) => e.values.first.favorited == true),
    ];

    return SafeArea(
      child: MaterialApp(
        theme: MaterialTheme().dark(),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppbar(appbarHeight: context.screenHeight / 15),
          body: Container(
            padding: const EdgeInsets.all(16),
            height: context.screenHeight,
            width: context.screenWidth,
            child: Builder(
              builder: (context) {
                return Column(
                  spacing: context.screenWidth > 600 ? 12 : 8,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: .start,
                        spacing: context.screenWidth > 600 ? 8 : 4,
                        children: [
                          Text(
                            "CREDENTIALS SECURED:  ${ref.read(allCredentialsProvider).value?.length}",
                            style: Theme.of(
                              context,
                            ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Credentials are encrypted and stored locally on your device.",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SearchAnchor(
                        isFullScreen: isTablet.value,
                        searchController: searchController,
                        builder: (BuildContext context, SearchController controller) {
                          return SearchBar(
                            backgroundColor: WidgetStatePropertyAll(
                              Theme.of(context).colorScheme.onSecondaryFixed,
                            ),
                            padding: WidgetStatePropertyAll(
                              .symmetric(horizontal: context.screenWidth > 600 ? 28 : 20),
                            ),
                            elevation: WidgetStatePropertyAll(20),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(borderRadius: .circular(1)),
                            ),
                            leading: Icon(
                              Icons.search,
                              size: context.screenWidth > 600 ? 40 : 32,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            hintText: "SEARCH THE VAULT",
                            hintStyle: WidgetStatePropertyAll(
                              context.screenWidth > 600
                                  ? Theme.of(context).textTheme.labelLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.primary,
                                    )
                                  : Theme.of(context).textTheme.labelMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                            ),
                            onTap: () {
                              searchController.openView();
                            },
                            onTapOutside: (tapped) {
                              searchController.closeView("");
                            },
                          );
                        },
                        suggestionsBuilder: (BuildContext context, SearchController controller) {
                          List<Map<String, Credentials>>? searchResult = ref
                              .read(allCredentialsProvider)
                              .value
                              ?.where(
                                (e) =>
                                    ((e.values.first.title!.contains(controller.text) ||
                                        e.values.first.username!.contains(controller.text)) &&
                                    controller.text.isNotEmpty),
                              )
                              .toList();
                          return .generate(
                            searchResult!.length,
                            (index) => Padding(
                              padding: EdgeInsets.all(context.screenWidth > 600 ? 12.0 : 8.0),
                              child: CustomListTile(
                                credentials: searchResult[index].values.first,
                                isInSearch: true,
                                isInTablet: isTablet.value,
                                onTap: (credentials) {
                                  currentlySelectedCredentials.value = credentials;
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(
                      thickness: context.screenWidth > 600 ? 12 : 4,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    Expanded(
                      flex: 12,
                      child: values.when(
                        data: (data) => ListView.builder(
                          itemBuilder: (context, index) {
                            return CustomListTile(
                              credentials: value.value == 0
                                  ? ref.read(allCredentialsProvider).value![index].values.first
                                  : value.value == 1
                                  ? recentList[index]
                                  : favorites[index].values.first,
                              isInTablet: isTablet.value,
                              onTap: (credentials) {
                                currentlySelectedCredentials.value = credentials;
                              },
                            );
                          },
                          itemCount: value.value == 0
                              ? ref.read(allCredentialsProvider).value?.length
                              : value.value == 1
                              ? recentList.length
                              : favorites.length,
                        ),
                        error: (object, error) {
                          return Text("Error when updating credentials");
                        },
                        loading: () => CircularProgressIndicator(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Icon(Icons.add),
          ),
          bottomNavigationBar: HookBuilder(
            builder: (context) {
              return NavigationBar(
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
                    label: "PASS. GEN",
                    icon: Icon(Icons.shield),
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(
                      Icons.settings,
                      color: Theme.of(context).colorScheme.onSecondaryFixed,
                    ),
                    icon: Icon(Icons.settings),
                    label: "SETTINGS",
                  ),
                ],
              );
            },
          ),
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

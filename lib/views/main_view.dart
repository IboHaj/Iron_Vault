import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iron_vault/models/credentials.dart';
import 'package:iron_vault/notifiers/credentials_holder_notifier.dart';
import 'package:iron_vault/utils/theme.dart';
import 'package:iron_vault/views/detailed_credentials_view.dart';
import 'package:iron_vault/widgets/password_create_bottomsheet.dart';
import 'package:iron_vault/widgets/custom_list_tile.dart';

enum Filters { all, recent, favorites }

class MainView extends HookConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue values = ref.watch(allCredentialsProvider);
    var value = useState(0);
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
          appBar: AppBar(
            title: Text("Iron Vault"),
            scrolledUnderElevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: LayoutBuilder(
            builder: (context, constraints) => Padding(
              padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth > 600 ? 8 : 4),
              child: isTablet.value && isLandscape.value
                  ? Row(
                      spacing: 10,
                      children: [
                        Expanded(
                          flex: 31,
                          child: Column(
                            mainAxisAlignment: .start,
                            mainAxisSize: .max,
                            crossAxisAlignment: .center,
                            spacing: constraints.maxWidth > 600 ? 24 : 12,
                            children: [
                              SearchAnchor(
                                isFullScreen: !isTablet.value,
                                searchController: searchController,
                                builder: (context, searchController) {
                                  return SearchBar(
                                    padding: WidgetStatePropertyAll(
                                      .symmetric(horizontal: constraints.maxWidth > 600 ? 28 : 20),
                                    ),
                                    elevation: WidgetStatePropertyAll(20),
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(borderRadius: .circular(20)),
                                    ),
                                    leading: Icon(
                                      Icons.search,
                                      size: constraints.maxWidth > 600 ? 40 : 32,
                                      color: Colors.grey,
                                    ),
                                    hintText: "Search Credentials",
                                    hintStyle: WidgetStatePropertyAll(
                                      constraints.maxWidth > 600
                                          ? Theme.of(
                                              context,
                                            ).textTheme.labelLarge?.copyWith(color: Colors.grey)
                                          : Theme.of(
                                              context,
                                            ).textTheme.labelMedium?.copyWith(color: Colors.grey),
                                    ),
                                    onTap: () {
                                      searchController.openView();
                                    },
                                    onTapOutside: (tapped) {
                                      searchController.closeView("");
                                    },
                                  );
                                },
                                suggestionsBuilder: (context, controller) {
                                  List<Map<String, Credentials>>? searchResult = ref
                                      .read(allCredentialsProvider)
                                      .value
                                      ?.where(
                                        (e) =>
                                            ((e.values.first.title!.contains(controller.text) ||
                                                e.values.first.username!.contains(
                                                  controller.text,
                                                )) &&
                                            controller.text.isNotEmpty),
                                      )
                                      .toList();
                                  return .generate(
                                    searchResult!.length,
                                    (index) => Padding(
                                      padding: EdgeInsets.all(
                                        constraints.maxWidth > 600 ? 12.0 : 8.0,
                                      ),
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
                              Row(
                                mainAxisSize: .max,
                                crossAxisAlignment: .center,
                                mainAxisAlignment: .spaceEvenly,
                                children: .generate(
                                  3,
                                  (index) => ChoiceChip(
                                    padding: .symmetric(
                                      horizontal: constraints.maxWidth > 600 ? 20 : 20,
                                      vertical: constraints.maxWidth > 600 ? 20 : 20,
                                    ),
                                    showCheckmark: false,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadiusGeometry.circular(
                                        constraints.maxWidth > 600 ? 18 : 18,
                                      ),
                                    ),
                                    label: Text(
                                      Filters.values.elementAt(index).name,
                                      style: constraints.maxWidth > 600
                                          ? Theme.of(context).textTheme.titleLarge
                                          : Theme.of(context).textTheme.titleMedium,
                                    ),
                                    onSelected: (selected) {
                                      value.value = selected ? index : 0;
                                    },
                                    selected: value.value == index,
                                  ),
                                ),
                              ),
                              values.when(
                                data: (data) => Expanded(
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return CustomListTile(
                                        credentials: value.value == 0
                                            ? ref
                                                  .read(allCredentialsProvider)
                                                  .value![index]
                                                  .values
                                                  .first
                                            : value.value == 1
                                            ? recentList[index]
                                            : favorites[index].values.first,
                                        isInTablet: isTablet.value,
                                        onTap: (credentials) {
                                          return currentlySelectedCredentials.value = credentials;
                                        },
                                      );
                                    },
                                    itemCount: value.value == 0
                                        ? ref.read(allCredentialsProvider).value?.length
                                        : value.value == 1
                                        ? recentList.length
                                        : favorites.length,
                                  ),
                                ),
                                error: (object, error) {
                                  return Text("Error when updating credentials");
                                },
                                loading: () => CircularProgressIndicator(),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 69,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).colorScheme.secondaryContainer,
                            ),
                            child: DetailedCredentialsView(
                              credentials: currentlySelectedCredentials.value,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: .start,
                      mainAxisSize: .max,
                      crossAxisAlignment: .center,
                      spacing: constraints.maxWidth > 600 ? 24 : 12,
                      children: [
                        SearchAnchor(
                          searchController: searchController,
                          builder: (context, searchController) {
                            return SearchBar(
                              padding: WidgetStatePropertyAll(
                                .symmetric(horizontal: constraints.maxWidth > 600 ? 32 : 20),
                              ),
                              elevation: WidgetStatePropertyAll(20),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(borderRadius: .circular(20)),
                              ),
                              leading: Icon(
                                Icons.search,
                                size: constraints.maxWidth > 600 ? 48 : 32,
                                color: Colors.grey,
                              ),
                              hintText: "Search Credentials",
                              hintStyle: WidgetStatePropertyAll(
                                constraints.maxWidth > 600
                                    ? Theme.of(
                                        context,
                                      ).textTheme.labelLarge?.copyWith(color: Colors.grey)
                                    : Theme.of(
                                        context,
                                      ).textTheme.labelMedium?.copyWith(color: Colors.grey),
                              ),
                              onTap: () {
                                searchController.openView();
                              },
                              onTapOutside: (tapped) {
                                searchController.closeView("");
                              },
                            );
                          },
                          suggestionsBuilder: (context, controller) {
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
                                padding: EdgeInsets.all(constraints.maxWidth > 600 ? 16.0 : 8.0),
                                child: CustomListTile(
                                  credentials: searchResult[index].values.first,
                                  isInSearch: true,
                                  isInTablet: isTablet.value,
                                ),
                              ),
                            );
                          },
                        ),
                        Row(
                          mainAxisSize: .max,
                          crossAxisAlignment: .center,
                          mainAxisAlignment: .spaceEvenly,
                          children: .generate(
                            3,
                            (index) => ChoiceChip(
                              padding: .symmetric(
                                horizontal: constraints.maxWidth > 600 ? 32 : 20,
                                vertical: constraints.maxWidth > 600 ? 32 : 20,
                              ),
                              showCheckmark: false,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(
                                  constraints.maxWidth > 600 ? 30 : 18,
                                ),
                              ),
                              label: Text(
                                Filters.values.elementAt(index).name,
                                style: constraints.maxWidth > 600
                                    ? Theme.of(context).textTheme.titleLarge
                                    : Theme.of(context).textTheme.titleMedium,
                              ),
                              onSelected: (selected) {
                                value.value = selected ? index : 0;
                              },
                              selected: value.value == index,
                            ),
                          ),
                        ),
                        values.when(
                          data: (data) => Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return CustomListTile(
                                  credentials: value.value == 0
                                      ? ref.read(allCredentialsProvider).value![index].values.first
                                      : value.value == 1
                                      ? recentList[index]
                                      : favorites[index].values.first,
                                  isInTablet: isTablet.value,
                                );
                              },
                              itemCount: value.value == 0
                                  ? ref.read(allCredentialsProvider).value?.length
                                  : value.value == 1
                                  ? recentList.length
                                  : favorites.length,
                            ),
                          ),
                          error: (object, error) {
                            return Text("Error when updating credentials");
                          },
                          loading: () => CircularProgressIndicator(),
                        ),
                      ],
                    ),
            ),
          ),
          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => addCredentialsBottomSheet(context),
            ),
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

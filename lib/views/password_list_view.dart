import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:iron_vault/l10n/app_localizations.dart';
import 'package:iron_vault/models/credentials.dart';
import 'package:iron_vault/notifiers/credentials_holder_notifier.dart';
import 'package:iron_vault/utils/utils.dart';
import 'package:iron_vault/widgets/custom_list_tile.dart';

class PasswordListView extends HookConsumerWidget {
  const PasswordListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue values = ref.watch(allCredentialsProvider);
    var searchController = useSearchController();

    return Container(
      padding: const EdgeInsets.all(16),
      height: context.screenHeight,
      width: context.screenWidth,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            spacing: constraints.maxWidth > 600
                ? 16
                : constraints.maxWidth < 450
                ? 8
                : 12,
            children: [
              SizedBox(
                width: constraints.maxWidth,
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: constraints.maxWidth > 600 ? 8 : 4,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.credentials_secured} ${NumberFormat.decimalPattern(Localizations.localeOf(context).languageCode).format(ref.read(allCredentialsProvider).value?.length)}",
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 28 * context.scaled,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.main_view_string,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16 * context.scaled,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: constraints.maxWidth,
                child: SearchAnchor(
                  isFullScreen: context.isTablet,
                  searchController: searchController,
                  builder: (BuildContext context, SearchController controller) {
                    return SearchBar(
                      backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.onSecondaryFixed,
                      ),
                      padding: WidgetStatePropertyAll(
                        .symmetric(horizontal: constraints.maxWidth > 600 ? 28 : 20),
                      ),
                      elevation: WidgetStatePropertyAll(20),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(borderRadius: .circular(1)),
                      ),
                      leading: Icon(
                        Icons.search,
                        size: constraints.maxWidth > 600 ? 40 : 32,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      hintText: AppLocalizations.of(context)!.search_the_vault,
                      hintStyle: WidgetStatePropertyAll(
                        constraints.maxWidth > 600
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
                        padding: EdgeInsets.all(constraints.maxWidth > 600 ? 12.0 : 8.0),
                        child: CustomListTile(
                          credentials: searchResult[index].values.first,
                          isInSearch: true,
                          isInTablet: context.isTablet,
                          onTap: (credentials) {
                            // currentlySelectedCredentials.value = credentials;
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(
                thickness: constraints.maxWidth > 600 ? 12 : 4,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              SizedBox(
                height: constraints.maxHeight * 0.6,
                width: constraints.maxWidth,
                child: values.when(
                  data: (data) => ListView.builder(
                    itemBuilder: (context, index) {
                      return CustomListTile(
                        credentials: ref.read(allCredentialsProvider).value![index].values.first,

                        isInTablet: context.isTablet,
                        onTap: (credentials) {
                          // currentlySelectedCredentials.value = credentials;
                        },
                      );
                    },
                    itemCount: ref.read(allCredentialsProvider).value?.length,
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
    );
  }
}

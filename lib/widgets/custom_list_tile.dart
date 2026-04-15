import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iron_vault/models/credentials.dart';
import 'package:iron_vault/notifiers/credentials_holder_notifier.dart';
import 'package:iron_vault/views/detailed_credentials_view.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: constraints.maxWidth > 600 ? 12 : 8,
          vertical: constraints.maxWidth > 600 ? 6 : 3,
        ),
        child: IntrinsicHeight(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Slidable(
              enabled: !isInSearch,
              endActionPane: ActionPane(
                extentRatio: constraints.maxWidth > 600 ? 0.25 : 0.35,
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (ctx) {
                      ref.read(allCredentialsProvider.notifier).deleteCredentials(credentials);
                    },
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: "Delete",
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () => isInTablet ? onTap?.call(credentials) : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailedCredentialsView(credentials: credentials),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: .start,
                  crossAxisAlignment: .center,
                  children: [
                    Expanded(
                      flex: 28,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: constraints.maxWidth > 600 ? 18 : 10,
                        ),
                        alignment: .center,
                        decoration: BoxDecoration(
                          color: isInSearch
                              ? Theme.of(context).colorScheme.secondaryContainer
                              : Theme.of(context).colorScheme.onPrimary,
                        ),
                        child: Text(
                          "${credentials.title![0].toUpperCase()}${credentials.title![1].toLowerCase()}",
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            fontSize: constraints.maxWidth > 600 ? 56 : 40,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: VerticalDivider(
                        indent: 0,
                        endIndent: 0,
                        thickness: 8,
                        color: Colors.black,
                        width: constraints.maxWidth > 600 ? 20 : 10,
                      ),
                    ),
                    Expanded(
                      flex: 70,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth > 600 ? 18 : 10,
                          vertical: constraints.maxWidth > 600 ? 10 : 5,
                        ),
                        decoration: BoxDecoration(
                          color: isInSearch
                              ? Theme.of(context).colorScheme.onSecondaryFixed
                              : Theme.of(context).colorScheme.primaryContainer,
                        ),
                        child: Column(
                          mainAxisAlignment: .start,
                          crossAxisAlignment: .start,
                          spacing: constraints.maxWidth > 600 ? 18 : 10,
                          children: [
                            Text(
                              credentials.title!,
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                fontSize: constraints.maxWidth > 600 ? 40 : 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              credentials.username!,
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                fontSize: constraints.maxWidth > 600 ? 28 : 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}

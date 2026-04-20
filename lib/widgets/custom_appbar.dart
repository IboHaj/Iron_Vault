import 'package:flutter/material.dart';
import 'package:iron_vault/utils/utils.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final double appbarHeight;

  const CustomAppbar({super.key, required this.appbarHeight});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.3,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      title: Row(
        crossAxisAlignment: .center,
        mainAxisSize: .min,
        mainAxisAlignment: .start,
        spacing: context.screenWidth > 600 ? 12 : 8,
        children: [
          Icon(
            Icons.shield_outlined,
            size: context.screenHeight > 600 ? 36 : 24,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          Text(
            "IRON VAULT",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontStyle: FontStyle.italic,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      scrolledUnderElevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appbarHeight);
}

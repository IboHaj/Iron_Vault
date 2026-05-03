import 'package:flutter/material.dart';
import 'package:iron_vault/utils/utils.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final double appbarHeight;
  final String title;
  final Widget? leadingIcon;
  final bool? showLockIcon;
  final bool? centerTitle;
  final TextStyle? titleStyle;
  final Color? bgColor;
  final List<Widget>? trailing;

  const CustomAppbar({
    super.key,
    required this.appbarHeight,
    required this.title,
    this.leadingIcon,
    this.showLockIcon = true,
    this.centerTitle = false,
    this.titleStyle,
    this.bgColor,
    this.trailing
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: trailing,
      elevation: 0.3,
      centerTitle: centerTitle,
      leading: leadingIcon,
      backgroundColor: bgColor ?? Theme.of(context).colorScheme.surfaceContainerLow,
      title: Row(
        crossAxisAlignment: .center,
        mainAxisSize: .min,
        mainAxisAlignment: .start,
        spacing: context.screenWidth > 600 ? 12 : 8,
        children: [
          if (showLockIcon!)
            Icon(
              Icons.lock,
              size: context.screenHeight > 600 ? 36 : 24,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          Text(
            title,
            style:
                titleStyle ??
                Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontStyle: FontStyle.italic,
                  fontSize: 28 * context.scaled,
                  color: Theme.of(context).colorScheme.tertiary,
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

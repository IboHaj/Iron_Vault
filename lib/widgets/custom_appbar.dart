import 'package:flutter/material.dart';
import 'package:iron_vault/utils/utils.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final double? appbarHeight;
  final String title;
  final Widget? leadingIcon;
  final bool? centerTitle;
  final TextStyle? titleStyle;
  final Color? bgColor;
  final List<Widget>? trailing;
  final IconData? titleIcon;

  const CustomAppbar({
    super.key,
    required this.title,
    this.appbarHeight,
    this.leadingIcon,
    this.centerTitle = false,
    this.titleStyle,
    this.titleIcon,
    this.bgColor,
    this.trailing,
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
          if (titleIcon != null)
            Icon(
              titleIcon,
              size: 32,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          Text(
            title,
            style:
                titleStyle ??
                Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 28 * context.scaled,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ),
      scrolledUnderElevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appbarHeight ?? 56);
}

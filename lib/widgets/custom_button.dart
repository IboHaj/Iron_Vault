import 'package:flutter/material.dart';
import 'package:iron_vault/utils/utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.labelColor,
    required this.onTap,
    required this.height,
    required this.width,
    required this.color,
    this.icon,
    this.iconColor,
  });

  final String label;
  final Color labelColor;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback onTap;
  final double height;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.symmetric(
        vertical: 10, horizontal: 16,
      ),
      margin: EdgeInsetsGeometry.symmetric(
        horizontal: 10,
        vertical: 5
      ),
      height: height,
      width: width,
      decoration: BoxDecoration(borderRadius: BorderRadius.zero, color: color),
      child: GestureDetector(
        onTap: () => onTap.call(),
        child: Row(
          spacing: 10,
          mainAxisAlignment: .center,
          mainAxisSize: .min,
          crossAxisAlignment: .center,
          children: [
            if(icon != null)
              Icon(icon, size: 24 * context.scaled, color: iconColor!),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: labelColor, fontSize: 20 * context.scaled),
            ),
          ],
        ),
      ),
    );
  }
}

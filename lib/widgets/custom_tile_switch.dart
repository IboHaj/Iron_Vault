import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iron_vault/utils/utils.dart';

class CustomTileSwitch extends HookWidget {
  final double width;
  final ValueSetter<bool> onChanged;
  final String title;
  final String subtitle;
  final bool? startingState;

  const CustomTileSwitch({
    super.key,
    required this.width,
    required this.onChanged,
    required this.title,
    required this.subtitle,
    this.startingState = false,
  });

  @override
  Widget build(BuildContext context) {
    var switchState = useState(startingState);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      width: width,
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        spacing: 5,
        mainAxisSize: .min,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20 * context.scaled,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 14 * context.scaled,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            activeThumbColor: Theme.of(context).colorScheme.surface,
            activeTrackColor: Theme.of(context).colorScheme.primaryContainer,
            value: switchState.value ?? false,
            onChanged: (value) {
              onChanged.call(value);
              switchState.value = value;
            },
          ),
        ],
      ),
    );
  }
}

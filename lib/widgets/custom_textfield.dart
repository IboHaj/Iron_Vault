import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iron_vault/utils/utils.dart';
import 'package:iron_vault/widgets/custom_snackbar.dart';

class CustomTextfield extends StatefulHookWidget {
  const CustomTextfield({
    super.key,
    required this.label,
    required this.controller,
    this.isRequired = true,
    this.maxLines = 1,
    this.readOnly = false,
    this.errorMsg = "",
    this.icon,
    this.iconOnClick,
    this.isPassword = false,
    this.hintText,
    this.leadingIcon,
    this.obscureText = false,
    this.showPasswordGeneration = false,
    this.isNumbersOnly = false,
    this.maxLength,
    this.centerTextInput,
  });

  final String label;
  final TextEditingController controller;
  final bool isRequired;
  final int maxLines;
  final bool readOnly;
  final String? errorMsg;
  final Icon? icon;
  final Function()? iconOnClick;
  final bool? isPassword;
  final String? hintText;
  final IconData? leadingIcon;
  final bool? obscureText;
  final bool? showPasswordGeneration;
  final bool? isNumbersOnly;
  final int? maxLength;
  final bool? centerTextInput;

  @override
  State<StatefulWidget> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late CustomTextfield state;

  @override
  void initState() {
    super.initState();
    state = widget;
  }

  @override
  void didUpdateWidget(covariant CustomTextfield oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      state = widget;
    }
  }

  @override
  Widget build(BuildContext context) {
    var obscureText = useState(state.obscureText ?? false);

    return Container(
      padding: const EdgeInsetsGeometry.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        spacing: context.screenWidth > 450 ? 12 : 8,
        crossAxisAlignment: .start,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                widget.label.toUpperCase(),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 18 * context.scaled,
                ),
              ),
              if (widget.isRequired)
                Text(
                  "REQ*",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 14 * context.scaled,
                  ),
                ),
            ],
          ),
          TextFormField(
            textAlign: widget.centerTextInput ?? false ? TextAlign.center : TextAlign.start,
            validator: (value) {
              if (widget.isRequired) {
                if (value == null || value.isEmpty) return "";
              }
              return null;
            },
            keyboardType: widget.isNumbersOnly ?? false ? TextInputType.number : null,
            cursorColor: Colors.white,
            maxLength: widget.maxLength,
            style: widget.isNumbersOnly ?? false
                ? Theme.of(context).textTheme.bodyLarge
                : Theme.of(context).textTheme.bodyMedium,
            autocorrect: false,
            inputFormatters: [
              ?widget.isNumbersOnly ?? false ? FilteringTextInputFormatter.digitsOnly : null,
            ],
            readOnly: widget.readOnly,
            enableInteractiveSelection: true,
            obscureText: obscureText.value,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: 16 * context.scaled,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              focusColor: Colors.white,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
              focusedErrorBorder: OutlineInputBorder(),
              errorStyle: TextStyle(height: 0, fontSize: 0),
              disabledBorder: OutlineInputBorder(),
              prefixIcon: widget.leadingIcon != null
                  ? Icon(
                      widget.leadingIcon,
                      size: 18 * context.scaled,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    )
                  : null,
              suffix: widget.icon != null
                  ? IconButton(onPressed: () => widget.iconOnClick?.call(), icon: widget.icon!)
                  : null,
              suffixIcon: (state.readOnly && !state.isPassword!)
                  ? IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: widget.controller.text));
                        CustomSnackbar.show(
                          context,
                          SnackBarUse.success,
                          "${widget.label} copied!",
                        );
                      },
                      icon: Icon(Icons.copy, color: Colors.white, size: 24),
                    )
                  : (state.isPassword! && state.readOnly)
                  ? Row(
                      mainAxisSize: .min,
                      children: [
                        IconButton(
                          onPressed: () => obscureText.value = !obscureText.value,
                          icon: Icon(
                            obscureText.value ? Icons.visibility : Icons.visibility_off,
                            size: 20 * context.scaled,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: widget.controller.text));
                            CustomSnackbar.show(
                              context,
                              SnackBarUse.success,
                              "${widget.label} copied!",
                            );
                          },
                          icon: Icon(Icons.copy, color: Colors.white, size: 24),
                        ),
                      ],
                    )
                  : ((state.isPassword ?? false) && !state.readOnly)
                  ? Row(
                      mainAxisSize: .min,
                      children: [
                        IconButton(
                          onPressed: () => obscureText.value = !obscureText.value,
                          icon: Icon(
                            obscureText.value ? Icons.visibility : Icons.visibility_off,
                            size: 20 * context.scaled,
                          ),
                        ),
                        if (widget.showPasswordGeneration!)
                          IconButton(
                            icon: Icon(
                              Icons.auto_fix_high_outlined,
                              size: 28 * context.scaled,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onPressed: () => widget.iconOnClick!.call(),
                          ),
                      ],
                    )
                  : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(width: 0, style: BorderStyle.none),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, style: BorderStyle.none),
              ),
              errorBorder: OutlineInputBorder(),
              labelStyle: Theme.of(context).textTheme.labelMedium,
            ),
            maxLines: widget.maxLines,
            controller: widget.controller,
          ),
        ],
      ),
    );
  }
}

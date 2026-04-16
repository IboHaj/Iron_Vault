import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfield extends StatefulWidget {
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
  });

  final String label;
  final TextEditingController controller;
  final bool isRequired;
  final int maxLines;
  final bool readOnly;
  final String? errorMsg;
  final Icon? icon;
  final Function()? iconOnClick;

  @override
  State<StatefulWidget> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        print(value);
      },
      validator: (value) {
        if(widget.isRequired) {
          if(value == null || value.isEmpty) return "";
        }
        return null;
      },
      cursorColor: Colors.white,
      style: Theme.of(context).textTheme.bodyMedium,
      autocorrect: false,
      readOnly: widget.readOnly,
      enableInteractiveSelection: true,
      decoration: InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 3),
        ),
        errorStyle: TextStyle(
          height: 0,
          fontSize: 0
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primaryContainer, width: 3),
        ),
        suffix: widget.icon != null
            ? IconButton(onPressed: () => widget.iconOnClick?.call(), icon: widget.icon!)
            : null,
        suffixIcon: widget.readOnly
            ? IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: widget.controller.text));
                  // ScaffoldMessenger.of(
                  //   context,
                  // ).showSnackBar(CustomSnackbar.success("${widget.label} copied!"));
                  // CustomSnackbar.success("${widget.label} copied!");
                },
                icon: Icon(Icons.copy, color: Colors.white, size: 24),
              )
            : null,
        labelText: "${widget.label} ${widget.isRequired ? "*" : ""}",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primaryContainer, width: 3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onSecondary, width: 3),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 3),
        ),
        labelStyle: Theme.of(context).textTheme.labelMedium,
      ),
      maxLines: widget.maxLines,
      controller: widget.controller,
    );
  }
}

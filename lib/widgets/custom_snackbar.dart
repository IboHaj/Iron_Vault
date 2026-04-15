import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum SnackBarUse { info, success, error }

class CustomSnackbar {
  static void show(BuildContext context, SnackBarUse snackbarUse, String msg) {
    final overlay = Overlay.of(context);

    late final OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) =>
          Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                child: Material(
                  color: Colors.transparent,
                  child: LayoutBuilder(
                    builder:(context, constraints) => Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 12,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        mainAxisSize: .min,
                        mainAxisAlignment: .center,
                        crossAxisAlignment: .center,
                        spacing: constraints.maxWidth > 600 ? 18 : 12,
                        children: [
                          Expanded(
                            child: VerticalDivider(
                              indent: 0,
                              endIndent: 0,
                              thickness: constraints.maxWidth > 600 ? 48 : 20,
                              color: snackbarUse == SnackBarUse.error
                                  ? Colors.red
                                  : snackbarUse == SnackBarUse.success
                                  ? Colors.green
                                  : Colors.lightBlue,
                              width: 1,
                            ),
                          ),
                          Expanded(
                            child: Icon(
                              snackbarUse == SnackBarUse.error
                                  ? Icons.warning_amber_outlined
                                  : snackbarUse == SnackBarUse.success
                                  ? Icons.check_circle
                                  : Icons.info_outline,
                              size: constraints.maxWidth > 600 ? 32 : 24,
                              color: snackbarUse == SnackBarUse.error
                                  ? Colors.red
                                  : snackbarUse == SnackBarUse.success
                                  ? Colors.green
                                  : Colors.lightBlue,
                            ),
                          ),
                          Expanded(
                            flex: 18,
                            child: Text(
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(color: Colors.black),
                              msg,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .animate()
              .slideY(begin: 1, end: 0)
              .then(delay: Duration(seconds: 3))
              .then()
              .slideY(begin: 0, end: 2, duration: Duration(milliseconds: 500)),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(milliseconds: 4500), () => overlayEntry.remove());
  }
}

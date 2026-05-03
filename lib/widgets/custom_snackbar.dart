import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iron_vault/utils/utils.dart';

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
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: context.isTablet ? context.screenWidth * 0.2 : context.screenWidth,
                    height: context.isTablet
                        ? context.screenHeight * 0.08
                        : context.screenHeight * 0.1,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      border: Border(
                        left: BorderSide(
                          width: context.isTablet ? 20 : 12,
                          color: snackbarUse == SnackBarUse.error
                              ? Theme.of(context).colorScheme.error
                              : snackbarUse == SnackBarUse.success
                              ? Theme.of(context).colorScheme.primaryFixedDim
                              : Theme.of(context).colorScheme.onTertiaryContainer,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: .min,
                      mainAxisAlignment: .start,
                      crossAxisAlignment: .center,
                      spacing: context.screenWidth > 600 ? 18 : 12,
                      children: [
                        Expanded(
                          child: Icon(
                            snackbarUse == SnackBarUse.error
                                ? Icons.warning_amber_outlined
                                : snackbarUse == SnackBarUse.success
                                ? Icons.check_circle_outline
                                : Icons.info_outline,
                            size: context.screenWidth > 450 ? 32 : 28,
                            color: snackbarUse == SnackBarUse.error
                                ? Theme.of(context).colorScheme.error
                                : snackbarUse == SnackBarUse.success
                                ? Theme.of(context).colorScheme.primaryFixedDim
                                : Theme.of(context).colorScheme.onTertiaryContainer,
                          ),
                        ),
                        Expanded(
                          flex: 12,
                          child: Text(
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20 * context.scaled
                            ),
                            msg,
                          ),
                        ),
                      ],
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

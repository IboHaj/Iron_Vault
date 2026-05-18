import 'package:flutter/material.dart';
import 'package:iron_vault/utils/utils.dart';
import 'package:iron_vault/widgets/custom_button.dart';
import 'package:iron_vault/widgets/custom_textfield.dart';

class CustomDialog {
  static Future<void> showCustomWarningDialog(
    BuildContext context, {
    required String positiveLabel,
    required String negativeLabel,
    required String content,
    required VoidCallback onTapPositive,
    required VoidCallback onTapNegative,
    required IconData positiveIcon,
    required IconData negativeIcon,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: Border(
          left: BorderSide(color: Theme.of(context).colorScheme.errorContainer, width: 5),
        ),
        title: Text("WARNING", style: Theme.of(context).textTheme.headlineLarge),
        content: Text(content, style: Theme.of(context).textTheme.labelLarge),
        actionsAlignment: .spaceBetween,
        actions: [
          CustomButton(
            label: positiveLabel,
            labelColor: Theme.of(context).colorScheme.primary,
            onTap: () => onTapPositive.call(),
            height: context.screenHeight * 0.06,
            width: context.screenWidth * 0.8,
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            iconColor: Theme.of(context).colorScheme.primary,
            icon: positiveIcon,
          ),
          CustomButton(
            label: negativeLabel,
            labelColor: Theme.of(context).colorScheme.surfaceContainerLow,
            onTap: () => onTapNegative.call(),
            height: context.screenHeight * 0.06,
            width: context.screenWidth * 0.8,
            color: Theme.of(context).colorScheme.errorContainer,
            icon: negativeIcon,
            iconColor: Theme.of(context).colorScheme.surfaceContainerLow,
          ),
        ],
      ),
    );
  }

  static Future<void> showPasswordDialog(
    BuildContext context,
    TextEditingController controller,
    VoidCallback onTapSave, {
    bool? changingPassword = false,
  }) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8)),
        title: Text(
          changingPassword! ? "PIN UPDATING" : "PIN SETUP",
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        alignment: .center,
        children: [
          Text(
            changingPassword ? "Please enter the current PIN" : "Please enter 6 numeric value",
            textAlign: .center,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          CustomTextfield(
            label: "",
            maxLength: 6,
            controller: controller,
            isNumbersOnly: true,
            isRequired: false,
            centerTextInput: true,
          ),
          Row(
            mainAxisAlignment: .center,
            children: [
              CustomButton(
                icon: Icons.cancel_sharp,
                iconColor: Theme.of(context).colorScheme.primaryContainer,
                label: "Cancel",
                labelColor: Theme.of(context).colorScheme.primary,
                onTap: () => Navigator.pop(context),
                height: context.screenHeight * 0.065,
                width: context.screenWidth * 0.34,
                color: Theme.of(context).colorScheme.surfaceContainerLow,
              ),
              CustomButton(
                icon: changingPassword ? Icons.check : Icons.save,
                iconColor: Theme.of(context).colorScheme.primaryContainer,
                label: changingPassword ? "Ok" : "Save",
                labelColor: Theme.of(context).colorScheme.primary,
                onTap: () {
                  onTapSave.call();
                },
                height: context.screenHeight * 0.065,
                width: context.screenWidth * 0.34,
                color: Theme.of(context).colorScheme.surfaceContainerLow,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

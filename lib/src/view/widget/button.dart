import 'package:flutter/material.dart';
import 'package:ios_communication_prototype/src/app_preferences/app_preferences_controller.dart';
import 'package:ios_communication_prototype/src/core/constants.dart';

Widget customPrimaryButton(
  BuildContext context,
  AppPreferencesController appPreferencesController, {
  required String text,
  void Function()? onTap,
  double? width,
  double? height,
  bool enabled = true,
}) {
  return GestureDetector(
    onTap: enabled ? onTap : () {},
    child: Container(
      height: height ?? 56,
      width: width ?? 120,
      decoration: enabled
          ? BoxDecoration(
              borderRadius: AppBorderRadius.large,
              color: appPreferencesController.getThemeData().colorScheme.primary,
            )
          : BoxDecoration(
              borderRadius: AppBorderRadius.large,
              color: appPreferencesController.getThemeData().colorScheme.primary.withOpacity(0.45),
            ),
      constraints: const BoxConstraints(maxWidth: 520),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: appPreferencesController.getThemeData().colorScheme.surface,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

Widget customPrimaryButtonWithGradient(
  BuildContext context,
  AppPreferencesController appPreferencesController, {
  required String text,
  void Function()? onTap,
  double? width,
  double? height,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height ?? 56,
      width: width ?? 120,
      decoration: const BoxDecoration(
        borderRadius: AppBorderRadius.large,
        gradient: LinearGradient(
          // gradient starts from left
          begin: Alignment.centerLeft,
          // gradient ends at right
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(20, 48, 246, 1),
            Color.fromRGBO(21, 18, 41, 1),
            Color.fromRGBO(103, 22, 251, 1),
            Color.fromRGBO(133, 14, 252, 1),
          ],
        ),
      ),
      constraints: const BoxConstraints(maxWidth: 520),
      child: Center(
        child: Text(
          text,
          style: appPreferencesController.getThemeData().textTheme.bodyLarge?.copyWith(
                color: appPreferencesController.getThemeData().colorScheme.surface,
                fontWeight: FontWeight.w600,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

Widget customSecondaryButton(
  BuildContext context,
  AppPreferencesController appPreferencesController, {
  required String text,
  void Function()? onTap,
  double? width,
  double? height,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height ?? 56,
      width: width ?? 120,
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.large,
        color: Colors.transparent,
        border: Border.all(
          color: appPreferencesController.getThemeData().colorScheme.primary,
          width: 1.5,
        ),
      ),
      constraints: const BoxConstraints(maxWidth: 520),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: appPreferencesController.getThemeData().colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

Widget customSecondaryIconButton(
  BuildContext context,
  AppPreferencesController appPreferencesController, {
  required Widget icon,
  void Function()? onTap,
  double? width,
  double? height,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height ?? 56,
      width: width ?? 120,
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.large,
        color: Colors.transparent,
        border: Border.all(
          color: appPreferencesController.getThemeData().colorScheme.primary,
          width: 1.5,
        ),
      ),
      constraints: const BoxConstraints(maxWidth: 520),
      child: Center(
        child: icon,
      ),
    ),
  );
}

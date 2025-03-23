import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ios_communication_prototype/src/app_preferences/app_preferences_controller.dart';
import 'package:ios_communication_prototype/src/core/constants.dart';

class NormalTextField extends StatelessWidget {
  final AppPreferencesController appPreferencesController;
  final TextEditingController controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final double? width;
  final double? height;

  const NormalTextField({
    super.key,
    required this.appPreferencesController,
    required this.controller,
    this.hintText,
    this.keyboardType,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height ?? 56,
        width: width ?? 120,
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: 1,
          inputFormatters: keyboardType == TextInputType.number ? [FilteringTextInputFormatter.digitsOnly] : null,
          style: const TextStyle(
            fontSize: 14,
          ),
          cursorColor: appPreferencesController.getThemeData().textTheme.bodyMedium?.color?.withOpacity(0.8),
          cursorErrorColor: appPreferencesController.getThemeData().colorScheme.error,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: appPreferencesController.getThemeData().colorScheme.secondary,
            focusColor: appPreferencesController.getThemeData().textTheme.bodyMedium?.color,
            hintStyle: TextStyle(
              color: appPreferencesController.getThemeData().textTheme.bodyMedium?.color?.withOpacity(0.6),
            ),
            border: const OutlineInputBorder(
              borderRadius: AppBorderRadius.large,
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppBorderRadius.large,
              borderSide: BorderSide(color: appPreferencesController.getThemeData().colorScheme.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: AppBorderRadius.large,
              borderSide: BorderSide(color: appPreferencesController.getThemeData().colorScheme.error),
            ),
          ),
        ),
      ),
    );
  }
}

class MultiLineTextField extends StatelessWidget {
  final AppPreferencesController appPreferencesController;
  final TextEditingController controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final double? width;
  final double? height;
  final int? maxLength;

  const MultiLineTextField({
    super.key,
    required this.appPreferencesController,
    required this.controller,
    this.hintText,
    this.keyboardType,
    this.width,
    this.height,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        maxLines: 5,
        maxLength: maxLength,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Color.fromRGBO(24, 39, 58, 0.94),
        ),
        decoration: InputDecoration(
          fillColor: appPreferencesController.getThemeData().colorScheme.secondary,
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: AppBorderRadius.large,
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppBorderRadius.large,
            borderSide: BorderSide(color: appPreferencesController.getThemeData().colorScheme.primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: AppBorderRadius.large,
            borderSide: BorderSide(color: appPreferencesController.getThemeData().colorScheme.error),
          ),
        ),
      ),
    );
  }
}

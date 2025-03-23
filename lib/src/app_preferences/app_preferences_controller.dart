import 'package:flutter/material.dart';
import 'package:ios_communication_prototype/src/core/constants.dart';

import 'app_preferences_service.dart';

/// A class that many Widgets can interact with to read user preferences, update
/// user preferences, or listen to preference changes.
///
/// Controllers glue Data Services to Flutter Widgets. The AppPreferencesController
/// uses the AppPreferencesService to store and retrieve user preferences.
class AppPreferencesController with ChangeNotifier {
  AppPreferencesController(this._appPreferencesService);

  // Make AppPreferencesService a private variable so it is not used directly.
  final AppPreferencesService _appPreferencesService;

  // Make ThemeMode a private variable so it is not updated directly without
  // also persisting the changes with the AppPreferencesService.
  late ThemeMode _themeMode;

  // Allow Widgets to read the user's preferred ThemeMode.
  ThemeMode get themeMode => _themeMode;

  // Add private locale variable
  late String _locale;

  // Add getter for locale
  String get locale => _locale;

  // Add private font variable
  late FontName _font;

  // Add getter for font
  FontName get font => _font;

  /// Load the user's preferences from the AppPreferencesService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// preferences from the service.
  Future<void> loadPreferences() async {
    _themeMode = _appPreferencesService.themeMode();
    _locale = _appPreferencesService.locale();
    _font = _appPreferencesService.font();

    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    // Do not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _themeMode) return;

    // Otherwise, store the new ThemeMode in memory
    _themeMode = newThemeMode;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the AppPreferencesService.
    await _appPreferencesService.updateThemeMode(newThemeMode);
  }

  /// Update and persist the locale based on the user's selection.
  Future<void> updateLocale(String? newLocale) async {
    if (newLocale == null) return;

    // Do not perform any work if new and old locale are identical
    if (newLocale == _locale) return;

    // Otherwise, store the new locale in memory
    _locale = newLocale;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes using the AppPreferencesService
    await _appPreferencesService.updateLocale(newLocale);
  }

  /// Update and persist the locale based on the user's selection.
  Future<void> updateFont(FontName? newFont) async {
    if (newFont == null) return;

    // Do not perform any work if new and old locale are identical
    if (newFont == _font) return;

    // Otherwise, store the new locale in memory
    _font = newFont;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes using the AppPreferencesService
    _appPreferencesService.updateFont(newFont);
  }

  ThemeData getLightThemeData(String font) {
    return ThemeData.from(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        surface: AppColor.lightBackground,
        onSurface: AppColor.lightBackground,
        primary: AppColor.lightPrimary,
        onPrimary: AppColor.onLightPrimary,
        secondary: AppColor.lightSecondary,
        onSecondary: AppColor.onLightSecondary,
        error: AppColor.lightWarning,
        onError: AppColor.onLightWarning,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: font,
          color: AppColor.customBlack,
          fontSize: 57,
          letterSpacing: 0.25,
          fontWeight: FontWeight.normal,
        ),
        displayMedium: TextStyle(
          fontFamily: font,
          color: AppColor.customBlack,
          fontSize: 45,
          letterSpacing: 0.35,
          fontWeight: FontWeight.normal,
        ),
        displaySmall: TextStyle(
          fontFamily: font,
          color: AppColor.customBlack,
          fontSize: 36,
          letterSpacing: 0.4,
          fontWeight: FontWeight.normal,
        ),
        headlineLarge: TextStyle(
          fontFamily: font,
          color: AppColor.customBlack,
          fontSize: 32,
          letterSpacing: 0.5,
          fontWeight: FontWeight.normal,
        ),
        headlineMedium: TextStyle(
          fontFamily: font,
          color: AppColor.customBlack,
          fontSize: 28,
          letterSpacing: 0.6,
          fontWeight: FontWeight.normal,
        ),
        headlineSmall: TextStyle(
          fontFamily: font,
          color: AppColor.customBlack,
          fontSize: 24,
          letterSpacing: 0.7,
          fontWeight: FontWeight.normal,
        ),
        titleLarge: TextStyle(
          fontFamily: font,
          color: AppColor.customBlack,
          fontSize: 22,
          letterSpacing: 0.75,
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          fontFamily: font,
          color: AppColor.customBlack,
          fontSize: 16,
          letterSpacing: 0.35,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          fontFamily: font,
          color: AppColor.customBlack,
          fontSize: 14,
          letterSpacing: 0.4,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          fontFamily: font,
          color: AppColor.customBlack,
          fontSize: 16,
          letterSpacing: 0.35,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          fontFamily: font,
          color: AppColor.customBlack,
          fontSize: 14,
          letterSpacing: 0.45,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: TextStyle(
          fontFamily: font,
          color: AppColor.customBlack,
          fontSize: 12,
          letterSpacing: 0.5,
          fontWeight: FontWeight.normal,
        ),
        labelLarge: TextStyle(
          fontFamily: font,
          color: AppColor.customBlack,
          fontSize: 14,
          letterSpacing: 0.35,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          fontFamily: font,
          color: AppColor.customBlack,
          fontSize: 12,
          letterSpacing: 0.55,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          fontFamily: font,
          color: AppColor.customBlack,
          fontSize: 11,
          letterSpacing: 0.6,
          fontWeight: FontWeight.w500,
        ),
      ),
      useMaterial3: true,
    );
  }

  ThemeData getDarkThemeData(String font) {
    return ThemeData.from(
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        surface: AppColor.darkBackground,
        onSurface: AppColor.darkBackground,
        primary: AppColor.darkPrimary,
        onPrimary: AppColor.onDarkPrimary,
        secondary: AppColor.darkSecondary,
        onSecondary: AppColor.onDarkSecondary,
        error: AppColor.darkWarning,
        onError: AppColor.onDarkWarning,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: font,
          color: AppColor.customWhite,
          fontSize: 57,
          letterSpacing: 0.25,
          fontWeight: FontWeight.normal,
        ),
        displayMedium: TextStyle(
          fontFamily: font,
          color: AppColor.customWhite,
          fontSize: 45,
          letterSpacing: 0.35,
          fontWeight: FontWeight.normal,
        ),
        displaySmall: TextStyle(
          fontFamily: font,
          color: AppColor.customWhite,
          fontSize: 36,
          letterSpacing: 0.4,
          fontWeight: FontWeight.normal,
        ),
        headlineLarge: TextStyle(
          fontFamily: font,
          color: AppColor.customWhite,
          fontSize: 32,
          letterSpacing: 0.5,
          fontWeight: FontWeight.normal,
        ),
        headlineMedium: TextStyle(
          fontFamily: font,
          color: AppColor.customWhite,
          fontSize: 28,
          letterSpacing: 0.6,
          fontWeight: FontWeight.normal,
        ),
        headlineSmall: TextStyle(
          fontFamily: font,
          color: AppColor.customWhite,
          fontSize: 24,
          letterSpacing: 0.7,
          fontWeight: FontWeight.normal,
        ),
        titleLarge: TextStyle(
          fontFamily: font,
          color: AppColor.customWhite,
          fontSize: 22,
          letterSpacing: 0.75,
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          fontFamily: font,
          color: AppColor.customWhite,
          fontSize: 16,
          letterSpacing: 0.35,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          fontFamily: font,
          color: AppColor.customWhite,
          fontSize: 14,
          letterSpacing: 0.4,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          fontFamily: font,
          color: AppColor.customWhite,
          fontSize: 16,
          letterSpacing: 0.35,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          fontFamily: font,
          color: AppColor.customWhite,
          fontSize: 14,
          letterSpacing: 0.45,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: TextStyle(
          fontFamily: font,
          color: AppColor.customWhite,
          fontSize: 12,
          letterSpacing: 0.5,
          fontWeight: FontWeight.normal,
        ),
        labelLarge: TextStyle(
          fontFamily: font,
          color: AppColor.customWhite,
          fontSize: 14,
          letterSpacing: 0.35,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          fontFamily: font,
          color: AppColor.customWhite,
          fontSize: 12,
          letterSpacing: 0.55,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          fontFamily: font,
          color: AppColor.customWhite,
          fontSize: 11,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w500,
        ),
      ),
      useMaterial3: true,
    );
  }

  ThemeData getThemeData() {
    if (ThemeMode.dark.name == themeMode.name) {
      return getDarkThemeData(_appPreferencesService.font().name);
    } else if (ThemeMode.light.name == themeMode.name) {
      return getLightThemeData(_appPreferencesService.font().name);
    } else if (ThemeMode.system.name == themeMode.name) {
      return getDarkThemeData(_appPreferencesService.font().name);
    } else {
      return getLightThemeData(_appPreferencesService.font().name);
    }
  }

  ThemeData getThemeDataByThemeMode(ThemeMode theme) {
    if (ThemeMode.dark.name == theme.name) {
      return getDarkThemeData(_appPreferencesService.font().name);
    } else if (ThemeMode.light.name == theme.name) {
      return getLightThemeData(_appPreferencesService.font().name);
    } else {
      return getDarkThemeData(_appPreferencesService.font().name);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// A service that stores and retrieves user preferences.
class AppPreferencesService extends GetxController {
  /// Loads the User's preferred ThemeMode from local storage
  ThemeMode themeMode() {
    String storedTheme = GetStorage().read('appTheme') ?? ''; // null check for first time running this
    print(storedTheme);
    if (ThemeMode.light.name.toString() == storedTheme) {
      return ThemeMode.light;
    } else if (ThemeMode.dark.name.toString() == storedTheme) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  /// Persists the user's preferred ThemeMode to local storage
  Future<void> updateThemeMode(ThemeMode theme) async {
    await GetStorage().write('appTheme', theme.name.toString());
  }

  /// Loads the User's preferred Locale from local storage
  String locale() {
    String storedLocale = GetStorage().read('appLocale') ?? 'en'; // default to 'en'
    return storedLocale;
  }

  /// Persists the user's preferred Locale to local storage
  Future<void> updateLocale(String locale) async {
    await GetStorage().write('appLocale', locale);
  }

  /// Loads the User's preferred Font from local storage
  FontName font() {
    String storedFont = GetStorage().read('appFont') ?? 'TimelessMemories'; // default to 'TimelessMemories'
    return FontName.values.byName(storedFont);
  }

  /// Persists the user's preferred Font to local storage
  Future<void> updateFont(FontName font) async {
    await GetStorage().write('appFont', font.name);
  }
}

enum FontName {
  Roboto,
  Akeila,
  Mod20,
  TimelessMemories,
}

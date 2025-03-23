import 'package:flutter/material.dart';

// ignore: camel_case_types
enum pageState { loading, loaded, error, initial }

class AppIcon {
  static const String appIcon = 'assets/icon/icon-192x192.png';
}

class AppImage {
  static const String placeholder = 'assets/image/placeholder.png';
  static const String serverInternalErrorVector = 'assets/image/server_internal_error.png';
}

class AppRegex {
  static final emailRegex = RegExp(r'^[\w\.-]+(\+[\w-]+)?@([\w-]+\.)+[\w-]{2,8}$');
}

class AppInputLength {
  static const int name = 100;
  static const int refcode = 20;
  static const int phoneNumber = 11;
}

class AppColor {
  // custom black and white
  static Color customBlack = HexColor.fromHex('#0F0F0F');
  static Color customWhite = HexColor.fromHex('#EDF0F5');

  // Background
  static Color lightBackground = HexColor.fromHex('#CBDAE3');
  static Color darkBackground = HexColor.fromHex('#151520');

  // Primary
  static Color lightPrimary = HexColor.fromHex('#6A8EC6');
  static Color onLightPrimary = HexColor.fromHex('#6A8EC6').withOpacity(0.9);
  static Color darkPrimary = HexColor.fromHex('#5A759E');
  static Color onDarkPrimary = HexColor.fromHex('#5A759E').withOpacity(0.9);

  // Secondary
  static Color lightSecondary = HexColor.fromHex('#EDF0F5');
  static Color onLightSecondary = HexColor.fromHex('#EDF0F5').withOpacity(0.9);
  static Color darkSecondary = HexColor.fromHex('#192034');
  static Color onDarkSecondary = HexColor.fromHex('#192034').withOpacity(0.9);

  // Warning
  static Color lightWarning = HexColor.fromHex('#E43E2B');
  static Color onLightWarning = HexColor.fromHex('#E43E2B').withOpacity(0.9);
  static Color darkWarning = HexColor.fromHex('#E43E2B');
  static Color onDarkWarning = HexColor.fromHex('#E43E2B').withOpacity(0.9);

  // Success
  static Color lightSuccess = HexColor.fromHex('#2BA24C');
  static Color onLightSuccess = HexColor.fromHex('#2BA24C').withOpacity(0.9);
  static Color darkSuccess = HexColor.fromHex('#2BA24C');
  static Color onDarkSuccess = HexColor.fromHex('#2BA24C').withOpacity(0.9);

  // popup
  static Color popupDialogBarrierColor = const Color.fromARGB(132, 0, 0, 0);
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class AppPadding {
  // General padding values
  static const double small = 4.0;
  static const double medium = 8.0;
  static const double large = 16.0;
  static const double xLarge = 24.0;
  static const double xxLarge = 36.0;
  static const double xxxLarge = 48.0;

  // Symmetrical paddings
  static const EdgeInsets smallSymmetric = EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0);
  static const EdgeInsets mediumSymmetric = EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);
  static const EdgeInsets largeSymmetric = EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0);
  static const EdgeInsets xLargeSymmetric = EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0);

  // Horizontal paddings
  static const EdgeInsets smallHorizontal = EdgeInsets.symmetric(horizontal: 8.0);
  static const EdgeInsets mediumHorizontal = EdgeInsets.symmetric(horizontal: 16.0);
  static const EdgeInsets largeHorizontal = EdgeInsets.symmetric(horizontal: 24.0);
  static const EdgeInsets xLargeHorizontal = EdgeInsets.symmetric(horizontal: 32.0);

  // Vertical paddings
  static const EdgeInsets smallVertical = EdgeInsets.symmetric(vertical: 4.0);
  static const EdgeInsets mediumVertical = EdgeInsets.symmetric(vertical: 8.0);
  static const EdgeInsets largeVertical = EdgeInsets.symmetric(vertical: 16.0);
  static const EdgeInsets xLargeVertical = EdgeInsets.symmetric(vertical: 24.0);

  // Top-only paddings
  static const EdgeInsets smallTop = EdgeInsets.only(top: 4.0);
  static const EdgeInsets mediumTop = EdgeInsets.only(top: 8.0);
  static const EdgeInsets largeTop = EdgeInsets.only(top: 16.0);
  static const EdgeInsets xLargeTop = EdgeInsets.only(top: 24.0);

  // Bottom-only paddings
  static const EdgeInsets smallBottom = EdgeInsets.only(bottom: 4.0);
  static const EdgeInsets mediumBottom = EdgeInsets.only(bottom: 8.0);
  static const EdgeInsets largeBottom = EdgeInsets.only(bottom: 16.0);
  static const EdgeInsets xLargeBottom = EdgeInsets.only(bottom: 24.0);

  // All-sides paddings
  static const EdgeInsets smallAll = EdgeInsets.all(4.0);
  static const EdgeInsets mediumAll = EdgeInsets.all(8.0);
  static const EdgeInsets largeAll = EdgeInsets.all(16.0);
  static const EdgeInsets xLargeAll = EdgeInsets.all(24.0);
  static const EdgeInsets xxLargeAll = EdgeInsets.all(32.0);
}

class AppBorderRadius {
  // Standard small corner radius (e.g., buttons, small cards)
  static const BorderRadius small = BorderRadius.all(Radius.circular(8.0));

  // Medium corner radius for larger elements (e.g., modal sheets, large cards)
  static const BorderRadius medium = BorderRadius.all(Radius.circular(12.0));

  // Large corner radius for iOS-like card elements
  static const BorderRadius large = BorderRadius.all(Radius.circular(16.0));

  // Extra-large radius for modals or elements that need more rounding
  static const BorderRadius xLarge = BorderRadius.all(Radius.circular(24.0));

  // Full-rounded radius, often used for avatar/profile images or small circular elements
  static const BorderRadius full = BorderRadius.all(Radius.circular(50.0));

  // Symmetrical radius options for special cases
  static const BorderRadius topSmall = BorderRadius.vertical(top: Radius.circular(8.0));
  static const BorderRadius topMedium = BorderRadius.vertical(top: Radius.circular(12.0));
  static const BorderRadius topLarge = BorderRadius.vertical(top: Radius.circular(16.0));

  static const BorderRadius bottomSmall = BorderRadius.vertical(bottom: Radius.circular(8.0));
  static const BorderRadius bottomMedium = BorderRadius.vertical(bottom: Radius.circular(12.0));
  static const BorderRadius bottomLarge = BorderRadius.vertical(bottom: Radius.circular(16.0));
}

import 'dart:io';

import 'package:flutter/foundation.dart';

class PlatformHelper {
  static bool get isWeb => kIsWeb;

  static bool get isAndroid => !isWeb && Platform.isAndroid;

  static bool get isIos => !isWeb && Platform.isIOS;

  static bool get isDebugMode => kDebugMode;

  static bool get isReleaseMode => kReleaseMode;

  static bool get isMobileWeb => isWeb && (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android);

  static bool get isMobile => isAndroid || isIos;
}

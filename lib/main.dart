import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:ios_communication_prototype/src/helpers/logger/logger_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:ios_communication_prototype/src/app_preferences/app_preferences_controller.dart';
import 'package:ios_communication_prototype/src/app_preferences/app_preferences_service.dart';
import 'package:ios_communication_prototype/src/bloc/init.dart';
import 'package:ios_communication_prototype/src/helpers/env_helper.dart' as env_helper;
import 'package:ios_communication_prototype/src/helpers/platform_helper.dart';
import 'package:ios_communication_prototype/src/view/page/app.dart';

void main() async {
  // Display application banner in the debug console
  LoggerHelper.debugLog('''
  ███████╗██╗     ██╗   ██╗████████╗████████╗███████╗██████╗ 
  ██╔════╝██║     ██║   ██║╚══██╔══╝╚══██╔══╝██╔════╝██╔══██╗
  █████╗  ██║     ██║   ██║   ██║      ██║   █████╗  ██████╔╝
  ██╔══╝  ██║     ██║   ██║   ██║      ██║   ██╔══╝  ██╔══██╗
  ██║     ███████╗╚██████╔╝   ██║      ██║   ███████╗██║  ██║
  ╚═╝     ╚══════╝ ╚═════╝    ╚═╝      ╚═╝   ╚══════╝╚═╝  ╚═╝
  ''');

  // Set custom error handling for Flutter framework errors
  _setFlutterOnError();

  // Ensure GoRouter updates the web URL to reflect imperative API calls
  GoRouter.optionURLReflectsImperativeAPIs = true;

  // Initialize the AppPreferencesController to manage user preferences
  final appPreferencesController = AppPreferencesController(AppPreferencesService());

  // Initialize Bloc observer and storage
  await initBlocObserverAndStorage();

  // Initialize logging system
  LoggerHelper.initLoggy();

  // Load user preferences before running the app
  await appPreferencesController.loadPreferences();

  // Remove the '#' from the web URL for cleaner URLs
  usePathUrlStrategy();

  // Run the app within a guarded zone to capture uncaught errors
  runZonedGuarded<dynamic>(
    () async {
      // Start the Flutter application
      runApp(MyApp(appPreferencesController: appPreferencesController));
    },
    (error, stackTrace) {
      // Handle uncaught errors
      _reportError(error, stackTrace);
    },
  );
}

/// Sets a custom Flutter error handler to capture framework errors
void _setFlutterOnError() {
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (PlatformHelper.isDebugMode) {
      // In development mode, print error details to the console
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode, report errors to the current Zone
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    }
  };
}

/// Reports errors and stack traces to the logger and Sentry
Future<void> _reportError(dynamic error, dynamic stackTrace) async {
  LoggerHelper.errorLog('Caught error: $error');

  if (PlatformHelper.isDebugMode || env_helper.appEnv != env_helper.AppEnv.prod) {
    // In development or non-production, log the error and stack trace without sending to Sentry
    LoggerHelper.errorLog(stackTrace.toString());
    LoggerHelper.errorLog('In dev mode. Not sending report to Sentry.io.');
    return;
  }

  // In production, report the error to Sentry
  LoggerHelper.errorLog('Reporting to Sentry.io...');
  LoggerHelper.errorLog(error.toString());
  LoggerHelper.errorLog(stackTrace.toString());
}

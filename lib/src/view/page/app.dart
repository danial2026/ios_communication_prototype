import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ios_communication_prototype/src/bloc/init.dart';
import 'package:ios_communication_prototype/src/navigator/main_routes.dart';
import 'package:ios_communication_prototype/src/app_preferences/app_preferences_controller.dart';
import 'package:ios_communication_prototype/src/view/page/error/something_went_wrong_page.dart';

// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.appPreferencesController,
  });

  final AppPreferencesController appPreferencesController;

  @override
  Widget build(BuildContext context) {
    // Glue the AppPreferencesController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the AppPreferencesController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return MultiBlocProvider(
      providers: provideBlocList(),
      child: ListenableBuilder(
        listenable: appPreferencesController,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            // Providing a restorationScopeId allows the Navigator built by the
            // MaterialApp to restore the navigation stack when a user leaves and
            // returns to the app after it has been killed while running in the
            // background.
            restorationScopeId: 'app',

            // Provide the generated AppLocalizations to the MaterialApp. This
            // allows descendant Widgets to display the correct translations
            // depending on the user's locale.
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // English, no country code
              Locale('ja', ''), // Jpanese, no country code
            ],

            // Use AppLocalizations to configure the correct application title
            // depending on the user's locale.
            locale: Locale(appPreferencesController.locale, ''),

            // The appName is defined in .arb files found in the localization
            // directory.
            onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appName,

            // Define a light and dark color theme. Then, read the user's
            // preferred ThemeMode (light, dark, or system default) from the
            // AppPreferencesController to display the correct theme.
            theme: appPreferencesController.getThemeData(),
            darkTheme: appPreferencesController.getThemeDataByThemeMode(ThemeMode.dark),
            themeMode: appPreferencesController.themeMode,

            // Define a function to handle named routes in order to support
            // Flutter web url navigation and deep linking.
            // routes: BaseRouteHandler.routeConfig(),

            routerConfig: BaseRouteHandler.routeConfig(appPreferencesController: appPreferencesController),

            builder: (context, child) {
              return child ?? const SomethingWentWrongPage();
            },
          );
        },
      ),
    );
  }
}

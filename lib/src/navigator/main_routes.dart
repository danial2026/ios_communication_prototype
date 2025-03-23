import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ios_communication_prototype/src/app_preferences/app_preferences_controller.dart';
import 'package:ios_communication_prototype/src/view/common/custom_material_page.dart';
import 'package:ios_communication_prototype/src/view/page/error/something_went_wrong_page.dart';
import 'package:ios_communication_prototype/src/view/page/home/home_page.dart';
import 'package:ios_communication_prototype/src/view/page/splash_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

mixin BaseRouteHandler {
  static GoRouter routeConfig({required AppPreferencesController appPreferencesController}) {
    return GoRouter(
      observers: [],
      navigatorKey: _rootNavigatorKey,
      initialLocation: SplashPage.routeName,
      restorationScopeId: 'router',
      debugLogDiagnostics: true,
      routes: <RouteBase>[
        GoRoute(
          path: SplashPage.routeName,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPageBuilder(
              key: state.pageKey,
              child: SplashPage(appPreferencesController: appPreferencesController),
            );
          },
        ),
        GoRoute(
          path: HomePage.routeName,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPageBuilder(
              key: state.pageKey,
              child: HomePage(appPreferencesController: appPreferencesController),
            );
          },
        ),
        GoRoute(
          path: SomethingWentWrongPage.routeName,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPageBuilder(
              key: state.pageKey,
              child: const SomethingWentWrongPage(),
            );
          },
        ),
      ],
      redirect: _guard,
      onException: _onException,
    );
  }

  static Future<String?> _guard(BuildContext context, GoRouterState state) async {
    // final bool signedIn = await checkUserStatus();
    // final bool signingInFlow = state.matchedLocation == LoginPage.routeName;

    // /*
    // no need to be logged in to use to app for now
    //   // Go to /login if the user is not signed in
    //   if (!signedIn && !signingInFlow) {
    //     return LoginPage.routeName;
    //   }
    // */

    // // Go to /explore if the user is signed in and tries to go to /signin.
    // if (signedIn && signingInFlow) {
    //   return ExplorePage.routeName;
    // }

    // no redirect
    return null;
  }

  static void _onException(BuildContext context, GoRouterState state, GoRouter router) {
    router.go(SomethingWentWrongPage.routeName);
  }
}

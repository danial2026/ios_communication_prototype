import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ios_communication_prototype/src/utils/router_utils.dart';

class NavigatorController {
  static void go(BuildContext context, String path, {Object? arguments, String? pathParams, String? queryParams}) {
    final state = _getState(context);

    if (GoRouterState.of(context).fullPath == path) {
      return;
    }

    try {
      if (pathParams != null && queryParams == null && arguments == null) {
        context.go('$state${RouterUtils.checkSlash(path)}/$pathParams');
      } else if (queryParams != null && pathParams == null && arguments == null) {
        context.go('$state${RouterUtils.checkSlash(path)}?$queryParams');
      } else if (arguments != null) {
        if (pathParams != null && queryParams == null) {
          context.go('$state${RouterUtils.checkSlash(path)}/$pathParams', extra: arguments);
        } else if (queryParams != null && pathParams == null) {
          context.go('$state${RouterUtils.checkSlash(path)}?$queryParams', extra: arguments);
        } else {
          context.go('$state${RouterUtils.checkSlash(path)}', extra: arguments);
        }
      } else {
        context.go('$state${RouterUtils.checkSlash(path)}');
      }
    } catch (e) {
      print('NavigatorController Go: $e');
    }
  }

  static void goWithoutState(BuildContext context, String path, {Object? arguments, String? pathParams, String? queryParams}) {
    try {
      if (pathParams != null && queryParams == null) {
        context.go('${RouterUtils.checkSlash(path)}/$pathParams');
      } else if (queryParams != null && pathParams == null) {
        context.go('${RouterUtils.checkSlash(path)}?$queryParams');
      } else if (arguments != null) {
        context.go(RouterUtils.checkSlash(path), extra: arguments);
      } else {
        context.go(RouterUtils.checkSlash(path));
      }
    } catch (e) {
      print('NavigatorController Go: $e');
    }
  }

  static Future<T?> push<T extends Object?>(BuildContext context, String path,
      {Object? arguments, String? pathParams, String? queryParams}) async {
    String state = _getState(context);

    if (state == '/' && path.startsWith('/')) {
      state = '';
    }

    try {
      if (pathParams != null && queryParams == null && arguments == null) {
        return context.push('$state${RouterUtils.checkSlash(path)}/$pathParams');
      } else if (queryParams != null && pathParams == null && arguments == null) {
        return context.push('$state${RouterUtils.checkSlash(path)}?$queryParams');
      } else if (arguments != null) {
        if (pathParams != null && queryParams == null) {
          return context.push('$state${RouterUtils.checkSlash(path)}/$pathParams', extra: arguments);
        } else if (queryParams != null && pathParams == null) {
          return context.push('$state${RouterUtils.checkSlash(path)}?$queryParams', extra: arguments);
        } else {
          return context.push('$state${RouterUtils.checkSlash(path)}', extra: arguments);
        }
      } else {
        return context.push('$state${RouterUtils.checkSlash(path)}');
      }
    } catch (e) {
      print('NavigatorController push: $e');
      return null;
    }
  }

  static Future pushWithoutState(BuildContext context, String path, {Object? arguments, String? pathParams, String? queryParams}) async {
    if (pathParams != null && queryParams == null) {
      await context.push('${RouterUtils.checkSlash(path)}/$pathParams');
    } else if (queryParams != null && pathParams == null) {
      await context.push(
        '${RouterUtils.checkSlash(path)}?$queryParams',
      );
    } else {
      await context.push(RouterUtils.checkSlash(path), extra: arguments);
    }
  }

  static Future pushReplacementWithoutState(BuildContext context, String path,
      {Object? arguments, String? pathParams, String? queryParams}) async {
    if (pathParams != null && queryParams == null) {
      context.go('${RouterUtils.checkSlash(path)}/$pathParams');
    } else if (queryParams != null && pathParams == null) {
      context.go(
        '${RouterUtils.checkSlash(path)}?$queryParams',
      );
    } else {
      context.go(RouterUtils.checkSlash(path), extra: arguments);
    }
  }

  static Future pushBase(BuildContext context, String path, {Object? arguments, String? pathParams, String? queryParams}) async {
    final state = _getState(context);

    if (pathParams != null && queryParams == null) {
      await context.push('$state${RouterUtils.checkSlash(path)}/$pathParams');
    } else if (queryParams != null && pathParams == null) {
      await context.push(
        '$state${RouterUtils.checkSlash(path)}?$queryParams',
      );
    } else {
      await context.push('$state${RouterUtils.checkSlash(path)}', extra: arguments);
    }
  }

  static void pop(BuildContext context, [Object? arguments]) {
    context.pop(arguments);
  }

  static void popAndPushNamed(BuildContext context, String path, {Object? arguments}) {
    context.pop();
    context.replaceNamed(RouterUtils.checkSlash(path), extra: arguments);
  }

  static void popAndPushNamedWithQueryParam(BuildContext context, String path, {required Map<String, String> queryParam}) {
    context.pop();
    context.replaceNamed(RouterUtils.checkSlash(path), queryParameters: queryParam);
  }

  static String _getState(BuildContext context) {
    try {
      return GoRouterState.of(context).uri.path.toString();
    } catch (e) {
      return '/';
    }
  }
}

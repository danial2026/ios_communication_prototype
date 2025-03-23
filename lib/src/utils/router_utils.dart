import 'package:go_router/go_router.dart';

mixin RouterUtils {
  static String removeSlash(String value) {
    return value.replaceAll('/', '');
  }

  static String checkSlash(String value) {
    if (value.contains('/')) {
      return value;
    } else {
      return '/$value';
    }
  }

  static Arg getArguments<Arg>({required GoRouterState state}) {
    final extra = state.extra;
    if (extra != null) {
      return extra as Arg;
    } else {
      throw AssertionError('$Arg : Go router null path params');
    }
  }

  static Arg getExtra<Arg>({required GoRouterState state}) {
    final extra = state.extra;

    if (extra != null) {
      return extra as Arg;
    } else {
      throw AssertionError('$Arg : Go router null extra');
    }
  }

  static Arg getPathParams<Arg>({required GoRouterState state, required String key}) {
    final pathPrams = state.pathParameters;

    if (pathPrams.isNotEmpty && pathPrams[key] != null) {
      return pathPrams[key] as Arg;
    } else {
      throw AssertionError('$Arg : Go router null path params');
    }
  }

  static Arg getQueryParams<Arg>({required GoRouterState state, required String key}) {
    final queryPrams = state.uri.queryParameters;
    if (queryPrams.isNotEmpty && queryPrams[key] != null) {
      if (Arg == bool) {
        return toBoolean((queryPrams[key] as String).toString()) as Arg;
      }
      return queryPrams[key] as Arg;
    } else {
      throw AssertionError('$Arg : Go router null query params');
    }
  }

  static Arg? getQueryParamsNullable<Arg>({
    required GoRouterState state,
    required String key,
  }) {
    final queryPrams = state.uri.queryParameters;
    if (['bool', 'bool?'].contains(Arg.toString())) {
      if (queryPrams[key] == null) {
        if (Arg == bool) {
          return false as Arg;
        }
        return null;
      }
      return toBoolean((queryPrams[key] as String).toString()) as Arg;
    }
    return queryPrams[key] as Arg;
  }

  static bool toBoolean(String str) {
    return str != '0' && str != 'false' && str != '';
  }
}

import 'package:flutter/material.dart';
import 'package:gym/core/fade_page_route.dart';
import 'package:gym/ui/screens/items/items.dart';
import 'package:gym/ui/screens/login/login.dart';

enum Routes { items, login }

class _Paths {
  static const String itemsList = '/home/items';
  static const String login = '/login';

  static const Map<Routes, String> _pathMap = {
    Routes.login: _Paths.login,
    Routes.items: _Paths.itemsList
  };

  static String of(Routes route) => _pathMap[route] ?? login;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      case _Paths.login:
        return FadeRoute(page: LoginScreen());

      case _Paths.itemsList:
        return FadeRoute(page: ItemsScreen());

      default:
        return FadeRoute(page: LoginScreen());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}

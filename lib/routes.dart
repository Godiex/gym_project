import 'package:flutter/material.dart';
import 'package:gym/core/fade_page_route.dart';
import 'package:gym/ui/screens/home/home.dart';
import 'package:gym/ui/screens/items/items.dart';
import 'package:gym/ui/screens/login/login.dart';

enum Routes { login, customers, plans, metrics, items, subscription, home }

class _Paths {
  static const String login = '/login';
  static const String customers = '/customers';
  static const String plans = '/plans';
  static const String metrics = '/metrics';
  static const String items = '/items';
  static const String subscription = '/subscription';
  static const String home = '/home';

  static const Map<Routes, String> _pathMap = {
    Routes.login: _Paths.login,
    Routes.customers: _Paths.customers,
    Routes.plans: _Paths.plans,
    Routes.metrics: _Paths.metrics,
    Routes.items: _Paths.items,
    Routes.subscription: _Paths.subscription,
    Routes.home: _Paths.home
  };

  static String of(Routes route) => _pathMap[route] ?? login;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      case _Paths.login:
        return FadeRoute(page: LoginScreen());

      case _Paths.home:
        return FadeRoute(page: HomeScreen());

      case _Paths.customers:
        return FadeRoute(page: HomeScreen());

      case _Paths.metrics:
        return FadeRoute(page: HomeScreen());

      case _Paths.subscription:
        return FadeRoute(page: HomeScreen());

      case _Paths.items:
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

import 'package:flutter/material.dart';
import 'package:gym/core/fade_page_route.dart';
import 'package:gym/ui/screens/items/items.dart';

enum Routes { items, splash }

class _Paths {
  static const String itemsList = '/home/items';

  static const Map<Routes, String> _pathMap = {
    Routes.items: _Paths.itemsList
  };

  static String of(Routes route) => _pathMap[route] ?? itemsList;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      case _Paths.itemsList:
        return FadeRoute(page: ItemsScreen());

      default:
        return FadeRoute(page: ItemsScreen());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}

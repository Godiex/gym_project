import 'dart:ui';

import 'package:gym/configs/colors.dart';
import 'package:gym/routes.dart';

class MenuOption {
  const MenuOption({
    required this.name,
    required this.color,
    required this.route,
  });

  final Color color;
  final String name;
  final Routes route;
}


const List<MenuOption> menuOptions = [
  MenuOption(name: 'Clientes', color: AppColors.teal, route: Routes.customers),
  MenuOption(name: 'Planes', color: AppColors.red, route: Routes.plans),
  MenuOption(name: 'Metricas', color: AppColors.blue, route: Routes.metrics),
  MenuOption(name: 'Mi Subscripcion', color: AppColors.yellow, route: Routes.subscription),
];

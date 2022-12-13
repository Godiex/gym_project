import 'dart:ui';

import 'package:gym/configs/colors.dart';
import 'package:gym/domain/constants/type_user.dart';
import 'package:gym/routes.dart';

class MenuOption {
  const MenuOption({
    required this.name,
    required this.color,
    required this.route,
    required this.rol,
  });

  final Color color;
  final String name;
  final String rol;
  final Routes route;
}


const List<MenuOption> menuOptions = [
  MenuOption(name: 'Clientes', color: AppColors.teal, route: Routes.customers, rol: TypeUser.Admin),
  MenuOption(name: 'Planes', color: AppColors.red, route: Routes.plans, rol: TypeUser.Admin),
  MenuOption(name: 'Metricas', color: AppColors.blue, route: Routes.metrics, rol: TypeUser.Admin),
  MenuOption(name: 'Mi Subscripcion', color: AppColors.yellow, route: Routes.subscription, rol: TypeUser.Customer),
  MenuOption(name: 'Asistencia', color: AppColors.lightGreen, route: Routes.attendance, rol: TypeUser.Customer),
  MenuOption(name: 'Asistencia', color: AppColors.lightGreen, route: Routes.attendance, rol: TypeUser.Admin),
];

import 'package:flutter/material.dart';

class CustomerInfoStateProvider extends InheritedWidget {
  final AnimationController slideController;
  final AnimationController rotateController;

  const CustomerInfoStateProvider({
    Key? key,
    required this.slideController,
    required this.rotateController,
    required Widget child,
  }) : super(child: child);

  static CustomerInfoStateProvider of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<CustomerInfoStateProvider>();
    return result!;
  }

  @override
  bool updateShouldNotify(covariant CustomerInfoStateProvider oldWidget) => false;
}

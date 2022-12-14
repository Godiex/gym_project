import 'dart:math';

import 'package:flutter/material.dart' hide AnimatedSlide;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/ui/screens/customer/sections/pokemon_info/state_provider.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/images.dart';
import '../../../../../domain/entities/customer.dart';
import '../../../../../states/theme/theme_cubit.dart';
import '../../../../widgets/animated_fade.dart';
import '../../../../widgets/auto_slideup_panel.dart';
import '../../../../widgets/hero.dart';
import '../../../../widgets/main_app_bar.dart';
import '../../../../widgets/main_tab_view.dart';
import '../../../../widgets/progress.dart';
import 'package:flutter/material.dart';

part 'sections/background_decoration.dart';
part 'sections/customer_info_card.dart';
part 'sections/pokemon_info_card_about.dart';
part 'sections/pokemon_info_card_basestats.dart';
part 'sections/customer_overall_info.dart';


class CustomerInfo extends StatefulWidget {
  final Customer customer;

  const CustomerInfo({super.key, required this.customer});
  @override
  _CustomerInfoState createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _rotateController;

  @override
  void initState() {
    _slideController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _rotateController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    )..repeat();

    super.initState();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _rotateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomerInfoStateProvider(
      slideController: _slideController,
      rotateController: _rotateController,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _BackgroundDecoration(),
            _PokemonInfoCard(widget.customer),
            _CustomerOverallInfo(widget.customer)
          ],
        ),
      ),
    );
  }
}

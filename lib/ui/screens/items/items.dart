import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/configs/durations.dart';
import 'package:gym/configs/images.dart';
import 'package:gym/core/extensions/animation.dart';
import 'package:gym/states/item/item_bloc.dart';
import 'package:gym/states/item/item_selector.dart';
import 'package:gym/ui/widgets/main_app_bar.dart';
import 'package:gym/ui/widgets/pokeball_background.dart';
import 'package:gym/ui/widgets/pokemon_refresh_control.dart';
import 'package:gym/states/item/item_event.dart';
import 'package:gym/states/item/item_state.dart';
import 'package:gym/ui/modals/search_modal.dart';
import 'package:gym/ui/widgets/animated_overlay.dart';
import 'package:gym/ui/widgets/fab.dart';

import 'widgets/item_card.dart';

part 'sections/fab_menu.dart';
part 'sections/items_grid.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen();

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return PokeballBackground(
      child: Stack(
        children: [
          _ItemGrid(),
        ],
      ),
    );
  }
}

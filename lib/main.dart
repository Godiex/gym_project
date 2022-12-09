import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/app.dart';
import 'package:gym/states/item/item_bloc.dart';
import 'package:gym/states/theme/theme_cubit.dart';

import 'core/network.dart';
import 'data/repositories/gym_owner_repository.dart';
import 'data/repositories/item_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiRepositoryProvider(
      providers: [

        RepositoryProvider<NetworkManager>(
          create: (context) => NetworkManager(),
        ),

        RepositoryProvider<ItemRepository>(
          create: (context) => ItemDefaultRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ItemBloc>(
            create: (context) => ItemBloc(context.read<ItemRepository>()),
          ),

          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
          )
        ],
        child: GymApp(),
      ),
    ),
  );
}

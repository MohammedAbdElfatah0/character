import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_flutter/bussiness_logic/cubit/characters_cubit.dart';
import 'package:learn_bloc_flutter/constants/string.dart';
import 'package:learn_bloc_flutter/data/models/character_model.dart';
import 'package:learn_bloc_flutter/data/respsitory/characters_repository.dart';
import 'package:learn_bloc_flutter/data/web_services/characters_web_services.dart';
import 'package:learn_bloc_flutter/presentation/screens/characters_screen.dart';
import 'package:learn_bloc_flutter/presentation/screens/chatacters_details_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository =
        CharactersRepository(charactersWebServices: CharactersWebServices());
    charactersCubit = CharactersCubit(
      charactersRepository,
    );
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case chatactersScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => charactersCubit,
                  child: CharactersScreen(),
                ));
      case chatactersDetailsScreen:
        final character = settings.arguments as CharactersModel;
        return MaterialPageRoute(builder: (_) => ChatactersDetailsScreen(character: character,));
    }
  }
}

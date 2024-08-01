import 'package:learn_bloc_flutter/data/models/character_model.dart';
import 'package:learn_bloc_flutter/data/web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository({required this.charactersWebServices});

  Future<List<CharactersModel>> getAllCharacters() async {
    final List<CharactersModel> characters = await charactersWebServices.getAllCharacters();
    return characters;
  }
}

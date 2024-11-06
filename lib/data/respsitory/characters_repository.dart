import 'package:learn_bloc_flutter/data/models/details_character_model.dart';
import 'package:learn_bloc_flutter/data/web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository({required this.charactersWebServices});

  Future<List<DetailsCharactersModel>> getAllCharacters() async {
    final List<DetailsCharactersModel> characters =
        await charactersWebServices.getAllCharacters();
    return characters;
  }
}

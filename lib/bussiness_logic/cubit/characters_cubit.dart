import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:learn_bloc_flutter/data/models/details_character_model.dart';
import 'package:learn_bloc_flutter/data/respsitory/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit(
    this.charactersRepository,
  ) : super(CharactersInitial());

  final CharactersRepository charactersRepository;
  List<DetailsCharactersModel> characters = [];

  List<DetailsCharactersModel> getAllCharaters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters: characters));
    });
    return characters;
  }
}

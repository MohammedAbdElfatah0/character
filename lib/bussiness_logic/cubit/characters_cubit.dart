import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:learn_bloc_flutter/data/models/character_model.dart';
import 'package:learn_bloc_flutter/data/respsitory/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit(this.charactersRepository, )
      : super(CharactersInitial());

  final CharactersRepository charactersRepository;
   List<CharactersModel> characters=[];

  List<CharactersModel> getAllCharaters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters: characters));
    });
    return characters;
  }
}

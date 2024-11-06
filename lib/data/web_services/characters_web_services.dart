import 'package:dio/dio.dart';
import 'package:learn_bloc_flutter/constants/string.dart';
import 'package:learn_bloc_flutter/data/models/details_character_model.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
    dio = Dio(options);
  }

  Future<List<DetailsCharactersModel>> getAllCharacters() async {
    try {
      Response response = await dio.get('character');
      // Print the entire response data

      // Ensure response.data contains the expected structure
      if (response.data is Map<String, dynamic> &&
          response.data['results'] is List) {
        List<dynamic> data = response.data['results'];
        List<DetailsCharactersModel> characters = data
            .map((character) => DetailsCharactersModel.fromJson(
                character as Map<String, dynamic>))
            .toList();

        return characters;
      } else {
        throw Exception('Unexpected response format');
      }
    } on Exception catch (e) {
      print(e.toString());
      return [];
    }
  }
}

class DetailsCharactersModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;

  DetailsCharactersModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
  });

  factory DetailsCharactersModel.fromJson(Map<String, dynamic> json) {
    return DetailsCharactersModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      image: json['image'],
    );
  }
}

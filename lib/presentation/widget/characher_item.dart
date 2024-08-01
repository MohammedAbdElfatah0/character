import 'package:flutter/material.dart';
import 'package:learn_bloc_flutter/constants/my_colors.dart';
import 'package:learn_bloc_flutter/constants/string.dart';
import 'package:learn_bloc_flutter/data/models/character_model.dart';

class CharacherItem extends StatelessWidget {
  const CharacherItem({super.key, required this.charactersModel});

  final CharactersModel charactersModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
          color: MyColors.myWhite, borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, chatactersDetailsScreen,
            arguments: charactersModel),
        child: GridTile(
          footer: Hero(
            tag: charactersModel.id,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                charactersModel.name,
                style: const TextStyle(
                    color: MyColors.myWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    height: 1.3),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            color: MyColors.myGrey,
            child: charactersModel.image.isNotEmpty
                ? FadeInImage.assetNetwork(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: 'assets/images/Loading.gif',
                    image: charactersModel.image)
                : Image.asset('assets/images/myImage.jpg'),
          ),
        ),
      ),
    );
  }
}

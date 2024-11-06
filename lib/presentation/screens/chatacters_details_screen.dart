import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:learn_bloc_flutter/constants/my_colors.dart';
import 'package:learn_bloc_flutter/data/models/details_character_model.dart';

class ChatactersDetailsScreen extends StatelessWidget {
  const ChatactersDetailsScreen({super.key, required this.character});

  final DetailsCharactersModel character;

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600, //high
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
            tag: character.id,
            child: Image.network(
              character.image,
              fit: BoxFit.cover,
            )),
        //  centerTitle: true,
        title: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            character.name,
            style: const TextStyle(color: MyColors.myWhite),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }

  Widget buildDivider(double endIndend) {
    return Divider(
      height: 20,
      endIndent: endIndend,
      color: MyColors.myYellow,
      thickness: 3,
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 21),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('Status :', character.status),
                      buildDivider(300),
                      characterInfo('Species :', character.species),
                      buildDivider(290),
                      characterInfo('Gender :', character.gender),
                      buildDivider(295),
                      const SizedBox(
                        height: 20,
                        width: 80,
                      ),
                      SizedBox(
                        width: 250.0,
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 40.0,
                            fontFamily: 'Canterbury',
                          ),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              ScaleAnimatedText(
                                  'thinks ♥ it is ${character.gender}'),
                            ],
                            onTap: () {},
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 400,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

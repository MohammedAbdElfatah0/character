import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:learn_bloc_flutter/bussiness_logic/cubit/characters_cubit.dart';
import 'package:learn_bloc_flutter/constants/my_colors.dart';
import 'package:learn_bloc_flutter/data/models/character_model.dart';
import 'package:learn_bloc_flutter/presentation/widget/characher_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<CharactersModel> allCharacters;
  late List<CharactersModel> searchForCharacters;
  bool _isSearch = false;
  final _searchTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    allCharacters = [];
    BlocProvider.of<CharactersCubit>(context).getAllCharaters();
  }

  Widget _buildSearchfield() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
          hintText: 'find a character...',
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: MyColors.myGrey,
            fontSize: 18,
          )),
      style: const TextStyle(
        color: MyColors.myGrey,
        fontSize: 18,
      ),
      onChanged: (searchcharacter) {
        addSearchForItemToSearchList(searchcharacter);
      },
    );
  }

  void addSearchForItemToSearchList(searchcharacter) {
    searchForCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchcharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarAiction() {
    if (_isSearch) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: MyColors.myGrey,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: const Icon(
              Icons.search,
              color: MyColors.myGrey,
            ))
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearch = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearch = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, stata) {
      if (stata is CharactersLoaded) {
        allCharacters = (stata).characters;
        return buildLoadListWidget();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchTextController.text.isEmpty
          ? allCharacters.length
          : searchForCharacters.length,
      itemBuilder: (ctx, index) {
        return CharacherItem(
          charactersModel: _searchTextController.text.isEmpty
              ? allCharacters[index]
              : searchForCharacters[index],
        );
      },
    );
  }

  Widget _buildAppBar() {
    return const Text(
      'Characters',
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  Widget buildNoInternet() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/Wifi.png'),
          const SizedBox(
            height: 45,
          ),
          const Text(
            'cheak your Wifi is not connect....',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.myYellow,
          title: _isSearch ? _buildSearchfield() : _buildAppBar(),
          actions: _buildAppBarAiction(),
        ),
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            List<ConnectivityResult> connectivity,
            Widget child,
          ) {
            final bool connected =
                !connectivity.contains(ConnectivityResult.none);
            if (connected) {
              return buildBlocWidget();
            } else {
              return buildNoInternet();
            }
          },
          child: const Center(child: Text('Checking connectivity...')),
          // buildBlocWidget(),
        ));
  }
}

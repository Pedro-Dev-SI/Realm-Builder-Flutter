import 'package:client_realm_builder/Services/character_service.dart';
import 'package:client_realm_builder/components/characters_tile.dart';
import 'package:client_realm_builder/components/custom_app_bar.dart';
import 'package:client_realm_builder/models/game.dart';
import 'package:client_realm_builder/provider/characters_provider.dart';
import 'package:client_realm_builder/provider/games_provider.dart';
import 'package:flutter/material.dart';
import 'package:client_realm_builder/Services/game_service.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../models/character.dart';


class GameDetails extends StatefulWidget {

  final int gameId;

  const GameDetails({Key? key, required this.gameId}) : super(key: key);

  @override
  State<GameDetails> createState() => _GameDetailsState();
}

class _GameDetailsState extends State<GameDetails> {

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();

  List<Character>? characters;
  Game? game;

  getGame() async {
    game = await GameService.listById(widget.gameId);
    Provider.of<GamesProvider>(context, listen: false).gameDetailed = game;
    setState(() {});
  }

  getCharacter() async {
    characters = await CharacterService.listCharactersByGameId(widget.gameId);
    Provider.of<CharactersProvider>(context, listen: false).characters = characters!;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getGame();
    getCharacter();
  }

  void _showGameModal(BuildContext context) {

    final gamesProvider = Provider.of<GamesProvider>(context, listen: false);
    final gameDetailed = gamesProvider.gameDetailed;

    _titleController.text = gameDetailed.title ?? '';
    _subtitleController.text = gameDetailed.subtitle ?? '';
    _descriptionController.text = gameDetailed.description ?? '';
    _imageController.text = gameDetailed.image ?? '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Define as bordas arredondadas
      ),
      backgroundColor: const Color(0xFF8C5651), // Define a cor de fundo da modal
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Game info',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'VT323',
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }

                      if (value.trim().length < 3) {
                        return 'This field must have at least 3 characters';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: _subtitleController,
                    decoration: const InputDecoration(
                      labelText: 'Subtitle',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }

                      if (value.trim().length < 3) {
                        return 'This field must have at least 3 characters';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }

                      if (value.trim().length < 3) {
                        return 'This field must have at least 3 characters';
                      }

                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: _imageController,
                    decoration: const InputDecoration(
                      labelText: 'Image URL',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Danger Zone',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'VT323',
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Provider.of<GamesProvider>(context, listen: false).deleteGame(widget.gameId);
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Delete game',
                        style: TextStyle(
                          color: Color(0xFFF52222),
                          fontFamily: 'VT323',
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                            primary: const Color(0xFFF52222),
                            backgroundColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Color(0xFFF52222),
                              fontFamily: 'VT323',
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            final isValid = _formKey.currentState!.validate();
                            if (isValid) {
                              _formKey.currentState?.save();
                              Provider.of<GamesProvider>(context, listen: false).updateGame(
                                Game(
                                  id: widget.gameId,
                                  title: _titleController.text,
                                  subtitle: _subtitleController.text,
                                  description: _descriptionController.text,
                                  image: _imageController.text,
                                ),
                              );
                              Navigator.of(context).pop();
                            }
                          },
                          style: TextButton.styleFrom(
                            primary: const Color(0xFF23A255),
                            backgroundColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                          ),
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              color: Color(0xFF23A255),
                              fontFamily: 'VT323',
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          )
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    final gamesProvider = Provider.of<GamesProvider>(context);
    final gameDetailed = gamesProvider.gameDetailed;

    final charactersProvider = Provider.of<CharactersProvider>(context);

    _titleController.text = gameDetailed.title ?? '';
    _subtitleController.text = gameDetailed.subtitle ?? '';
    _descriptionController.text = gameDetailed.description ?? '';
    _imageController.text = gameDetailed.image ?? '';

    return Scaffold(
      backgroundColor: const Color(0xFF363636),
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15, top: 20),
            alignment: Alignment.centerLeft,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _titleController.text,
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: 'VT323',
                  fontSize: 30,
                ),
              )
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, top: 15),
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {
                _showGameModal(context);
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFF52222), // Define a cor de fundo do botão
                padding: EdgeInsets.zero, // Remove o espaçamento interno do botão
                alignment: Alignment.centerLeft, // Alinha o conteúdo do botão à esquerda
                fixedSize: const Size(180, 30),
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  'Game configurations',
                  style: TextStyle(
                    color: Colors.white, // Define a cor do texto como branco
                    fontFamily: 'VT323',
                    fontSize: 20,
                  ),
                )
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Game Description',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'VT323',
                      fontSize: 25,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      gameDetailed.description ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'VT323',
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5, top: 20),
            child: SizedBox(
              height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'Characters',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'VT323',
                            fontSize: 30,
                          ),
                        ),
                      ),
                      const SizedBox(width: 70),
                      ElevatedButton.icon(
                        onPressed: () {
                          
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF61A573),
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text('Add character', style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: 'VT323', fontSize: 20),),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Consumer<CharactersProvider>(
                      builder: (context, charactersProvider, child) {
                        return ListView.builder(
                          itemCount: charactersProvider.characters.length,
                          itemBuilder: (ctx, i) {
                            Character character = charactersProvider.characters[i];
                            return CharacterTile(character: character, charactersProvider: charactersProvider);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
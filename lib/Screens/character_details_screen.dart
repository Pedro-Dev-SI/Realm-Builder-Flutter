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
import '../routes/app_routes.dart';


class CharacterDetails extends StatefulWidget {

  final int characterId;
  final int gameId;

  const CharacterDetails({Key? key, required this.characterId, required this.gameId}) : super(key: key);

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {

  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _secondNameController = TextEditingController();
  final _raceController = TextEditingController();
  final _classTypeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();

  Character? character;

  getCharacter() async {
    character = await CharacterService.listById(widget.characterId);
    Provider.of<CharactersProvider>(context, listen: false).characterDetailed = character!;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCharacter();
  }

  void _showGameModal(BuildContext context) {

    final charactersProvider = Provider.of<CharactersProvider>(context, listen: false);
    final characterDetailed = charactersProvider.characterDetailed;

    _firstNameController.text = characterDetailed.firstName ?? '';
    _secondNameController.text = characterDetailed.secondName ?? '';
    _raceController.text = characterDetailed.race ?? '';
    _classTypeController.text = characterDetailed.classType ?? '';
    _descriptionController.text = characterDetailed.description ?? '';
    _imageController.text = characterDetailed.imageUrl ?? '';

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
            height: MediaQuery.of(context).size.height * 0.85,
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
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
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
                    controller: _secondNameController,
                    decoration: const InputDecoration(
                      labelText: 'Second Name',
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
                    controller: _raceController,
                    decoration: const InputDecoration(
                      labelText: 'Race',
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
                    controller: _classTypeController,
                    decoration: const InputDecoration(
                      labelText: 'Class Type',
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
                      Provider.of<CharactersProvider>(context, listen: false).deleteCharacter(widget.characterId);
                      Navigator.of(context).popUntil((route) => route.settings.name == AppRoutes.GAME_DETAILS);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Delete character',
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
                              Provider.of<CharactersProvider>(context, listen: false).updateCharacter(
                                Character(
                                  id: widget.characterId,
                                  firstName: _firstNameController.text, 
                                  secondName: _secondNameController.text, 
                                  race: _raceController.text, 
                                  classType: _classTypeController.text, 
                                  description: _descriptionController.text, 
                                  imageUrl: _imageController.text,
                                  game: characterDetailed.game
                                ),
                                widget.gameId
                              );
                              Navigator.of(context).popUntil((route) => route.settings.name == AppRoutes.GAME_DETAILS);
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

    final charactersProvider = Provider.of<CharactersProvider>(context, listen: false);
    final characterDetailed = charactersProvider.characterDetailed;

    _firstNameController.text = characterDetailed.firstName ?? '';
    _secondNameController.text = characterDetailed.secondName ?? '';
    _raceController.text = characterDetailed.race ?? '';
    _classTypeController.text = characterDetailed.classType ?? '';
    _descriptionController.text = characterDetailed.description ?? '';
    _imageController.text = characterDetailed.imageUrl ?? '';

    final image = character!.imageUrl.isEmpty
      ? const CircleAvatar(radius: 30, child: Icon(Icons.person))
      : CircleAvatar(
        radius: 30, 
        backgroundImage: NetworkImage(character!.imageUrl),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF23A255),
              width: 2.0
            )
          ),
        )
      );

    return Scaffold(
      backgroundColor: const Color(0xFF363636),
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, top: 20),
                child: image,
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 20),
                    alignment: Alignment.centerLeft,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${_firstNameController.text} ${_secondNameController.text}',
                        style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontFamily: 'VT323',
                          fontSize: 30,
                        ),
                      )
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5, right: 35),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      characterDetailed.race ?? '',
                      style: const TextStyle(
                        color: Color(0xFF23A255),
                        fontFamily: 'VT323',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ]
              )
            ],
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
                  'Edit Character',
                  style: TextStyle(
                    color: Colors.white, // Define a cor do texto como branco
                    fontFamily: 'VT323',
                    fontSize: 22,
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
                    'Character Description',
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
                      characterDetailed.description ?? '',
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
          )
        ],
      )
    );
  }
}
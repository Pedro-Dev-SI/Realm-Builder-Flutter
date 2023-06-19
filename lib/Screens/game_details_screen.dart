import 'package:client_realm_builder/components/custom_app_bar.dart';
import 'package:client_realm_builder/models/game.dart';
import 'package:client_realm_builder/provider/games_provider.dart';
import 'package:flutter/material.dart';
import 'package:client_realm_builder/Services/game_service.dart';
import 'package:provider/provider.dart';


class GameDetails extends StatefulWidget {

  final int gameId;

  const GameDetails({Key? key, required this.gameId}) : super(key: key);

  @override
  State<GameDetails> createState() => _GameDetailsState();
}

class _GameDetailsState extends State<GameDetails> {

  final Map<String, String> _game = {};

  getGame() async {
    final game = await GameService.listById(widget.gameId);
    _game['title'] = game.title;
    _game['subtitle'] = game.subtitle;
    _game['description'] = game.description;
    _game['image'] = game.image;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getGame();
  }

  void _showGameModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Define as bordas arredondadas
      ),
      backgroundColor: const Color(0xFF8C5651), // Define a cor de fundo da modal
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
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
                ),
                const SizedBox(height: 10),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
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
                        onPressed: () {
                          // Implementar ação do botão Save
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
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF363636),
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15, top: 20),
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
        ],
      )
    );
  }
}
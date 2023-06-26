import 'package:client_realm_builder/models/game.dart';
import 'package:client_realm_builder/provider/games_provider.dart';
import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class GameTile extends StatelessWidget {
  final Game game;
  final GamesProvider gamesProvider;

  const GameTile({Key? key, required this.game, required this.gamesProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = game.imageUrl.isEmpty
      ? const CircleAvatar(radius: 30, child: Icon(Icons.person))
      : CircleAvatar(
        radius: 30, 
        backgroundImage: NetworkImage(game.imageUrl),
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
    
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 15, right: 10),
      height: 95,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutes.GAME_DETAILS,
            arguments: game.id
          );
        },
        child: Card(
          color: const Color(0xFF8C5651),
          child: Center(
            child: ListTile(
              leading: image,
              title: Text(game.title, style: const TextStyle(color: Color(0xFFFFFFFF), fontFamily: 'VT323', fontSize: 28),),
              subtitle: Text(game.subtitle, style: const TextStyle(color: Color(0xFF000000), fontFamily: 'VT323', fontSize: 18, fontWeight: FontWeight.bold)),
              // Adicione outros widgets para exibir mais informações do jogo
            ),
          ),
        ),
      )
    );
  }
}
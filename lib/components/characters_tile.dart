import 'package:client_realm_builder/provider/characters_provider.dart';
import 'package:flutter/material.dart';

import '../models/character.dart';
import '../routes/app_routes.dart';

class CharacterTile extends StatelessWidget {
  final Character character;
  final int gameId;
  final CharactersProvider charactersProvider;

  const CharacterTile({Key? key, required this.character, required this.charactersProvider, required this.gameId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = character.image.isEmpty
      ? const CircleAvatar(radius: 30, child: Icon(Icons.person))
      : CircleAvatar(
        radius: 30, 
        backgroundImage: NetworkImage(character.image),
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
            AppRoutes.CHARACTER_DETAILS,
            arguments: [character.id, gameId]
          );
        },
        child: Card(
          color: const Color(0xFFD9D9D9),
          child: Center(
            child: ListTile(
              leading: image,
              title: Text('${character.firstName} ${character.secondName}', style: const TextStyle(color: Color(0xFF000000), fontFamily: 'VT323', fontSize: 28),),
              subtitle: Text(character.race, style: const TextStyle(color: Color(0xFF312D2D), fontFamily: 'VT323', fontSize: 18, fontWeight: FontWeight.bold)),
              // Adicione outros widgets para exibir mais informações do jogo
            ),
          ),
        ),
      )
    );
  }
}
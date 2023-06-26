import 'game.dart';

class Character {
  final int? id;
  final String firstName;
  final String secondName;
  final String race;
  final String classType;
  final String description;
  final String imageUrl;
  final Game? game;

  Character({
    this.id,
    required this.firstName,
    required this.secondName,
    required this.race,
    required this.classType,
    required this.description,
    required this.imageUrl,
    this.game
  });

  factory Character.fromMap(Map gameMap) {
    return Character(
      id: gameMap['id'],
      firstName: gameMap['firstName'],
      secondName: gameMap['secondName'],
      race: gameMap['race'],
      classType: gameMap['classType'],
      description: gameMap['description'],
      imageUrl: gameMap['imageUrl'],
      game: gameMap['game'] != null ? Game.fromMap(gameMap['game']) : null
    );
  }
}
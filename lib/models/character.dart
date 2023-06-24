import 'game.dart';

class Character {
  final int? id;
  final String firstName;
  final String secondName;
  final String race;
  final String classification;
  final String description;
  final String image;
  final Game? game;

  Character({
    this.id,
    required this.firstName,
    required this.secondName,
    required this.race,
    required this.classification,
    required this.description,
    required this.image,
    this.game
  });

  factory Character.fromMap(Map gameMap) {
    return Character(
      id: gameMap['id'],
      firstName: gameMap['firstName'],
      secondName: gameMap['secondName'],
      race: gameMap['race'],
      classification: gameMap['classification'],
      description: gameMap['description'],
      image: gameMap['image'],
      game: gameMap['game'] != null ? Game.fromMap(gameMap['game']) : null
    );
  }
}
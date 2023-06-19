class Game {
  final int? id;
  final String title;
  final String subtitle;
  final String description;
  final String image;

  Game({
    this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.image,
  });

  factory Game.fromMap(Map gameMap) {
    return Game(
      id: gameMap['id'],
      title: gameMap['title'],
      subtitle: gameMap['subtitle'],
      description: gameMap['description'],
      image: gameMap['image'],
    );
  }
}
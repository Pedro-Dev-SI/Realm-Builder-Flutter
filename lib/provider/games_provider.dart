import 'package:client_realm_builder/Services/game_service.dart';
import 'package:flutter/material.dart';

import '../models/game.dart';

class GamesProvider with ChangeNotifier {
  List<Game> games = [];

  void addGame(Game game) async {
    Game gameAdded = await GameService.addGame(game);
    games.add(gameAdded);
    notifyListeners();
  }

  void deleteGame(int gameId) async {
    games.removeWhere((g) => g.id == gameId);
    await GameService.deleteGame(gameId);
    notifyListeners();
  }
}
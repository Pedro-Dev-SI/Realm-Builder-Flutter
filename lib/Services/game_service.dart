import 'dart:convert';

import 'package:client_realm_builder/models/game.dart';
import 'package:http/http.dart' as http;
import 'globals.dart';

class GameService {

  static Future<List<Game>> listAllGames() async {
    try {
      final response = await http.get(Uri.parse("$baseGameURL/list"));
      List responseList = jsonDecode(utf8.decode(response.bodyBytes));
      List<Game> games = [];
      for (Map gameMap in responseList) {
        Game game = Game.fromMap(gameMap);
        games.add(game);
      }
      return games;
    } catch (e) {
      throw Exception("Failed to load games");
    }
  }

  static Future<Game> addGame(Game game) async {
    Map data = {
      "title": game.title,
      "subtitle": game.subtitle,
      "description": game.description,
      "image": game.image,
    };
    var body = json.encode(data);
    var url = Uri.parse('$baseGameURL/create');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body
    );
    Map responseMap = jsonDecode(utf8.decode(response.bodyBytes));
    Game addedGame = Game.fromMap(responseMap);
    return addedGame;
  }

  static Future<Game> listById(int id) async {
    try {
      final response = await http.get(Uri.parse("$baseGameURL/$id"));
      Map responseMap = jsonDecode(utf8.decode(response.bodyBytes));
      Game game = Game.fromMap(responseMap);
      return game;
    } catch (e) {
      throw Exception("Failed to load game");
    }
  }

  static Future<http.Response> deleteGame(int? id) async {
    var url = Uri.parse('$baseGameURL/remove/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    return response;
  }
}
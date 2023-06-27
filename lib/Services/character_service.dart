import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:client_realm_builder/models/character.dart';
import 'globals.dart';
class CharacterService {
  static Future<List<Character>> listCharactersByGameId(int id) async {
    try {
      final response = await http.get(Uri.parse("$baseCharacterURL/list/$id"));
      List responseList = jsonDecode(utf8.decode(response.bodyBytes));
      List<Character> characters = [];
      for (Map characterMap in responseList) {
        Character character = Character.fromMap(characterMap);
        characters.add(character);
      }
      return characters;
    } catch (e) {
      throw Exception("Failed to load characters");
    }
  }

  static Future<Character> addCharacter(Character character, int gameId) async {
    Map data = {
      "firstName": character.firstName,
      "secondName": character.secondName,
      "race": character.race,
      "classType": character.classType,
      "description": character.description,
      "imageUrl": character.imageUrl,
    };
    var body = json.encode(data);
    var url = Uri.parse('$baseCharacterURL/create/$gameId');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body
    );
    Map responseMap = jsonDecode(utf8.decode(response.bodyBytes));
    Character addedGame = Character.fromMap(responseMap);
    return addedGame;
  }

  static Future<Character> updateCharacter(Character character, int gameId) async {
    Map data = {
      "id": character.id,
      "firstName": character.firstName,
      "secondName": character.secondName,
      "race": character.race,
      "classType": character.classType,
      "description": character.description,
      "imageUrl": character.imageUrl,
    };
    var body = json.encode(data);
    var url = Uri.parse('$baseCharacterURL/$gameId');
    http.Response response = await http.put(
      url,
      headers: headers,
      body: body
    );
    Map responseMap = jsonDecode(utf8.decode(response.bodyBytes));
    Character updatedGame = Character.fromMap(responseMap);
    return updatedGame;
  }

  static Future<Character> listById(int id) async {
    try {
      final response = await http.get(Uri.parse("$baseCharacterURL/$id"));
      Map responseMap = jsonDecode(utf8.decode(response.bodyBytes));
      Character character = Character.fromMap(responseMap);
      return character;
    } catch (e) {
      throw Exception("Failed to load character");
    }
  }

  static Future<http.Response> deleteCharacter(int? id) async {
    var url = Uri.parse('$baseCharacterURL/remove/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    return response;
  }
}
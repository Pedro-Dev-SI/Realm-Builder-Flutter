import 'package:client_realm_builder/Services/character_service.dart';
import 'package:flutter/material.dart';
import '../models/character.dart';

class CharactersProvider with ChangeNotifier {
  List<Character> characters = [];
  dynamic characterDetailed;

  void addCharacter(Character character, int gameId) async {
    Character characterAdded  = await CharacterService.addCharacter(character, gameId);
    characters.add(characterAdded);
    notifyListeners();
  }

  void updateCharacter(Character character, int gameId) async {
    await CharacterService.updateCharacter(character, gameId);
    characters.removeWhere((c) => c.id == character.id);
    characters.add(character);
    characterDetailed = character;
    notifyListeners();
  }

  void deleteCharacter(int characterId) async {
    characters.removeWhere((g) => g.id == characterId);
    await CharacterService.deleteCharacter(characterId);
    notifyListeners();
  }
}
import 'package:client_realm_builder/Services/character_service.dart';
import 'package:flutter/material.dart';
import '../models/character.dart';

class CharactersProvider with ChangeNotifier {
  List<Character> characters = [];

  dynamic characterDetailed;

  void addCharacter(Character character) async {
    Character characterAdded  = await CharacterService.addCharacter(character);
    characters.add(characterAdded);
    notifyListeners();
  }

  void updateCharacter(Character character) async {
    await CharacterService.updateCharacter(character);
    characters.removeWhere((g) => g.id == character.id);
    characters.add(character);
    characterDetailed = character;
    notifyListeners();
  }

  void deleteGame(int characterId) async {
    characters.removeWhere((g) => g.id == characterId);
    await CharacterService.deleteCharacter(characterId);
    notifyListeners();
  }
}
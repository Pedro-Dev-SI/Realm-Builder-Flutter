import 'package:client_realm_builder/Services/game_service.dart';
import 'package:client_realm_builder/components/custom_app_bar.dart';
import 'package:client_realm_builder/components/game_tile.dart';
import 'package:client_realm_builder/provider/games_provider.dart';
import 'package:client_realm_builder/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/game.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
  
}

class _HomeScreenState extends State<HomeScreen> {

  List<Game>? games;

  getGames() async {
    games = await GameService.listAllGames();
    Provider.of<GamesProvider>(context, listen: false).games = games!;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF363636),
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15, top: 20),
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.NEW_GAME);
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF61A573),
              ),
              icon: const Icon(Icons.add),
              label: const Text('Add new game', style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: 'VT323', fontSize: 20),),
            )
          ),
          Expanded(
            child: Consumer<GamesProvider>(
              builder: (context, gamesProvider, child) {
                return ListView.builder(
                  itemCount: gamesProvider.games.length,
                  itemBuilder: (ctx, i) {
                    Game game = gamesProvider.games[i];
                    return GameTile(game: game, gamesProvider: gamesProvider);
                  },
                );
              }
            )
          )
        ]
      )
    );
  }
}
import 'package:client_realm_builder/Screens/game_details_screen.dart';
import 'package:client_realm_builder/Screens/new_game.dart';
import 'package:client_realm_builder/Screens/home_screen.dart';
import 'package:client_realm_builder/provider/games_provider.dart';
import 'package:client_realm_builder/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => GamesProvider()
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.HOME_SCREEN: (_) => const HomeScreen(),
          AppRoutes.NEW_GAME: (_) => const NewGame(),
          AppRoutes.GAME_DETAILS: (context) {
            final gameId = ModalRoute.of(context)!.settings.arguments as int;
            return GameDetails(gameId: gameId);
          },
        },
      )
    );
  }
}


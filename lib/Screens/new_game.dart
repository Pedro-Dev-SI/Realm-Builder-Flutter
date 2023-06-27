import 'package:client_realm_builder/Services/game_service.dart';
import 'package:client_realm_builder/components/custom_app_bar.dart';
import 'package:client_realm_builder/models/game.dart';
import 'package:client_realm_builder/provider/games_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewGame extends StatefulWidget {

  const NewGame({Key? key}) : super(key: key);

  @override
  _NewGameState createState() => _NewGameState();

}

class _NewGameState extends State<NewGame> {

  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF363636),
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'New Game',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'VT323',
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  }

                  if (value.trim().length < 3) {
                    return 'This field must have at least 3 characters';
                  }

                  return null;
                },
                onSaved: (value) => _formData['title'] = value!,
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Subtitle',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  }

                  if (value.trim().length < 3) {
                    return 'This field must have at least 3 characters';
                  }

                  return null;
                },
                onSaved: (value) => _formData['subtitle'] = value!,
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title is required';
                  }

                  if (value.trim().length < 3) {
                    return 'Title must have at least 3 characters';
                  }

                  return null;
                },
                onSaved: (value) => _formData['description'] = value!,
                maxLines: 4,
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                onSaved: (value) => _formData['imageUrl'] = value!,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  final isValid = _form.currentState?.validate() ?? false;
                  if (isValid) {
                    _form.currentState?.save();
                    Provider.of<GamesProvider>(context, listen: false).addGame(
                      Game(
                        title: _formData['title']!,
                        subtitle: _formData['subtitle']!,
                        description: _formData['description']!,
                        imageUrl: _formData['imageUrl']!,
                      ),
                    );
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF23A255),
                  padding: EdgeInsets.zero,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'VT323',
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }  
}

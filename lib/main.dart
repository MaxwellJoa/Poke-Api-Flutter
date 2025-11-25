import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapi/pages/home_screen.dart';
import 'package:pokeapi/repositories/pokemon_repository.dart';
import 'package:pokeapi/services/api_service.dart';
import 'blocs/main_page_blocs/mainpage_block.dart';
import 'blocs/main_page_blocs/mainpage_event.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MainPageBloc(
      PokemonRepository(PokemonService()),
    )..add(FetchPokemons()),
    child: MaterialApp(
    home: HomeScreen(),
    ),
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();
}

import 'package:flutter/foundation.dart';
import 'package:pokeapi/models/pokemon_model.dart';

@immutable
abstract class MainPageState {}

class MainPageInitial extends MainPageState {}

class MainPageLoading extends MainPageState {}

class MainPageLoaded extends MainPageState {
  final List<PokemonModel> pokemons;
  MainPageLoaded(this.pokemons);
}

class MainPageError extends MainPageState {
}

import '../../models/pokemon_species.dart';

abstract class PokemonDetailState {}

class PokemonDetailInitial extends PokemonDetailState {}

class PokemonDetailLoading extends PokemonDetailState {}

class PokemonDetailLoaded extends PokemonDetailState {
  final PokemonSpeciesModel species;
  PokemonDetailLoaded(this.species);
}

class PokemonDetailError extends PokemonDetailState {}

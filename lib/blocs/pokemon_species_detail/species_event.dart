abstract class PokemonDetailEvent {}

class FetchPokemonSpecies extends PokemonDetailEvent {
  final int id;
  FetchPokemonSpecies(this.id);
}

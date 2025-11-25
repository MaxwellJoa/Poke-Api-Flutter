

abstract class MainPageEvent {}

class FetchPokemons extends MainPageEvent {}

class FetchMorePokemons extends MainPageEvent {}

class SearchPokemonByName extends MainPageEvent {
  final String name;
  SearchPokemonByName(this.name);
}

class ClearSearch extends MainPageEvent {}



import '../services/api_service.dart';

class PokemonSearchRepository {
  final PokemonService service;
  PokemonSearchRepository(this.service);


  Future<Map<String, dynamic>> fetchPokemonByName(String name) {
    return service.getPokemonByName(name);
  }
}
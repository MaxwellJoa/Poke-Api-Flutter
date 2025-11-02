import '../models/pokemon_model.dart';
import '../services/api_service.dart';

class PokemonRepository {
  final PokemonService service;
  PokemonRepository(this.service);

  Future<List<PokemonModel>> fetchPokemonList({int limit = 20, int offset = 0}) async {

    final data = await service.getPokemonList(limit: limit, offset: offset);

    final List results = data['results'];

    List<PokemonModel> pokemons = [];

    for (var item in results) {
      final details = await service.getPokemonDetails(item['url']);
      pokemons.add(PokemonModel.fromJson(details));
    }

    return pokemons;
  }
}

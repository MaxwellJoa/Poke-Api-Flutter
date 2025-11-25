import '../models/pokemon_species.dart';
import '../services/api_service.dart';


class PokemonSpeciesRepository {
  final PokemonService service;

  PokemonSpeciesRepository(this.service);

  Future<PokemonSpeciesModel> fetchSpecies(int id) async {
    final data = await service.getPokemonSpecies(id);
    return PokemonSpeciesModel.fromJson(data);
  }
}

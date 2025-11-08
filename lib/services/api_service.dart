import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonService {
  final String baseUrl = 'https://pokeapi.co/api/v2';
  
  // Cache para evitar llamadas repetidas
  final Map<String, dynamic> _cache = {};

  Future<Map<String, dynamic>> getPokemonList({int limit = 20, int offset = 0}) async {
    final cacheKey = 'pokemon_list_${limit}_$offset';
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey];
    }

    final response = await http.get(
      Uri.parse('$baseUrl/pokemon?limit=$limit&offset=$offset')
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _cache[cacheKey] = data;
      return data;
    } else {
      throw Exception('Error al obtener la lista de Pokémon');
    }
  }

  Future<Map<String, dynamic>> getPokemonDetails(int id) async {
    final cacheKey = 'pokemon_details_$id';
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey];
    }

    final response = await http.get(Uri.parse('$baseUrl/pokemon/$id'));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _cache[cacheKey] = data;
      return data;
    } else {
      throw Exception('Error al obtener detalles del Pokémon');
    }
  }

  Future<Map<String, dynamic>> getPokemonSpecies(int id) async {
    final cacheKey = 'pokemon_species_$id';
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey];
    }

    final response = await http.get(Uri.parse('$baseUrl/pokemon-species/$id'));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _cache[cacheKey] = data;
      return data;
    } else {
      throw Exception('Error al obtener especie del Pokémon');
    }
  }

  Future<Map<String, dynamic>> getPokemonByName(String name) async {
    final cacheKey = 'pokemon_name_$name';
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey];
    }

    final response = await http.get(Uri.parse('$baseUrl/pokemon/${name.toLowerCase()}'));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _cache[cacheKey] = data;
      return data;
    } else {
      throw Exception('Error al obtener Pokémon por nombre');
    }
  }

  Future<Map<String, dynamic>> getTypeDetails(int typeId) async {
    final cacheKey = 'type_$typeId';
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey];
    }

    final response = await http.get(Uri.parse('$baseUrl/type/$typeId'));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _cache[cacheKey] = data;
      return data;
    } else {
      throw Exception('Error al obtener detalles del tipo');
    }
  }

  Future<Map<String, dynamic>> getAbilityDetails(int abilityId) async {
    final cacheKey = 'ability_$abilityId';
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey];
    }

    final response = await http.get(Uri.parse('$baseUrl/ability/$abilityId'));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _cache[cacheKey] = data;
      return data;
    } else {
      throw Exception('Error al obtener detalles de la habilidad');
    }
  }

  // Método para obtener todos los datos de un Pokémon en una sola estructura
  Future<Map<String, dynamic>> getCompletePokemonData(int id) async {
    try {
      final pokemonData = await getPokemonDetails(id);
      final speciesData = await getPokemonSpecies(id);
      
      // Procesar y combinar los datos
      return {
        'id': pokemonData['id'],
        'name': _capitalizeName(pokemonData['name']),
        'types': _extractTypes(pokemonData),
        'stats': _extractStats(pokemonData),
        'abilities': _extractAbilities(pokemonData),
        'sprites': _extractSprites(pokemonData),
        'height': pokemonData['height'],
        'weight': pokemonData['weight'],
        'description': _extractDescription(speciesData),
        'evolution_chain': speciesData['evolution_chain']['url'],
        'habitat': speciesData['habitat']?['name'],
        'generation': speciesData['generation']?['name'],
      };
    } catch (e) {
      throw Exception('Error al obtener datos completos del Pokémon: $e');
    }
  }

  // Métodos auxiliares para procesar datos
  String _capitalizeName(String name) {
    return name[0].toUpperCase() + name.substring(1);
  }

  List<String> _extractTypes(Map<String, dynamic> pokemonData) {
    return (pokemonData['types'] as List)
        .map((type) => type['type']['name'] as String)
        .toList();
  }

  Map<String, dynamic> _extractStats(Map<String, dynamic> pokemonData) {
    final stats = <String, dynamic>{};
    for (var stat in pokemonData['stats']) {
      stats[stat['stat']['name']] = stat['base_stat'];
    }
    return stats;
  }

  List<String> _extractAbilities(Map<String, dynamic> pokemonData) {
    return (pokemonData['abilities'] as List)
        .map((ability) => ability['ability']['name'] as String)
        .toList();
  }

  Map<String, dynamic> _extractSprites(Map<String, dynamic> pokemonData) {
    final sprites = pokemonData['sprites'];
    return {
      'front_default': sprites['front_default'],
      'front_shiny': sprites['front_shiny'],
      'back_default': sprites['back_default'],
      'back_shiny': sprites['back_shiny'],
      'official_artwork': sprites['other']['official-artwork']['front_default'],
    };
  }

  String _extractDescription(Map<String, dynamic> speciesData) {
    final entries = speciesData['flavor_text_entries'] as List;
    final englishEntry = entries.firstWhere(
      (entry) => entry['language']['name'] == 'en',
      orElse: () => entries.isNotEmpty ? entries.first : {'flavor_text': 'No description available'}
    );
    return englishEntry['flavor_text'].toString().replaceAll('\n', ' ');
  }

  // Limpiar cache si es necesario
  void clearCache() {
    _cache.clear();
  }

  // Obtener evolución chain
  Future<Map<String, dynamic>> getEvolutionChain(String url) async {
    if (_cache.containsKey(url)) {
      return _cache[url];
    }

    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _cache[url] = data;
      return data;
    } else {
      throw Exception('Error al obtener cadena de evolución');
    }
  }
}

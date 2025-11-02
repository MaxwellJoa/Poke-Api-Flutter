import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonService {
  final String baseUrl = 'https://pokeapi.co/api/v2/pokemon?limit=20';

  Future<Map<String, dynamic>> getPokemonList({int limit = 20, int offset = 0}) async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=$limit&offset=$offset'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener Pokémon');
    }
  }

  Future<Map<String, dynamic>> getPokemonDetails(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener detalles del Pokémon');
    }
  }



}



class PokemonModel {
  final int id;
  final String name;
  final String sprite;
  final int height;
  final int weight;
  final int hp;
  final int attack;
  final int defense;
  final int speed;
  final List<String> types;

  PokemonModel({
    required this.id,
    required this.name,
    required this.sprite,
    required this.height,
    required this.weight,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.speed,
    required this.types,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'unknown',
      sprite: json['sprites']['front_default'] ?? '',
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      hp: json['stats'][0]['base_stat'] ?? 0,
      attack: json['stats'][1]['base_stat'] ?? 0,
      defense: json['stats'][2]['base_stat'] ?? 0,
      speed: json['stats'][5]['base_stat'] ?? 0,
      types: (json['types'] as List)
          .map((e) => e['type']['name'].toString())
          .toList(),
    );
  }
}

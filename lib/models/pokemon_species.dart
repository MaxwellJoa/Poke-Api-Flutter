class PokemonSpeciesModel {
  final String name;
  final String color;
  final String habitat;
  final int genderRate;
  final bool isLegendary;
  final bool isMythical;
  final int captureRate;
  final int baseHappiness;
  final String? description;
  final String genera;
  final String evolutionChainUrl;

  PokemonSpeciesModel({
    required this.name,
    required this.color,
    required this.habitat,
    required this.genderRate,
    required this.isLegendary,
    required this.isMythical,
    required this.captureRate,
    required this.baseHappiness,
    required this.description,
    required this.genera,
    required this.evolutionChainUrl,
  });

  factory PokemonSpeciesModel.fromJson(Map<String, dynamic> json) {

    final flavorEntries = json['flavor_text_entries'] as List;
    final englishFlavor = flavorEntries.firstWhere(
          (entry) => entry['language']['name'] == 'en',
      orElse: () => null,
    );

    final generaList = json['genera'] as List;
    final englishGenera = generaList.firstWhere(
          (entry) => entry['language']['name'] == 'en',
      orElse: () => null,
    );

    return PokemonSpeciesModel(
      name: json['name'] ?? '',
      color: json['color']?['name'] ?? 'unknown',
      habitat: json['habitat']?['name'] ?? 'unknown',
      genderRate: json['gender_rate'] ?? 0,
      isLegendary: json['is_legendary'] ?? false,
      isMythical: json['is_mythical'] ?? false,
      captureRate: json['capture_rate'] ?? 0,
      baseHappiness: json['base_happiness'] ?? 0,
      description: englishFlavor?['flavor_text']?.replaceAll('\n', ' ')?.replaceAll('\f', ' '),
      genera: englishGenera?['genus'] ?? '',
      evolutionChainUrl: json['evolution_chain']?['url'] ?? '',
    );
  }
}

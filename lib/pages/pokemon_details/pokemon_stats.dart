import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/pokemon_model.dart';
import '../../models/pokemon_species.dart';
import '../../widgets/statBar.dart';

class PokemonStats extends StatefulWidget {
  final PokemonModel pokemon;
  final PokemonSpeciesModel species;

  const PokemonStats({super.key, required this.pokemon, required this.species});

  @override
  State<PokemonStats> createState() => _PokemonStatsState();
}

class _PokemonStatsState extends State<PokemonStats> {
  int sumStat() {
    return widget.pokemon.hp +
        widget.pokemon.attack +
        widget.pokemon.defense +
        widget.pokemon.speed +
        widget.pokemon.special_attack +
        widget.pokemon.special_defense;
  }

  late int total;

  @override
  void initState() {
    super.initState();
    total = sumStat();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
      width: screenSize.width,
      height: screenSize.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenSize.height * 0.03),

            StatBar(
              screenSize: screenSize,
              pokemon: widget.pokemon,
              statValue: widget.pokemon.hp * 2,
              stat: "HP",
              color: Colors.red,
              statLeft: widget.pokemon.hp,
            ),

            SizedBox(height: screenSize.height * 0.02),

            StatBar(
              screenSize: screenSize,
              pokemon: widget.pokemon,
              statValue: widget.pokemon.attack * 2,
              stat: "ATTACK",
              color: Colors.blue,
              statLeft: widget.pokemon.attack,
            ),

            SizedBox(height: screenSize.height * 0.02),

            StatBar(
              screenSize: screenSize,
              pokemon: widget.pokemon,
              statValue: widget.pokemon.defense * 2,
              stat: "DEFENSE",
              color: Colors.pink,
              statLeft: widget.pokemon.defense,
            ),

            SizedBox(height: screenSize.height * 0.02),

            StatBar(
              screenSize: screenSize,
              pokemon: widget.pokemon,
              statValue: widget.pokemon.speed * 2,
              stat: "SPEED",
              color: Colors.green,
              statLeft: widget.pokemon.speed,
            ),

            SizedBox(height: screenSize.height * 0.02),

            StatBar(
              screenSize: screenSize,
              pokemon: widget.pokemon,
              stat: "SP. ATTACK",
              statLeft: widget.pokemon.special_attack,
              statValue: widget.pokemon.special_attack * 2,
              color: Colors.purple,
            ),

            SizedBox(height: screenSize.height * 0.02),

            StatBar(
              screenSize: screenSize,
              pokemon: widget.pokemon,
              stat: 'SP. DEFENSE',
              statLeft: widget.pokemon.special_defense,
              statValue: widget.pokemon.special_defense * 2,
              color: Colors.blueAccent,
            ),

            SizedBox(height: screenSize.height * 0.02),

            StatBar(
              screenSize: screenSize,
              pokemon: widget.pokemon,
              stat: "TOTAL",
              statLeft: total,
              statValue: (total / 2).floor(),
              color: Colors.deepOrange,
            ),

            SizedBox(height: screenSize.height * 0.03),

            Text(
              "Description",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: screenSize.height * 0.03),

            Text(
              widget.species.description.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

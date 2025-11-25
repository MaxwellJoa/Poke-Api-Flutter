import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi/models/pokemon_species.dart';
import 'package:pokeapi/pages/pokemon_details.dart';

import '../../models/pokemon_model.dart';

class PokemonAbout extends StatefulWidget {
  final PokemonModel pokemon;
  final PokemonSpeciesModel species;
  const PokemonAbout({super.key, required this.pokemon, required this.species});

  @override
  State<PokemonAbout> createState() => _PokemonAboutState();
}



class _PokemonAboutState extends State<PokemonAbout> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;


    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
      width: screenSize.width,
      height: screenSize.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: screenSize.height * 0.03),

            AboutInfo(info: "Height", value: widget.pokemon.height.toString()),
            SizedBox(height: screenSize.height * 0.03),
            AboutInfo(info: "Weight", value: '${widget.pokemon.weight.toString()} LBS'),
            SizedBox(height: screenSize.height * 0.03),
            AboutInfo(info: "Habilites", value: "${capitalizeClean(widget.pokemon.abilities.first)}, ${capitalizeClean(widget.pokemon.abilities.last)}".replaceAll('-', ' ')),
            SizedBox(height: screenSize.height * 0.03),
            Text("Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: screenSize.height * 0.03),
            AboutInfo(info: "Habitat", value: capitalizeClean('${widget.species.habitat}.'.replaceAll('-', ' '))),
            SizedBox(height: screenSize.height * 0.03),
            AboutInfo(info: "Color", value: capitalizeClean(widget.species.color.replaceAll('-', ' '))),
            SizedBox(height: screenSize.height * 0.03),
            AboutInfo(info: "Type", value: widget.species.genera)

          ],
        ),
      ),
    );
  }
}

class AboutInfo extends StatelessWidget {
  const AboutInfo({
    super.key,
    required this.info,
    required this.value
  });

  final String info;
  final String value;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(info, style: TextStyle(color: Colors.grey.shade500, fontSize: 15, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../models/pokemon_model.dart';
import '../widgets/const.dart';
import '../widgets/statBar.dart';
import '../widgets/type_container.dart';

class PokemonDetailPage extends StatelessWidget {
  final PokemonModel pokemon;

  const PokemonDetailPage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            ColorType.typeColors[pokemon.types.first] ?? Colors.grey,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 20),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: screenSize.width,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.network(
                    pokemon.sprite,
                    fit: BoxFit.contain,
                    height: screenSize.height * 0.20,
                  ),
                  Text(
                    pokemon.name,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    color: Colors.grey,
                    spreadRadius: 5,
                    blurRadius: 7,
                  ),
                ],
                color: ColorType.typeColors[pokemon.types.first] ?? Colors.grey,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: screenSize.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenSize.width * 0.20,
                      height: screenSize.height * 0.05,
                      child: TypeContainer(
                        tipoName: pokemon.types.first,
                        tipoColor:
                        ColorType.typeColors[pokemon.types.first] ?? Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.20,
                      height: screenSize.height * 0.05,
                      child: TypeContainer(
                        tipoName: pokemon.types.last,
                        tipoColor: ColorType.typeColors[pokemon.types.last] ?? Colors.grey,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenSize.height * 0.03),

                Container(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  width: screenSize.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text("Height", style: AppTextStyles.bold20.copyWith(color: Colors.grey.shade700)),
                          Text(pokemon.height.toString(), style: AppTextStyles.bold20.copyWith(color: Colors.grey.shade700)),
                        ],
                      ),

                      Column(
                        children: [
                          Text("Weight", style: AppTextStyles.bold20.copyWith(color: Colors.grey.shade700)),
                          Text(pokemon.weight.toString(), style: AppTextStyles.bold20.copyWith(color: Colors.grey.shade700)),
                        ],
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    SizedBox(height: screenSize.height * 0.03),

                    Text("Performance", style: AppTextStyles.bold20.copyWith(color: Colors.grey.shade700)),

                    StatBar(screenSize: screenSize, pokemon: pokemon, statValue: pokemon.hp, stat: "HP",color: Colors.red,),

                    SizedBox(height: screenSize.height * 0.03),

                    StatBar(screenSize: screenSize, pokemon: pokemon, statValue: pokemon.attack, stat: "ATTACK", color: Colors.blue,),

                    SizedBox(height: screenSize.height * 0.03),

                    StatBar(screenSize: screenSize, pokemon: pokemon, statValue: pokemon.defense, stat: "DEFENSE", color: Colors.pink,),

                    SizedBox(height: screenSize.height * 0.03),

                    StatBar(screenSize: screenSize, pokemon: pokemon, statValue: pokemon.speed, stat: "SPEED", color: Colors.green,),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}



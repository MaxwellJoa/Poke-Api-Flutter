import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/pokemon_model.dart';

class StatBar extends StatelessWidget {
  const StatBar({
    super.key,
    required this.screenSize,
    required this.pokemon,
    required this.stat,
    required this.statValue,
    required this.color,
  });

  final Size screenSize;
  final PokemonModel pokemon;
  final String stat;
  final int statValue;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(stat, style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey.shade700, fontSize: 20, fontWeight: FontWeight.bold),),
        SizedBox(height: screenSize.height * 0.01,),
        SizedBox(
            width: screenSize.width * 0.65,
            height: screenSize.height * 0.03,
            child: Stack(
              children: [
                SizedBox(
                  width: screenSize.width * 0.65,
                  height: screenSize.height * 0.03,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: statValue / 300,
                      color: color,
                      backgroundColor: Colors.grey.shade300,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Text('${statValue} / 300',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            )
        ),
      ],
    );
  }
}
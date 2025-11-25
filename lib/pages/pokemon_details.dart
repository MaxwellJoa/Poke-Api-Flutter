import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapi/pages/pokemon_details/pokemon_about.dart';
import 'package:pokeapi/pages/pokemon_details/pokemon_stats.dart';
import '../blocs/pokemon_species_detail/species_block.dart';
import '../blocs/pokemon_species_detail/species_event.dart';
import '../blocs/pokemon_species_detail/species_state.dart';
import '../models/pokemon_model.dart';
import '../repositories/pokemon_species_repository.dart';
import '../services/api_service.dart';
import '../widgets/const.dart';

class PokemonDetailPage extends StatelessWidget {
  final PokemonModel pokemon;

  const PokemonDetailPage({super.key, required this.pokemon});



  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),

      body: Stack(
        children: [
          Container(
            width: screenSize.width,
            height: screenSize.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  FadeColor.typeColors[pokemon.types.first] ?? Colors.grey,
                  ColorType.typeColors[pokemon.types.first] ?? Colors.grey,
                ],
              ),
            ),
          ),

          Positioned(
            top: screenSize.height * 0.10,
            left: screenSize.width * 0.15,
            child: Pokebal(pokemon, screenSize),
          ),


      Column(
        children: [
          Expanded(flex: 2, child: SizedBox()),

          Expanded(
            flex: 3,
            child: BlocProvider(
              create: (_) => PokemonDetailBloc(
                PokemonSpeciesRepository(PokemonService()),
              )..add(FetchPokemonSpecies(pokemon.id)),
              child: Container(
                padding: EdgeInsets.only(top: 45),
                width: screenSize.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),

                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [

                      TabBar(
                        labelColor: Colors.black,
                        indicatorColor: ColorType.typeColors[pokemon.types.first],
                        dividerColor: Colors.transparent,
                        tabs: const [
                          Tab(text: "About"),
                          Tab(text: "Stats"),
                          Tab(text: "Items"),
                        ],
                      ),

                      Expanded(
                        child: BlocBuilder<PokemonDetailBloc, PokemonDetailState>(
                          builder: (context, state) {
                            if (state is PokemonDetailLoading) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (state is PokemonDetailError) {
                              return Center(child: Text("Error loading species"));
                            }

                            if (state is PokemonDetailLoaded) {
                              final species = state.species;

                              return TabBarView(
                                children: [
                                  PokemonAbout(
                                    pokemon: pokemon,
                                    species: species,
                                  ),
                                  PokemonStats(
                                    pokemon: pokemon,
                                    species: species,
                                  ),
                                  Center(child: Text("Items")),
                                ],
                              );
                            }

                            return SizedBox();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),


      // IMAGEN DEL POKEMON
          Positioned(
            top: screenSize.height * 0.15,
            left: 0,
            right: 0,
            child: Center(
              child: Image.network(
                pokemon.sprite,
                height: screenSize.height * 0.30,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // NOMBRE DEL POKEMON
          Positioned(
            left: screenSize.width * 0.05,
            top: screenSize.height * 0.07,
            child: Text(
              capitalizeClean(pokemon.name),
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //ID

          Positioned(
            right: screenSize.width * 0.05,
            top: screenSize.height * 0.07,
            child: Text(
              capitalizeClean("#00${pokemon.id.toString()}"),
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),



          Positioned(
            top: screenSize.height * 0.13,
            left: screenSize.width * 0.05,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.start,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                (pokemon.types.first ==
                    pokemon.types.last)
                    ? Container(
                  padding: EdgeInsets.all(
                    5,
                  ),
                  decoration: BoxDecoration(
                    shape:
                    BoxShape
                        .rectangle,
                    color: Colors.white
                        .withValues(
                      alpha: 0.3,
                    ),
                    borderRadius:
                    BorderRadius.circular(
                      15,
                    ),
                  ),
                  child: Text(
                    capitalizeClean(
                      pokemon.types.first,
                    ),
                    style: TextStyle(
                      fontWeight:
                      FontWeight.bold,
                      fontSize:
                      screenSize
                          .height *
                          0.02,
                      color: Colors.white,
                    ),
                  ),
                )
                    :
                Row(
                  children: [
                    Container(
                      padding:
                      EdgeInsets.all(
                        5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors
                            .white
                            .withValues(
                          alpha: 0.3,
                        ),
                        borderRadius:
                        BorderRadius.circular(
                          15,
                        ),
                      ),
                      child: Text(
                        capitalizeClean(
                          pokemon.types.first,
                        ),
                        style: TextStyle(
                          fontWeight:
                          FontWeight
                              .bold,
                          fontSize:
                          screenSize
                              .height *
                              0.02,
                          color:
                          Colors
                              .white,
                        ),
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.01,),
                    Container(
                      padding:
                      EdgeInsets.all(
                        5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors
                            .white
                            .withValues(
                          alpha: 0.3,
                        ),
                        borderRadius:
                        BorderRadius.circular(
                          15,
                        ),
                      ),
                      child: Text(
                        capitalizeClean(
                          pokemon.types.last,
                        ),
                        style: TextStyle(
                          fontWeight:
                          FontWeight
                              .bold,
                          fontSize:
                          screenSize
                              .height *
                              0.02,
                          color:
                          Colors
                              .white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

LayoutBuilder Pokebal(PokemonModel p, Size screenSize) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final double circle = screenSize.width * 0.70;
      return Container(
        width: circle,
        height: circle,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.1),
        ),
        child: Stack(
          children: [
            Center(
              child: Container(
                height: 20,
                color: ColorType.typeColors[p.types.first] ?? Colors.grey,
              ),
            ),
            Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorType.typeColors[p.types.first] ?? Colors.grey,
                ),
              ),
            ),
            Center(
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

String capitalizeClean(String text) {
  text = text.trim();
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

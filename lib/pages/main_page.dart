import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapi/models/pokemon_model.dart';
import 'package:pokeapi/pages/pokemon_details.dart';
import 'package:pokeapi/widgets/const.dart';

import '../blocs/main_page_blocs/mainpage_block.dart';
import '../blocs/main_page_blocs/mainpage_event.dart';
import '../blocs/main_page_blocs/mainpage_state.dart';

import 'main_page_search.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<MainPageBloc>().add(FetchMorePokemons());
      }
    });
  }

  String capitalizeClean(String text) {
    text = text.trim();
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF6a79d6),
          shape: CircleBorder(),
          child: Icon(Icons.tune, color: Colors.white,),
          onPressed: (){
      final bloc = context.read<MainPageBloc>();
      showDialog(
        context: context,
        builder: (context) {
          return BlocProvider.value(
            value: bloc,      // pasar el bloc existente al diálogo
            child: Dialog(
              child: MainPageSearch(), // <-- tu pantalla dentro del diálogo
            ),
          );
        },
      );

      }),
      body: Column(
        children: [
          SizedBox(height: screenSize.height * 0.01,),
          BlocBuilder<MainPageBloc, MainPageState>(
            builder: (context, state) {
              if (state is MainPageLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is MainPageLoaded) {
                final bloc = context.read<MainPageBloc>();

                return Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                          !bloc.isFetching) {
                        bloc.add(FetchMorePokemons());
                      }
                      return false;
                    },
                    child: GridView.builder(
                      padding: EdgeInsets.all(20),
                      itemCount: state.pokemons.length,
                      itemBuilder: (context, index) {
                        final p = state.pokemons[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PokemonDetailPage(pokemon: p),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  FadeColor.typeColors[p.types.first] ??
                                      Colors.grey,
                                  ColorType.typeColors[p.types.first] ??
                                      Colors.grey,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Pokebal(p, screenSize),
                              ],
                            ),
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 1,
                      ),
                    ),
                  ),
                );
              }

              if (state is MainPageError) {
                return const Center(child: Text("Error al cargar Pokémon"));
              }

              return Container();
            },
          ),
        ],
      ),
    );

  }



  LayoutBuilder Pokebal(PokemonModel p, Size screenSize) {
    return LayoutBuilder(
                                  builder: (context, constraints) {
                                    final circle =
                                        constraints.maxWidth * 0.85;
                                    return Container(
                                      width: circle,
                                      height: circle,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withValues(
                                          alpha: 0.1,
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white.withValues(
                                                alpha: 0.1,
                                              ),
                                            ),
                                          ),
                                          //LINEA EN MEDIO
                                          Center(
                                            child: Container(
                                              height: 20,
                                              color:
                                                  ColorType.typeColors[p
                                                      .types
                                                      .first] ??
                                                  Colors.grey,
                                            ),
                                          ),
                                          //PUNTO MEDIO FONDO COLOR
                                          Center(
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    ColorType.typeColors[p
                                                        .types
                                                        .first] ??
                                                    Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white
                                                    .withValues(alpha: 0.2),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            child: Text(
                                              capitalizeClean(p.name),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    screenSize.height * 0.025,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 50,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                (p.types.first ==
                                                        p.types.last)
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
                                                          p.types.first,
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
                                                    : Column(
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
                                                              p.types.first,
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
                                                        SizedBox(
                                                          height:
                                                              screenSize
                                                                  .height *
                                                              0.01,
                                                        ),
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
                                                              p.types.last,
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
                                          Positioned(
                                            right: 0,
                                            bottom: 0,
                                            child: Image.network(
                                              fit: BoxFit.cover,
                                              scale: 1.0,
                                              height: constraints.maxWidth * 0.65,
                                              p.sprite,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
  }
}



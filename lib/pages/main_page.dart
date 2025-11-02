import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapi/pages/pokemon_details.dart';
import 'package:pokeapi/widgets/const.dart';

import '../blocs/main_page_blocs/mainpage_block.dart';
import '../blocs/main_page_blocs/mainpage_event.dart';
import '../blocs/main_page_blocs/mainpage_state.dart';
import '../repositories/pokemon_repository.dart';
import '../services/api_service.dart';

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




  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;


    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            'assets/images/pokemonlogo.png',
            fit: BoxFit.contain,
            height: screenSize.height * 0.20,
          ),
          Divider(thickness: 2, color: Colors.grey),
          SizedBox(height: screenSize.height * 0.03),
          BlocProvider(
            create: (context) => MainPageBloc(PokemonRepository(PokemonService()))
              ..add(FetchPokemons()),
            child: BlocBuilder<MainPageBloc, MainPageState>(
              builder: (context, state) {
                if (state is MainPageLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MainPageLoaded) {
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
                      child: ListView.builder(
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
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: ColorType.typeColors[p.types.first] ??
                                    Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black, width: 2),
                              ),
                              child: Column(
                                children: [
                                  Image.network(
                                    p.sprite,
                                    fit: BoxFit.contain,
                                    height: screenSize.height * 0.25,
                                  ),
                                  Text("Nombre: ${p.name}",
                                      style: AppTextStyles.bold20),
                                  Text("ID: ${p.id}",
                                      style: AppTextStyles.bold20),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else if (state is MainPageError) {
                  return const Center(child: Text('Error al cargar Pokémon'));
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}

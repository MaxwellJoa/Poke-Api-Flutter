import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/main_page_blocs/mainpage_block.dart';
import '../blocs/main_page_blocs/mainpage_event.dart';

class MainPageSearch extends StatefulWidget {
  const MainPageSearch({super.key});

  @override
  State<MainPageSearch> createState() => _MainPageSearchState();
}

class _MainPageSearchState extends State<MainPageSearch> {
  TextEditingController _searchPokemonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SearchBar(
            controller: _searchPokemonController,
            hintText: "Search Pokémon",
            onChanged: (value) {
              if (value.isEmpty) {
                context.read<MainPageBloc>().add(ClearSearch());
              }
            },
            trailing: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  final name = _searchPokemonController.text.trim();
                  if (name.isNotEmpty) {
                    context.read<MainPageBloc>().add(SearchPokemonByName(name));
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.03,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6a79d6),
                ),
                onPressed: () {
                  final name = _searchPokemonController.text.trim();
                  if (name.isNotEmpty) {
                    context.read<MainPageBloc>().add(SearchPokemonByName(name));
                  }
                  Navigator.pop(context);
                },
                child: Text("Buscar", style: TextStyle(color: Colors.white),),
              ),
      
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6a79d6),
                ),
                onPressed: () {
                  _searchPokemonController.clear();
                  context.read<MainPageBloc>().add(ClearSearch());
                  Navigator.pop(context);
                },
                child: Text("Limpiar busqueda", style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

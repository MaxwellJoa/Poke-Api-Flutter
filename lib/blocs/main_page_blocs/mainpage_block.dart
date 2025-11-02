import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/pokemon_repository.dart';
import '../../models/pokemon_model.dart'; //
import 'mainpage_state.dart';
import 'mainpage_event.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final PokemonRepository repository;


  bool isFetching = false;
  int offset = 0;

  MainPageBloc(this.repository) : super(MainPageInitial()) {

    on<FetchPokemons>((event, emit) async {
      emit(MainPageLoading());
      try {
        offset = 0;
        final pokemons = await repository.fetchPokemonList(limit: 20, offset: offset);
        offset += 20;
        emit(MainPageLoaded(pokemons));
      } catch (e) {
        print('Error inicial: $e');
        emit(MainPageError());
      }
    });


    on<FetchMorePokemons>((event, emit) async {
      if (isFetching || state is! MainPageLoaded) return;
      isFetching = true;

      final currentState = state as MainPageLoaded;

      try {
        final morePokemons = await repository.fetchPokemonList(limit: 20, offset: offset);
        offset += 20;

        final updatedList = List<PokemonModel>.from(currentState.pokemons)
          ..addAll(morePokemons);

        emit(MainPageLoaded(updatedList));
      } catch (e) {
        print('Error cargando más Pokémon: $e');
      } finally {
        isFetching = false;
      }
    });
  }
}

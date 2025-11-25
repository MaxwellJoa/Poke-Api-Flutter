import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapi/blocs/pokemon_species_detail/species_event.dart';
import 'package:pokeapi/blocs/pokemon_species_detail/species_state.dart';

import '../../repositories/pokemon_species_repository.dart';

class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  final PokemonSpeciesRepository speciesRepo;



  PokemonDetailBloc(this.speciesRepo) : super(PokemonDetailInitial()) {
    on<FetchPokemonSpecies>((event, emit) async {
      emit(PokemonDetailLoading());
      try {
        final species = await speciesRepo.fetchSpecies(event.id);
        emit(PokemonDetailLoaded(species));
      } catch (e) {
        emit(PokemonDetailError());
      }
    });
  }
}

class SpeciesEvent {
  final int id;
  SpeciesEvent(this.id);
}

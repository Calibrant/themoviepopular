import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_git/bloc/movie_event.dart';
import 'package:flutter_movie_git/bloc/movie_state.dart';
import 'package:flutter_movie_git/repository/movie_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc(this.movieRepository) 
  : super(MovieLoadedState(loadedMovie: []));

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is MovieLoadEvent) {
      yield MovieLoadingState();

      try {
        final _loadedMovieList = await movieRepository.fetchAllMovies();
        
        yield MovieLoadedState(loadedMovie: _loadedMovieList as List<dynamic>);
      } catch (_) {
        yield MovieErrorState();
      }
    } else if (event is MovieCLearEvent) {
      yield MovieEmptyState();
    }
  }
}

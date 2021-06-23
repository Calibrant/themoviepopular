import 'package:flutter/cupertino.dart';

abstract class MovieState {}

class MovieEmptyState extends MovieState {}

class MovieLoadingState extends MovieState {}

class MovieLoadedState extends MovieState {
  List<dynamic> loadedMovie;
  MovieLoadedState({@required this.loadedMovie}) : assert(loadedMovie != null);
}

class MovieErrorState extends MovieState {}

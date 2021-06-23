import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_git/bloc/movie_bloc.dart';
import 'package:flutter_movie_git/screen/splash_screen.dart';
import 'screen/movie_list.dart';
import 'repository/movie_repository.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  MovieRepository movieRepository = MovieRepository();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      create: (context) => MovieBloc(movieRepository),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: SplashScreen(),
      ),
    );
  }
}

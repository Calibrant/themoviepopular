import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_git/bloc/movie_bloc.dart';
import 'package:flutter_movie_git/bloc/movie_state.dart';
import 'package:flutter_movie_git/repository/movie_repository.dart';
import 'movie_detail.dart';

class TransitionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.3,
        centerTitle: true,
        title: Text(
          'Movies',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: MovieList(),
    );
  }
}

class MovieList extends StatefulWidget {
  @override
  MovieListState createState() {
    return MovieListState();
  }
}

class MovieListState extends State<MovieList> with TickerProviderStateMixin {
  var movies;

  MovieRepository movieRepository = MovieRepository();
  AnimationController controller;

  void fetchData() async {
    var data = await movieRepository.fetchAllMovies();

    setState(() {
      movies = data['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchData();
    return BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
      if (state is MovieEmptyState) {
        return Center(
          child: Text(
            'No data received',
            style: Theme.of(context).textTheme.headline4,
          ),
        );
      }

      if (state is MovieLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is MovieLoadedState) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MovieTitle(),
              Expanded(
                child: ListView.builder(
                    itemCount: movies == null ? 0 : movies.length,
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5.0,
                          primary: Colors.white,
                        ),
                        child: MovieCell(movies, index),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return MovieDetail(movies[index]);
                          }));
                        },
                        // color: Colors.white,
                      );
                    }),
              )
            ],
          ),
        );
      }
      if (state is MovieErrorState) {
        return Center(
          child: Text('Error fetching movies',
              style: Theme.of(context).textTheme.headline4),
        );
      }
      return Container();
    });
  }
}

class MovieTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 00, 16.0),
      child: Text(
        'Popular',
        style: TextStyle(
          fontSize: 36.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class MovieCell extends StatelessWidget {
  final movies;
  final index;
  var image_url = 'https://image.tmdb.org/t/p/w500/';
  MovieCell(this.movies, this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                margin: const EdgeInsets.all(16.0),
                child: Container(
                  width: 100.0,
                  height: 100.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey,
                  image: DecorationImage(
                      image: NetworkImage(
                          image_url + movies[index]['poster_path']),
                      fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff3C3261),
                        blurRadius: 5.0,
                        offset: Offset(2.0, 5.0))
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movies[index]['title'],
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(2.0)),
                  Text(
                    movies[index]['overview'],
                    maxLines: 3,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ],
    );
  }
}

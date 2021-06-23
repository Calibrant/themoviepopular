
import 'package:flutter_movie_git/provider/movie_provider.dart';

class MovieRepository {
 MovieProvider _movieProvider = MovieProvider();

 Future<Map> fetchAllMovies()=>  _movieProvider.fetchMovies();
}

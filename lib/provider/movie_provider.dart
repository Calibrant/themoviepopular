import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieProvider {
  Future<Map> fetchMovies() async {
    var apiKey = 'ab4a606bb46b499516b52cfd9fa5103c';
    var url = 'https://api.themoviedb.org/3/movie/popular?api_key=${apiKey}';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error fetching movies');
    }
  }
}

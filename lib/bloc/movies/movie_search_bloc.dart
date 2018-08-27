import 'dart:async';
import 'dart:convert';
import 'package:flutter_movies/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class MovieSearchBloc {
  final String apiKey = '324e5cde';

  final _searchMovieByTitleSubject = StreamController<String>();
  Sink<String> get searchMovieByTitle => _searchMovieByTitleSubject.sink;

  final _movieListSubject = new BehaviorSubject<List<Movie>>();
  Stream<List<Movie>> get movieList => _movieListSubject.stream;

  var _movieList = new List<Movie>();

  MovieSearchBloc() {
    _searchMovieByTitleSubject.stream.listen(_searchMovieByTitle);
  }

  void _searchMovieByTitle(String arg) async {
    _movieList = await listMoviesByTitle(arg);
    _movieListSubject.add(_movieList);
  }

  Future<List<Movie>> listMoviesByTitle(String title) async {
    var movieList = new List<Movie>();
    await http
        .get('http://www.omdbapi.com/?s=${title}&apikey=${apiKey}')
        .then((response) {
      var search = json.decode(response.body);
      search['Search'].forEach((movie) {
        movieList.add(new Movie(movie['Title'], movie['Poster'], movie['Year'], movie['imdbID']));
      });
    });
    return movieList;
  }
}

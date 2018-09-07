import 'dart:async';
import 'package:flutter_movies/models/movie.dart';
import 'package:rxdart/rxdart.dart';

class MovieWatchlistBloc {

  final _movieListSubject = new BehaviorSubject<List<Movie>>();
  Stream<List<Movie>> get movieList => _movieListSubject.stream;
  final _watchlistController = StreamController<Movie>();
  Sink<Movie> get watchlist => _watchlistController.sink;
  
  final List<Movie> myWatchlist = new List<Movie>();
  
  void _watchlist(Movie arg) async {
    myWatchlist.add(arg);
    _movieListSubject.add(myWatchlist);
  }

  MovieWatchlistBloc() {
    _watchlistController.stream.listen(_watchlist);
    _movieListSubject.add(myWatchlist);
  }
}

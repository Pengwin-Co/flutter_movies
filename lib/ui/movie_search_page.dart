import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_movies/bloc/movies/movie_search_bloc.dart';
import 'package:flutter_movies/bloc/movies/movie_watchlist_bloc.dart';
import 'package:flutter_movies/models/movie.dart';
import 'package:flutter_movies/ui/movie_card.dart';
import 'package:flutter_movies/ui/movie_details.dart';

class MovieSearchPage extends StatefulWidget {
  MovieSearchBloc movieSearchBloc;
  MovieWatchlistBloc movieWatchlistBloc;
  MovieSearchPage(this.movieWatchlistBloc) {
    movieSearchBloc = new MovieSearchBloc();
  }

  @override
  State<StatefulWidget> createState() => MovieSeachState();
}

class MovieSeachState extends State<MovieSearchPage> {
  bool _isSearching = false;
  final TextEditingController _searchQuery = new TextEditingController();

  MovieSeachState() {
    _searchQuery.addListener(listener);
  }

  void listener() {
    if (_searchQuery.text.isNotEmpty) {
      widget.movieSearchBloc.searchMovieByTitle.add(_searchQuery.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildSearchBar(), body: buildResultList());
  }

  Object searchIcon = new Object();

  Widget buildSearchBar() {
    return AppBar(
      leading: BackButton(),
      title: _isSearching
          ? TextField(
              controller: _searchQuery,
              autofocus: true,
              style: new TextStyle(
                color: Colors.white,
              ),
              decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.search, color: Colors.white),
                  hintText: "Search...",
                  hintStyle: new TextStyle(
                      color: Colors.white, decorationColor: Colors.white)))
          : Text('Search Page'),
      actions: <Widget>[
        IconButton(
          icon: _isSearching ? Icon(Icons.close) : Icon(Icons.search),
          onPressed: () {
            setState(() {
              _isSearching = !_isSearching;
            });
          },
        )
      ],
    );
  }

  Widget buildResultList() {
    return new StreamBuilder(
        stream: widget.movieSearchBloc.movieList,
        initialData: new List<Movie>(),
        builder: (context, snapshot) {
          List<Movie> movies = snapshot.data;
          return new GridView.count(
              padding: EdgeInsets.all(4.0),
              crossAxisCount: 2,
              childAspectRatio: 0.50,
              children: List.generate(
                movies.length,
                (index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailsPage(movies[index])));
                      },
                      child: new MovieCard(movies[index]));
                },
              ));
        });
  }
}

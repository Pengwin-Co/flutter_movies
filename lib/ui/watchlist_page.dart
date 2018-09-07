import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_movies/models/movie.dart';
import 'package:flutter_movies/bloc/movies/movie_watchlist_bloc.dart';
import 'package:flutter_movies/ui/movie_card.dart';
import 'package:flutter_movies/ui/movie_search_page.dart';

class WatchlistPage extends StatefulWidget {
  final MovieWatchlistBloc movieWatchlistBloc = new MovieWatchlistBloc();
  WatchlistPage() {}

  @override
  State<StatefulWidget> createState() {
    return WatchlistState();
  }
}

class WatchlistState extends State<WatchlistPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('My Watchlist'),
      ),
      body: new StreamBuilder(
          stream: widget.movieWatchlistBloc.movieList,
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
                    return new MovieCard(movies[index]);
                  },
                ));
          }),
      floatingActionButton: new FloatingActionButton(
        onPressed: () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MovieSearchPage(widget.movieWatchlistBloc)));
        },
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

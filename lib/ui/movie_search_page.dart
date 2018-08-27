import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_movies/bloc/movies/movie_search_bloc.dart';
import 'package:flutter_movies/models/movie.dart';
import 'package:flutter_movies/ui/movie_card.dart';

class MovieSearchPage extends StatefulWidget {
  MovieSearchBloc movieSearchBloc;
  MovieSearchPage() {
    movieSearchBloc = new MovieSearchBloc();
    movieSearchBloc.searchMovieByTitle.add('007 ');
  }

  @override
  State<StatefulWidget> createState() {
    return new MovieSearchState();
  }
}

class MovieSearchState extends State<MovieSearchPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Movie Search'),
        ),
        body: new StreamBuilder(
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
                      return new MovieCard(movies[index]);
                    },
                  ));
            }));
  }
}

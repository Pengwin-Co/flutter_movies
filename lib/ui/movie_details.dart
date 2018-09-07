import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_movies/models/movie.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;

  MovieDetailsPage(this.movie, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MovieDetailsState();
}

class MovieDetailsState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 400.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    background: Hero(
                        tag: widget.movie,
                        child: Image.network(widget.movie.posterUrl,
                            fit: BoxFit.cover)),
                    title: Text(widget.movie.title)),
              )
            ];
          },
          body: Text(widget.movie.imdbId)),
    );
  }
}

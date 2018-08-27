import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_movies/models/movie.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;
  MovieCard(this.movie, {Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MovieCardState();
}

class MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        child: new Card(
            elevation: 2.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 240.0,
                    child: new Image.network(widget.movie.posterUrl,
                        fit: BoxFit.cover)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        widget.movie.title,
                        softWrap: true,
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      ),
                      new Text(
                        widget.movie.year,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

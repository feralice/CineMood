import 'package:flutter/material.dart';
import '../Home/modelos/movie_model.dart';

class RecommendedMoviesScreen extends StatelessWidget {
  final List<Movie> movies;

  const RecommendedMoviesScreen({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filmes Recomendados'),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return ListTile(
            leading: Image.network('https://image.tmdb.org/t/p/w500${movie.poster}')
            ,
            title: Text(movie.title),
            subtitle: Text(movie.overview),
          );
        },
      ),
    );
  }
}

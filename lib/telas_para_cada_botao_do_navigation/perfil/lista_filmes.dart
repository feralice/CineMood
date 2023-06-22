import 'package:cinemood/constantes/cores.dart';
import 'package:flutter/material.dart';
import '../../constantes/app_bar_usado.dart';
import '../Home/modelos/movie_model.dart';

class MoviesToWatchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Filmes para ver',
          style: TextStyle(
            color: AppColors.vermelho,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.azul,
        iconTheme: const IconThemeData(color: AppColors.vermelho),
      ),
      body: const Center(
        child: Text(
          'Filmes para ver',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class WatchlistScreen extends StatelessWidget {
  final List<Movie> watchlist;

  const WatchlistScreen({Key? key, required this.watchlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (watchlist.isEmpty) {
      return Scaffold(
        appBar: AppBarCinemood(),
        body: Center(
          child: Text('A lista de watchlist está vazia'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBarCinemood(),
      body: ListView.builder(
        itemCount: watchlist.length,
        itemBuilder: (BuildContext context, int index) {
          final movie = watchlist[index];
          return ListTile(
            leading: Image.network(
              'https://image.tmdb.org/t/p/w200${movie.poster}',
              width: 50,
              height: 80,
              fit: BoxFit.cover,
            ),
            title: Text(
              movie.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(movie.overview),
          );
        },
      ),
    );
  }
}

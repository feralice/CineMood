import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constantes/app_bar_usado.dart';
import '../../constantes/cores.dart';
import '../Home/modelos/movie_model.dart';
import '../perfil/lista_filmes.dart';

class RecommendedMoviesScreen extends StatefulWidget {
  final List<Movie> movies;

  const RecommendedMoviesScreen({Key? key, required this.movies})
      : super(key: key);

  @override
  _RecommendedMoviesScreenState createState() =>
      _RecommendedMoviesScreenState();
}

class _RecommendedMoviesScreenState extends State<RecommendedMoviesScreen> {
  late List<Movie> _movies;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _movies = List.from(widget.movies);
  }

  void _removeMovie(int index) {
    setState(() {
      _movies.removeAt(index);
      if (_currentIndex >= _movies.length) {
        _currentIndex = 0;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Filme descartado'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _moveToWatched(int index) {
    Movie movie = _movies[index];
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String movieId = movie.title.replaceAll(' ', '_'); // Cria um ID único para o filme

    FirebaseFirestore.instance
        .collection('usuarios')
        .doc(uid)
        .collection('filmes_vistos')
        .doc(movieId) // Define o ID do documento manualmente
        .set({
      'title': movie.title,
      'overview': movie.overview,
      'poster': movie.poster,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Filme movido para a lista de filmes assistidos'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _addToWatchlist(int index) {
    Movie movie = _movies[index];
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String documentId = movie.title.replaceAll(' ', '_'); // Gera um ID único baseado no título do filme

    FirebaseFirestore.instance
        .collection('usuarios')
        .doc(uid)
        .collection('filmes_futuros')
        .doc(documentId)
        .set({
      'title': movie.title,
      'overview': movie.overview,
      'poster': movie.poster,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Filme adicionado à watchlist'),
        duration: Duration(seconds: 1),
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MoviesToWatchPage()),
    );
  }





  void _showNextMovie() {
    setState(() {
      if (_currentIndex < _movies.length - 1) {
        _currentIndex++;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Todos os filmes foram mostrados'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_movies.isEmpty) {
      return const Scaffold(
        appBar: AppBarCinemood(),
        body: Center(
          child: Text('Sem mais filmes para recomendar'),
        ),
      );
    }

    final movie = _movies[_currentIndex];

    return Scaffold(
      appBar: AppBarCinemood(),
      body: Column(
        children: [
          SizedBox(height: 20),
          Card(
            color: AppColors.azul,
            child: Column(
              children: [
                Image.network(
                  'https://image.tmdb.org/t/p/w200${movie.poster}',
                  width: 150,
                  height: 220,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10),
                ListTile(
                  tileColor: null,
                  title: Text(
                    movie.title,
                    style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.branco,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
<<<<<<< HEAD
=======
                  ),
>>>>>>> e07d1e1 (ultimos ajustes)
                  ),
<<<<<<< HEAD
                  ),
=======
>>>>>>> 6955e89 (ultimos ajustes)

                  subtitle: Text(
                    movie.overview,
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(8.0),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.clear),
                  color: Colors.red,
                  iconSize: 30,
                  onPressed: () {
                    _removeMovie(_currentIndex);
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    _moveToWatched(_currentIndex);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey,
                  ),
                  child: Text('Já assisti'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _addToWatchlist(_currentIndex);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.verde_escuro,
                  ),
                  child: Text('Vou assistir'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

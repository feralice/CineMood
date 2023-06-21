import 'package:flutter/material.dart';
import '../../constantes/cores.dart';
import '../Home/modelos/movie_model.dart';

class RecommendedMoviesScreen extends StatefulWidget {
  final List<Movie> movies;

  const RecommendedMoviesScreen({Key? key, required this.movies})
      : super(key: key);

  @override
  _RecommendedMoviesScreenState createState() =>
      _RecommendedMoviesScreenState();
}

class _RecommendedMoviesScreenState extends State<RecommendedMoviesScreen> {
  late List<Movie>
      _movies; // Usando a palavra-chave 'late' para inicializar posteriormente
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _movies = List.from(widget.movies); // Cria uma cópia da lista original
  }

  void _removeMovie(int index) {
    setState(() {
      _movies.removeAt(index);
      if (_currentIndex >= _movies.length) {
        _currentIndex = 0; // Redefine o índice atual para o primeiro filme
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Filme descartado'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _moveToWatched(int index) {
    // Adicione o código para mover o filme para a lista de filmes assistidos
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Filme movido para a lista de filmes assistidos'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _addToWatchlist(int index) {
    // Adicione o código para adicionar o filme à watchlist
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Filme adicionado à watchlist'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _showNextMovie() {
    setState(() {
      if (_currentIndex < _movies.length - 1) {
        _currentIndex++;
      } else {
        // Caso todos os filmes tenham sido mostrados, você pode tomar uma ação, como mostrar uma mensagem ou redirecionar para outra tela.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
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
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'CineMood',
            style: TextStyle(
              color: AppColors.vermelho,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.azul,
          iconTheme: const IconThemeData(
            color: AppColors.vermelho,
          ),
        ),
        body: Center(
          child: Text('Sem mais filmes para recomendar'),
        ),
      );
    }

    final movie = _movies[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CineMood',
          style: TextStyle(
            color: AppColors.vermelho,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.azul,
        iconTheme: const IconThemeData(
          color: AppColors.vermelho,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          // ...

          Card(
            color: AppColors
                .azul, // Adicione esta linha para definir o fundo do Card como transparente
            child: Column(
              children: [
                Image.network(
                  'https://image.tmdb.org/t/p/w200${movie.poster}',
                  width: 150,
                  height: 220,
                  fit: BoxFit.cover,
                ),
                ListTile(
                  tileColor:
                      null, // fundo do ListTile como nulo
                  title: Text(
                    movie.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                  ),
                  subtitle: Text(
                    movie.overview,
                    style: const TextStyle(
                      color: Colors
                          .white70, // Defina a cor desejada para a descrição
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(8.0),
                ),
              ],
            ),
          ),

// ...

          SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 20),
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

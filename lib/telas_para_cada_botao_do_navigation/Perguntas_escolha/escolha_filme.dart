import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import '../../constantes/app_bar_usado.dart';
import '../../constantes/cores.dart';
import '../Home/modelos/movie_model.dart';
import 'filmes_recomendados.dart';

class ChoiceButton extends StatefulWidget {
  final String text;
  final Function(String)? onPressed;
  final bool isSelected;

  const ChoiceButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  @override
  _ChoiceButtonState createState() => _ChoiceButtonState();
}

class _ChoiceButtonState extends State<ChoiceButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (widget.onPressed != null) {
          widget.onPressed!(widget.text);
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed) || widget.isSelected) {
              return const Color(0xFFE25265);
            }
            return const Color(0xFFE25265).withOpacity(0.5);
          },
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.text,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class FilmeEscolha extends StatefulWidget {
  const FilmeEscolha({Key? key}) : super(key: key);

  @override
  _FilmeEscolhaState createState() => _FilmeEscolhaState();
}

class _FilmeEscolhaState extends State<FilmeEscolha> {
  String? selectedMood;

  Map<String, Map<String, String>> moodQuestionMap = {
    'Feliz': {
      'Relaxado': '35',
      'Eufórico': '28',
    },
    'Triste': {
      'Levantar o astral': '35',
      'Continuar no fundo do poço': '18',
    },
    'Normal': {
      'Qualquer coisa': '',
    },
    'Estressado': {
      'Relaxar': '10751',
      'Matar alguém': '27',
    },
    'Apaixonado': {
      'Na fossa': '18',
      'Apaixonadinho': '10749',
    },
    'Cansado': {
      'Se animar': '12',
      'Apenas relaxar': '878',
    },
  };

  void _selectMood(String mood) {
    setState(() {
      selectedMood = mood;
    });
  }

  void _navigateToRecommendedMoviesScreen() async {
    if (selectedMood == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Selecione um humor',
              style: TextStyle(fontSize: 18, color: Colors.red)),
          content: const Text(
              'Por favor, selecione o seu humor antes de avançar.',
              style: TextStyle(fontSize: 16, color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK',
                  style: TextStyle(fontSize: 16, color: Colors.red)),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Color(0xFF1B3658),
          elevation: 8,
        ),
      );
    } else if (selectedMood == 'Normal') {
      _recommendMovies();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondQuestionScreen(
            mood: selectedMood!,
            moodQuestionMap: moodQuestionMap,
            onSelectedFeeling: _recommendMovies,
          ),
        ),
      );
    }
  }

  void _recommendMovies() async {
    final List<Movie> recommendedMovies = await _getRecommendedMovies();

    recommendedMovies.shuffle(); // Embaralhar a lista de filmes

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            RecommendedMoviesScreen(movies: recommendedMovies),
      ),
    );
  }

  Future<List<Movie>> _getRecommendedMovies() async {
    final genreMap = moodQuestionMap[selectedMood!];
    final genreKeys = genreMap!.keys.toList();

    final apiKey = 'edd5884041916ec57223def708862cc8';
    final baseUrl = 'https://api.themoviedb.org/3';
    final discoverUrl = '$baseUrl/discover/movie';
    final language = 'pt-BR'; // idioma retornado

    //aq é so pro normal
    final random = Random();
    final randomGenreKey = genreKeys[random.nextInt(genreKeys.length)];
    final selectedGenre = genreMap[randomGenreKey];

    final queryParams = {
      'api_key': apiKey,
      'with_genres': selectedGenre,
      'language': language,
      'page': Random().nextInt(10).toString(),
      'sort_by': 'popularity.desc',
    };

    final uri = Uri.parse(discoverUrl).replace(queryParameters: queryParams);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Movie> movies = List<Movie>.from(jsonData['results'].map((x) {
        return Movie(
          x['id'],
          x['popularity'] ?? 0,
          x['title'] ?? '',
          x['backdrop_path'] ?? '',
          x['poster_path'] ?? '',
          x['overview'] ?? '',
          x['vote_average'] ?? 0.0,
          x['description'] ?? '',
        );
      }));

      movies.shuffle(); // Embaralhar a lista de filmes

      return movies;
    } else {
      throw Exception('Falha ao carregar filmes recomendados');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B3658),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Como você está se sentindo hoje?',
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.4,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 40),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              children: moodQuestionMap.keys.map((mood) {
                return ChoiceButton(
                  text: mood,
                  onPressed: _selectMood,
                  isSelected: selectedMood == mood,
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            Align(
              alignment: const Alignment(0.8, 0),
              child: FloatingActionButton(
                onPressed: _navigateToRecommendedMoviesScreen,
                backgroundColor: const Color(0xFFE25265),
                child: const Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondQuestionScreen extends StatefulWidget {
  final String mood;
  final Map<String, Map<String, String>> moodQuestionMap;
  final Function() onSelectedFeeling;

  const SecondQuestionScreen({
    Key? key,
    required this.mood,
    required this.moodQuestionMap,
    required this.onSelectedFeeling,
  }) : super(key: key);

  @override
  _SecondQuestionScreenState createState() => _SecondQuestionScreenState();
}

class _SecondQuestionScreenState extends State<SecondQuestionScreen> {
  String? selectedFeeling;

  void _selectFeeling(String feeling) {
    setState(() {
      selectedFeeling = feeling;
    });
  }

  void _recommendMovies() async {
    if (selectedFeeling == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Selecione um humor',
              style: TextStyle(fontSize: 18, color: Colors.red)),
          content: const Text(
              'Por favor, selecione o seu humor antes de avançar.',
              style: TextStyle(fontSize: 16, color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK',
                  style: TextStyle(fontSize: 16, color: Colors.red)),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Color(0xFF1B3658),
          elevation: 8,
        ),
      );
    } else {
      _getRecommendedMoviesAndNavigate();
    }
  }

  void _getRecommendedMoviesAndNavigate() async {
    final List<Movie> recommendedMovies = await _getRecommendedMovies();

    recommendedMovies.shuffle(); // Embaralhar a lista de filmes

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            RecommendedMoviesScreen(movies: recommendedMovies),
      ),
    );
  }

  Future<List<Movie>> _getRecommendedMovies() async {
    final genreMap = widget.moodQuestionMap[widget.mood]!;
    final genreKeys = genreMap.keys.toList();

    final selectedGenre = genreMap[selectedFeeling!];

    final apiKey = 'edd5884041916ec57223def708862cc8';
    final baseUrl = 'https://api.themoviedb.org/3';
    final discoverUrl = '$baseUrl/discover/movie';
    final language = 'pt-BR';

    final queryParams = {
      'api_key': apiKey,
      'with_genres': selectedGenre,
      'language': language,
      'page': Random().nextInt(10).toString(),
      'sort_by': 'popularity.desc',
    };

    final uri = Uri.parse(discoverUrl).replace(queryParameters: queryParams);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Movie> movies = List<Movie>.from(jsonData['results'].map((x) {
        return Movie(
          x['id'],
          x['popularity'] ?? 0,
          x['title'] ?? '',
          x['backdrop_path'] ?? '',
          x['poster_path'] ?? '',
          x['overview'] ?? '',
          x['vote_average'] ?? 0.0,
          x['description'] ?? '',
        );
      }));

      movies.shuffle(); // Embaralhar a lista de filmes

      return movies;
    } else {
      throw Exception('Falha ao carregar filmes recomendados');
    }
  }


  String pegaHumor() {
    if (widget.mood == 'Feliz') {
      return 'Que bom! Mas você está relaxado ou eufórico?';
    } else if (widget.mood == 'Triste') {
      return ':( Você quer continuar no fundo do poço ou quer levantar o astral?';
    } else if (widget.mood == 'Apaixonado') {
      return 'Uiii <3 Tá apaixonadinho ou tá na fossa?';
    } else if (widget.mood == 'Estressado') {
      return 'Hmm.. Deseja relaxar ou tá afim de matar alguém?';
    } else {
      return 'Tá afim de relaxar ou se animar um pouquinho?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCinemood(),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              pegaHumor(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                height: 1.4,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              children:
              widget.moodQuestionMap[widget.mood]!.keys.map((feeling) {
                return ChoiceButton(
                  text: feeling,
                  onPressed: _selectFeeling,
                  isSelected: selectedFeeling == feeling,
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            Align(
              alignment: const Alignment(0.8, 0),
              child: FloatingActionButton(
                onPressed: _recommendMovies,
                backgroundColor: const Color(0xFFE25265),
                child: const Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

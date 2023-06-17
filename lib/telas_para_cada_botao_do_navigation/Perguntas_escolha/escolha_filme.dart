import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../Home/modelos/movie_model.dart';
import 'filmes_recomendados.dart';

class ChoiceButton extends StatefulWidget {
  final String text;
  final Function(String)? onPressed;
  final bool isSelected;

  const ChoiceButton(
      {Key? key, required this.text, this.onPressed, this.isSelected = false})
      : super(key: key);

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
  Map<String, String> moodGenreMap = {
    'Feliz': '35',
    'Triste': '18',
    'Estressado': '28',
    'Ansioso': '53',
    'Apaixonado': '10749',
    'Normal': '12',
    'Entediado': '878',
    'Empolgado': '28',
    'Cansado': '18',
    'Surpreso': '53',
    'Relaxado': '35',
  };

  void _selectMood(String mood) {
    setState(() {
      selectedMood = mood;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B3658),
      body: Padding(
        padding: EdgeInsets.all(30),
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
              children: moodGenreMap.keys.map((mood) {
                return ChoiceButton(
                  text: mood,
                  onPressed: _selectMood,
                  isSelected: selectedMood == mood,
                );
              }).toList(),
            ),
            const SizedBox(height: 60),
            Align(
              alignment: const Alignment(0.8, 0),
              child: FloatingActionButton(
                onPressed: () {
                  _recommendMovies();
                },
                backgroundColor: const Color(0xFFE25265),
                child: const Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _recommendMovies() async {
    if (selectedMood != null) {
      final String selectedGenre = moodGenreMap[selectedMood] ?? '';
      final List<Movie> recommendedMovies =
          await _getRecommendedMovies(selectedGenre);
      recommendedMovies.shuffle(); // Embaralhar a lista de filmes

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              RecommendedMoviesScreen(movies: recommendedMovies),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Selecione um humor',
              style: TextStyle(color: Colors.red)),
          content:
              const Text('Por favor, selecione o seu humor antes de avançar.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK', style: TextStyle(color: Colors.red)),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            // Pode adicionar borda personalizada ao AlertDialog
            // borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          backgroundColor: Color(0xFF1B3658),
          elevation: 8,
          // Pode ajustar a elevação (sombra) do AlertDialog
        ),
      );
    }
  }

  Future<List<Movie>> _getRecommendedMovies(String genre) async {
    final String apiKey = 'edd5884041916ec57223def708862cc8';
    final String baseUrl = 'https://api.themoviedb.org/3';
    final String discoverUrl = '$baseUrl/discover/movie';
    final String language = 'pt-BR';

    final Map<String, String> queryParams = {
      'api_key': apiKey,
      'with_genres': genre,
      'language': language,
    };

    final Uri uri =
        Uri.parse(discoverUrl).replace(queryParameters: queryParams);

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
      return movies;
    } else {
      throw Exception('Falha ao carregar filmes recomendados');
    }
  }
}

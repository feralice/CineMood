import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
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
  _FirstQuestionScreenState createState() => _FirstQuestionScreenState();
}

class _FirstQuestionScreenState extends State<FilmeEscolha> {
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
      'Relaxar': '35',
      'Matar alguém': '28',
    },
    'Apaixonado': {
      'Na fossa': '35',
      'Não na fossa': '10749',
    },
    'Cansado': {
      'Se animar': '28',
      'Apenas relaxar': '35',
    },
  };

  void _selectMood(String mood) {
    setState(() {
      selectedMood = mood;
    });
  }

  void _navigateToSecondQuestionScreen() {
    if (selectedMood != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondQuestionScreen(
            mood: selectedMood!,
            moodQuestionMap: moodQuestionMap,
          ),
        ),
      );
    } else {
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
              alignment: Alignment(0.8, 0),
              child: FloatingActionButton(
                onPressed: _navigateToSecondQuestionScreen,
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

  const SecondQuestionScreen({
    Key? key,
    required this.mood,
    required this.moodQuestionMap,
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
    if (selectedFeeling != null) {
      final selectedGenre =
          widget.moodQuestionMap[widget.mood]![selectedFeeling!];
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
    }
  }

  Future<List<Movie>> _getRecommendedMovies(String? genre) async {
    if (genre == null || genre.isEmpty) {
      throw Exception('Gênero não definido');
    }

    final apiKey = 'edd5884041916ec57223def708862cc8';
    final baseUrl = 'https://api.themoviedb.org/3';
    final discoverUrl = '$baseUrl/discover/movie';
    final language = 'pt-BR';

    final queryParams = {
      'api_key': apiKey,
      'with_genres': genre,
      'language': language,
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
      return 'Uiii <3 Tá apaixonadinho ou está na fossa?';
    } else if (widget.mood == 'Estressado') {
      return 'Hmm.. Deseja relaxar ou tá afim de matar alguém?';
    } else {
      return 'Tá afim de relaxar ou se animar um pouquinho?';
    }
  }

  @override
  Widget build(BuildContext context) {
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
        iconTheme: IconThemeData(
            color:
                AppColors.vermelho), // Altera a cor do ícone da seta de volta
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              pegaHumor(),
              textAlign: TextAlign.center,
              style: TextStyle(
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
            FloatingActionButton(
              onPressed: _recommendMovies,
              backgroundColor: const Color(0xFFE25265),
              child: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}

class RecommendedMoviesScreen extends StatelessWidget {
  final List<Movie> movies;

  const RecommendedMoviesScreen({Key? key, required this.movies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        iconTheme: IconThemeData(color: AppColors.verde_escuro),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return ListTile(
            title: Text(movie.title),
            subtitle: Text(movie.overview),
            leading: Image.network(
              'https://image.tmdb.org/t/p/w200${movie.poster}',
            ),
          );
        },
      ),
    );
  }
}

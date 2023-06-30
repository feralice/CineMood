import 'package:flutter/material.dart';
import '../../../constantes/app_bar_usado.dart';
import '../modelos/movie_model.dart';
import '../../../constantes/cores.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  MovieDetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    // Cálculo da quantidade de estrelas
    num rating = movie.rating;
    int starCount = (rating / 2).round().clamp(0, 5);

    // Obter as dimensões da tela
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarCinemood(),


      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.vermelho,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),


            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.network(
                  "https://image.tmdb.org/t/p/original/" + movie.poster!,
                  width: screenSize.width * 0.8, // 80% da largura da tela
                  height: screenSize.height * 0.4, // 40% da altura da tela
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    'Nota: ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        rating.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white, // Altere a cor do texto para branco
                        ),
                      ),
                      SizedBox(width: 8),
                      Row(
                        children: List.generate(5, (index) {
                          if (index < starCount) {
                            return Icon(
                              Icons.star,
                              color: Colors.yellow,
                            );
                          } else {
                            return Icon(
                              Icons.star_border,
                              color: Colors.grey,
                            );
                          }
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                movie.overview,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white, // Altere a cor do texto para branco
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

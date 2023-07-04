import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../constantes/app_bar_usado.dart';
import '../modelos/pessoa.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PersonDetailsScreen extends StatelessWidget {
  final Person person;

  PersonDetailsScreen({required this.person});

  @override
  Widget build(BuildContext context) {
    // Cálculo da quantidade de estrelas
    double popularityRating = person.popularity / 10; // Mapear a nota de 0 a 10
    int starCount = (popularityRating * 5).round().clamp(0, 5); // Arredondar e limitar entre 0 e 5 estrelas

    return Scaffold(
      appBar: AppBarCinemood(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (person.profileImg.isNotEmpty)
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w500/" + person.profileImg,
                        width: 200,
                        height: 300,
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              Text(
                person.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              RatingBar.builder(
                itemSize: 24,
                initialRating: popularityRating,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: starCount > 0 ? Colors.amber : Colors.grey, // Definir a cor das estrelas com base na quantidade
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              SizedBox(height: 8),
              Text(
                "Conhecido por: ${person.known}",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

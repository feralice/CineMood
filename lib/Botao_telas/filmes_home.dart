import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemood/Botao_telas/componentes/movies_carousel.dart';
import 'package:cinemood/model/movie_model.dart';
import 'package:cinemood/services/api_service.dart';
import 'package:flutter/material.dart';


class MovieHome extends StatefulWidget {
  const MovieHome({Key? key}) : super(key: key);

  @override
  _MovieHomeState createState() => _MovieHomeState();
}


class _MovieHomeState extends State<MovieHome> {

  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FutureBuilder(
            builder: (context,snapsot) {
            if(snapsot.hasData) {
              List<MovieModel> moviedata = snapsot.data ?? [];
              return MovieCarousel(movieList: moviedata,);
            }
            return Center(
              child:CircularProgressIndicator(),
            );
          },
            future: apiService.getMovieData(MovieType.nowPlaying),
          )
        ],
      ),
    );
  }
}
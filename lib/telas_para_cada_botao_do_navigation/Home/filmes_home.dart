import 'package:cinemood/telas_para_cada_botao_do_navigation/Home/widgets/generos.dart';
import 'package:cinemood/telas_para_cada_botao_do_navigation/Home/widgets/now_playing.dart';
import 'package:cinemood/telas_para_cada_botao_do_navigation/Home/widgets/pessoas.dart';
import 'package:cinemood/telas_para_cada_botao_do_navigation/Home/widgets/top_filmes.dart';
import 'package:flutter/material.dart';

class FilmeHome extends StatefulWidget {
  @override
  _FilmeHomeState createState() => _FilmeHomeState();
}

class _FilmeHomeState extends State<FilmeHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          NowPlaying(),
          GenresScreen(),
          PersonsList(),
          BestMovies(),
        ],
      ),
    );
  }
}

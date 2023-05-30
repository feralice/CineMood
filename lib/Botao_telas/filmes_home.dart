import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../widgets/generos.dart';
import '../widgets/now_playing.dart';

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
        ],
      ),
    );
  }
}

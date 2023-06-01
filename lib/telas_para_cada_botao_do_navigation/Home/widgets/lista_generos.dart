import 'package:cinemood/constantes/cores.dart';
import 'package:flutter/material.dart';

import '../../../Consultas_api_home/pega_filme_por_genero.dart';
import '../modelos/genero.dart';
import 'filmes_por_genero.dart';

class GenresList extends StatefulWidget {
  final List<Genre> genres;
  GenresList({Key? key, required this.genres}) : super(key: key);

  @override
  _GenresListState createState() => _GenresListState(genres);
}

class _GenresListState extends State<GenresList>
    with SingleTickerProviderStateMixin {
  final List<Genre> genres;
  late TabController _tabController;

  _GenresListState(this.genres);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: genres.length);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        moviesByGenreBloc.drainStream();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 307.0,
      child: DefaultTabController(
        length: genres.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.vermelho,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.0,
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.white,
                isScrollable: true,
                tabs: genres.map((Genre genre) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                    child: Text(
                      genre.name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
              backgroundColor: AppColors.azul, // Defina a cor de fundo desejada aqui
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: genres.map((Genre genre) {
              return GenreMovies(key: Key('genre_${genre.id}'), genreId: genre.id);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

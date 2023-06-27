import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cinemood/constantes/cores.dart';

class MoviesToWatchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const DefaultTextStyle(
          style: TextStyle(
            color: AppColors.vermelho,
            fontWeight: FontWeight.bold,
            fontFamily: 'BILYALAYEREDBASE',
            fontSize: 15,
            letterSpacing: 1.0,
          ),
          child: Text('Filmes para ver'),
        ),
        backgroundColor: AppColors.azul,
        iconTheme: IconThemeData(color: AppColors.vermelho),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('usuarios')
            .doc(uid)
            .collection('filmes_futuros')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar os filmes para ver'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('Nenhum filme para ver'),
            );
          }

          return ListView.separated(
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              var movieData =
              snapshot.data!.docs[index].data() as Map<String, dynamic>;
              var movieTitle = movieData['title'] ?? '';
              var movieOverview = movieData['overview'] ?? '';
              var moviePoster = movieData['poster'] ?? '';

              return ListTile(
                leading: Image.network(
                  'https://image.tmdb.org/t/p/w200$moviePoster',
                  width: 50,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  movieTitle,
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
                ),
                subtitle: Text(
                  movieOverview,
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('usuarios')
                        .doc(uid)
                        .collection('filmes_futuros')
                        .doc(snapshot.data!.docs[index].id)
                        .delete();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class WatchlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'filmes vistos',
          style: TextStyle(
            color: AppColors.vermelho,
            fontWeight: FontWeight.bold,
            fontFamily: 'BILYALAYEREDBASE',
            fontSize: 15,
            letterSpacing: 1.0,
          ),
        ),
        backgroundColor: AppColors.azul,
        iconTheme: const IconThemeData(color: AppColors.vermelho),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('usuarios')
            .doc(uid)
            .collection('filmes_vistos')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar os filmes vistos'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('Nenhum filme visto'),
            );
          }

          return ListView.separated(
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              var movieData =
              snapshot.data!.docs[index].data() as Map<String, dynamic>;
              var movieTitle = movieData['title'] ?? '';
              var movieOverview = movieData['overview'] ?? '';
              var moviePoster = movieData['poster'] ?? '';

              return ListTile(
                leading: Image.network(
                  'https://image.tmdb.org/t/p/w200$moviePoster',
                  width: 50,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  movieTitle,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 18),

                ),
                subtitle: Text(
                  movieOverview,
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

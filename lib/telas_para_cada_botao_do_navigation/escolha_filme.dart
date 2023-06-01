import 'package:flutter/material.dart';

class FilmeEscolha extends StatefulWidget {
  @override
  _FilmeEscolhaState createState() => _FilmeEscolhaState();
}

class _FilmeEscolhaState extends State<FilmeEscolha> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          style: TextStyle(fontSize: 24),
          'Bem-vindo ao Filme Escolha!',
        ),
      ),
    );
  }
}
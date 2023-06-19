import 'package:cinemood/constantes/cores.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sobre Nós',
          style: TextStyle(
            color: AppColors.vermelho,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.azul,
        iconTheme: const IconThemeData(color: AppColors.vermelho),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'CineMood',
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.4,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Uma aplicação para amantes de filmes e séries.',
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.4,
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 32.0),
            Text(
              'Criadores:',
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.4,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Fernanda',
              style: TextStyle(
                height: 1.4,
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            Text(
              'Jo',
              style: TextStyle(
                height: 1.4,
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            Text(
              'Sarah',
              style: TextStyle(
                height: 1.4,
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

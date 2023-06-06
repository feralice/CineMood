import 'package:flutter/material.dart';

class FilmeEscolha extends StatefulWidget {
  @override
  _FilmeEscolhaState createState() => _FilmeEscolhaState();
}

class _FilmeEscolhaState extends State<FilmeEscolha> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Como você está se sentindo hoje?',
              style: TextStyle(fontSize: 24),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Ação quando o botão for clicado (gênero selecionado)
                  },
                  child: const Text('Feliz'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Ação quando o botão for clicado (gênero selecionado)
                  },
                  child: const Text('Triste'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Ação quando o botão for clicado (gênero selecionado)
                  },
                  child: const Text('Com Raiva'),
                ),
                // Adicione mais botões para outros gêneros desejados
              ],
            ),
            const Text(
              'Que gênero de filme você gosta?',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Ação quando o botão for clicado (gênero selecionado)
                  },
                  child: const Text('Ação'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Ação quando o botão for clicado (gênero selecionado)
                  },
                  child: const Text('Comédia'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Ação quando o botão for clicado (gênero selecionado)
                  },
                  child: const Text('Drama'),
                ),
                // Adicione mais botões para outros gêneros desejados
              ],
            ),
            const Text(
              'Quais serviços de straming você possui?',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Ação quando o botão for clicado (gênero selecionado)
                  },
                  child: const Text('Netflix'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Ação quando o botão for clicado (gênero selecionado)
                  },
                  child: const Text('Disney+'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Ação quando o botão for clicado (gênero selecionado)
                  },
                  child: const Text('Amazon Prime'),
                ),
                // Adicione mais botões para outros gêneros desejados
              ],
            ),
          ],
        ),
      ),
    );
  }
}

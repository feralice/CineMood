import 'package:flutter/material.dart';

class FilmeEscolha extends StatefulWidget {
  const FilmeEscolha({Key? key}) : super(key: key);

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
              style: TextStyle(
                height: 1.4,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Ação quando o botão for clicado (gênero selecionado)
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFE25265),
                    ),
                  ),
                  child: const Text('Feliz'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Ação quando o botão for clicado (gênero selecionado)
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFE25265),
                    ),
                  ),
                  child: const Text('Triste'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Ação quando o botão for clicado (gênero selecionado)
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFE25265),
                    ),
                  ),
                  child: const Text('Com Raiva'),
                ),
                // Adicione mais botões para outros gêneros desejados
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Que gênero de filme você gosta?',
              style: TextStyle(
                height: 1.4,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Ação quando o botão for clicado (gênero selecionado)
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFE25265),
                    ),
                  ),
                  child: const Text('Ação'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Ação quando o botão for clicado (gênero selecionado)
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFE25265),
                    ),
                  ),
                  child: const Text('Comédia'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Ação quando o botão for clicado (gênero selecionado)
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFE25265),
                    ),
                  ),
                  child: const Text('Drama'),
                ),
                // Adicione mais botões para outros gêneros desejados
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Quais serviços de streaming você possui?',
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.4,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Ação quando o botão for clicado (gênero selecionado)
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFE25265),
                    ),
                  ),
                  child: const Text('Netflix'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Ação quando o botão for clicado (gênero selecionado)
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFE25265),
                    ),
                  ),
                  child: const Text('Disney+'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Ação quando o botão for clicado (gênero selecionado)
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFE25265),
                    ),
                  ),
                  child: const Text('Amazon Prime'),
                ),
                // Adicione mais botões para outros gêneros desejados
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action when the "Avançar" button is pressed
        },
        backgroundColor: const Color(0xFFE25265),
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

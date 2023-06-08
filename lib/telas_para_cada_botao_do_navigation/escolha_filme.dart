import 'package:flutter/material.dart';

class FilmeEscolha extends StatefulWidget {
  const FilmeEscolha({Key? key}) : super(key: key);

  @override
  _FilmeEscolhaState createState() => _FilmeEscolhaState();
}

class _EmotionButtonState extends State<EmotionButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isSelected = !isSelected;
        });
        // Action when the button is pressed
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed) || isSelected) {
            return const Color(0xFFE25265);
          }
          return const Color(0xFFE25265).withOpacity(0.5);
        }),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      child: Text(widget.text),
    );
  }
}

class EmotionButton extends StatefulWidget {
  final String text;

  const EmotionButton({Key? key, required this.text}) : super(key: key);

  @override
  _EmotionButtonState createState() => _EmotionButtonState();
}

class _FilmeEscolhaState extends State<FilmeEscolha> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Como você está se sentindo hoje?',
              style: TextStyle(
                height: 1.4,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EmotionButton(
                      text: 'Feliz',
                    ),
                    SizedBox(width: 10),
                    EmotionButton(
                      text: 'Triste',
                    ),
                    SizedBox(width: 10),
                    EmotionButton(
                      text: 'Com Raiva',
                    ),
                    // Adicione mais botões para outros gêneros desejados
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EmotionButton(
                      text: 'Ansioso',
                    ),
                    SizedBox(width: 10),
                    EmotionButton(
                      text: 'Apaixonado',
                    ),
                    SizedBox(width: 10),
                    EmotionButton(
                      text: 'Normal',
                    ),
                    // Adicione mais botões para outros gêneros desejados
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Que gênero de filme você gosta?',
              style: TextStyle(
                height: 1.4,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EmotionButton(
                      text: 'Ação',
                    ),
                    SizedBox(width: 10),
                    EmotionButton(
                      text: 'Animação',
                    ),
                    SizedBox(width: 10),
                    EmotionButton(
                      text: 'Comédia',
                    ),
                    // Adicione mais botões para outros gêneros desejados
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EmotionButton(
                      text: 'Drama',
                    ),
                    SizedBox(width: 10),
                    EmotionButton(
                      text: 'Fantasia',
                    ),
                    SizedBox(width: 10),
                    EmotionButton(
                      text: 'Musical',
                    ),
                    SizedBox(width: 10),
                    EmotionButton(
                      text: 'Terror',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EmotionButton(
                      text: 'Romance',
                    ),
                    SizedBox(width: 10),
                    EmotionButton(
                      text: 'Ficção Científica',
                    ),
                    SizedBox(width: 10),
                    EmotionButton(
                      text: 'Suspense',
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
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
                EmotionButton(
                  text: 'Netflix',
                ),
                SizedBox(width: 10),
                EmotionButton(
                  text: 'Disney+',
                ),
                SizedBox(width: 10),
                EmotionButton(
                  text: 'Amazon Prime',
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

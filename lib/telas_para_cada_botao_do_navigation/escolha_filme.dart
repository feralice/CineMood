import 'package:flutter/material.dart';

class FilmeEscolha extends StatefulWidget {
  const FilmeEscolha({Key? key}) : super(key: key);

  @override
  _FilmeEscolhaState createState() => _FilmeEscolhaState();
}

class _ChoiceButtonState extends State<ChoiceButton> {
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

class ChoiceButton extends StatefulWidget {
  final String text;

  const ChoiceButton({Key? key, required this.text}) : super(key: key);

  @override
  _ChoiceButtonState createState() => _ChoiceButtonState();
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
                    ChoiceButton(
                      text: 'Feliz',
                    ),
                    SizedBox(width: 10),
                    ChoiceButton(
                      text: 'Triste',
                    ),
                    SizedBox(width: 10),
                    ChoiceButton(
                      text: 'Com Raiva',
                    ),
                    // Adicione mais botões para outros gêneros desejados
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceButton(
                      text: 'Ansioso',
                    ),
                    SizedBox(width: 10),
                    ChoiceButton(
                      text: 'Apaixonado',
                    ),
                    SizedBox(width: 10),
                    ChoiceButton(
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
                    ChoiceButton(
                      text: 'Ação',
                    ),
                    SizedBox(width: 10),
                    ChoiceButton(
                      text: 'Animação',
                    ),
                    SizedBox(width: 10),
                    ChoiceButton(
                      text: 'Comédia',
                    ),
                    // Adicione mais botões para outros gêneros desejados
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceButton(
                      text: 'Drama',
                    ),
                    SizedBox(width: 10),
                    ChoiceButton(
                      text: 'Fantasia',
                    ),
                    SizedBox(width: 10),
                    ChoiceButton(
                      text: 'Musical',
                    ),
                    SizedBox(width: 10),
                    ChoiceButton(
                      text: 'Terror',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceButton(
                      text: 'Romance',
                    ),
                    SizedBox(width: 10),
                    ChoiceButton(
                      text: 'Ficção Científica',
                    ),
                    SizedBox(width: 10),
                    ChoiceButton(
                      text: 'Suspense',
                    ),
                  ],
                ),
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

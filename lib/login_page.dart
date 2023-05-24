import 'package:cinemood/sign_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 150,
              ),
              const SizedBox(height: 20),
              Container(
                width: screenWidth * 0.85, // Largura desejada para os campos de texto
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: const Color(0xFFE25265),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: TextField(
                  controller: emailController,
                  style: const TextStyle(
                    fontSize: 20, // Tamanho de texto desejado
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    contentPadding: EdgeInsets.all(20.0),
                    hintStyle:
                    TextStyle(color: Color(0xFFE25265), fontSize: 17),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: screenWidth * 0.85, // Largura desejada para os campos de texto
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: const Color(0xFFE25265),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: TextField(
                  controller: senhaController,
                  style: const TextStyle(
                    fontSize: 20, // Tamanho de texto desejado
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Senha',
                    contentPadding: EdgeInsets.all(20.0),
                    hintStyle:
                    TextStyle(color: Color(0xFFE25265), fontSize: 17),
                    border: InputBorder.none,
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth * 0.35, // Largura desejada para os botões
                    child: ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: senhaController.text.trim(),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFE25265),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 16), // Tamanho de texto desejado
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 34), // Espaçamento entre os botões
                  SizedBox(
                    width: screenWidth * 0.35, // Largura desejada para os botões
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFE25265),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(fontSize: 16), // Tamanho de texto desejado
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cinemood/login_e_cadastro/sign_page.dart';
import 'package:cinemood/telas_para_cada_botao_do_navigation/home_page.dart';

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
                width: screenWidth *
                    0.85, // Largura desejada para os campos de texto
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
                width: screenWidth *
                    0.85, // Largura desejada para os campos de texto
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
                    width:
                        screenWidth * 0.35, // Largura desejada para os botões
                    child: ElevatedButton(
                      onPressed: () {
                        String email = emailController.text.trim();
                        String password = senhaController.text.trim();
                        _loginUser(email, password);
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
                          style: TextStyle(
                              fontSize: 16), // Tamanho de texto desejado
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 34), // Espaçamento entre os botões
                  SizedBox(
                    width:
                        screenWidth * 0.35, // Largura desejada para os botões
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
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
                          style: TextStyle(
                              fontSize: 16), // Tamanho de texto desejado
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

  void _loginUser(String email, String password) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((authResult) {
      if (authResult.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    }).catchError((error) {
      String errorMessage = 'Ocorreu um erro ao efetuar o login.';

      if (error is FirebaseAuthException) {
        if (error.code == 'user-not-found') {
          errorMessage = 'Usuário não encontrado.';
        } else if (error.code == 'wrong-password') {
          errorMessage = 'Senha incorreta.';
        }
      }

      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('Erro',
                style: TextStyle(fontSize: 18, color: Colors.red)),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: const Text('Fechar'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }
}

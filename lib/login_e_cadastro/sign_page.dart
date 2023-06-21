import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cinemood/constantes/cores.dart';
import 'package:cinemood/telas_para_cada_botao_do_navigation/home_page.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFE25265),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: nameController,
              obscureText: true,
              style: const TextStyle(
                fontSize: 17, // Tamanho de texto desejado
                color: AppColors.vermelho,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: 'Nome',
                contentPadding: EdgeInsets.all(20.0),
                hintStyle: const TextStyle(
                    color: AppColors.vermelho,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.5, color: AppColors.vermelho),
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: emailController,
              obscureText: true,
              style: const TextStyle(
                fontSize: 17, // Tamanho de texto desejado
                color: AppColors.vermelho,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: 'Email',
                contentPadding: EdgeInsets.all(20.0),
                hintStyle: const TextStyle(
                    color: AppColors.vermelho,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.5, color: AppColors.vermelho),
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Senha',
                contentPadding: EdgeInsets.all(20.0),
                hintStyle: const TextStyle(
                    color: AppColors.vermelho,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.5, color: AppColors.vermelho),
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              obscureText: true,
              style: const TextStyle(
                fontSize: 17, // Tamanho de texto desejado
                color: AppColors.vermelho,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final String name = nameController.text.trim();
                final String email = emailController.text.trim();
                final String password = passwordController.text.trim();

                _registerUser(context, name, email, password);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFFE25265),
                ),
              ),
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _registerUser(
      BuildContext context, String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update user display name
      await userCredential.user?.updateDisplayName(name);

      // Navigate to home page
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showSnackBar(context, 'A senha fornecida é fraca.');
      } else if (e.code == 'email-already-in-use') {
        _showSnackBar(context, 'Já existe uma conta para este email.');
      }
    } catch (e) {
      _showSnackBar(context, 'Ocorreu um erro ao cadastrar o usuário.');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

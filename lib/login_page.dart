import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('CineMood'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.black,
                    )),
                width: MediaQuery.of(context).size.width - 50,
                child: TextField(
                  controller: emailController,
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                      hintText: '  Email',
                      hintStyle: TextStyle(color: Colors.black, fontSize: 30),
                      border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.black,
                    )),
                width: MediaQuery.of(context).size.width - 50,
                child: TextField(
                  controller: senhaController,
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                      hintText: '  Senha',
                      hintStyle: TextStyle(color: Colors.black, fontSize: 30),
                      border: InputBorder.none),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: senhaController.text.trim());
                },
                child: Text('Login')),


            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: senhaController.text.trim());
                },
                child: Text('Cadastrar')),
          ],
        ),
      ),
    );
  }
}

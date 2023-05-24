import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cinemood/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE25265),
        title: const Text(
          'CineMood',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              '${user?.email?.split('@').first}',
              style: const TextStyle(fontSize: 40),
            ),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  }).catchError((error) {
                    print('Error signing out: $error');
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFFE25265),
                  ),
                ),
                child: const Text('Sair da conta')),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cinemood/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
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
                    MaterialPageRoute(builder: (context) => const LoginPage()),
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
              child: const Text('Sair da conta'),
            ),
          ],
        ),
      ),
    );
  }
}

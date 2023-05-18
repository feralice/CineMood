import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final users = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('HomeTeste'),
      ),
      body: SafeArea(
        child: Column(

          children: [
            Text('${users?.email?.split('@').first}', style: TextStyle(fontSize: 40)),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Text('Sair da conta')),
          ],
        ),
      )
    );
  }
}

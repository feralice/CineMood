import 'package:cinemood/telas_para_cada_botao_do_navigation/perfil/configs.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../constantes/cores.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 70,
                    // aqui vamos ajeitar depois
                    //backgroundImage: NetworkImage(user?.photoURL ?? ''),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${user?.displayName}',
                    style: const TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(
                    color: Color(0xFF93AECA),
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  ListTile(
                    title: const Text(
                      'Filmes vistos',
                      style: TextStyle(
                          fontSize: 18, color: AppColors.verde_escuro),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.verde_escuro,
                    ),
                    onTap: () {
                      // Tenho que fzr a lógica para editar informações
                    },
                  ),
                  const Divider(
                    color: Color(0xFF93AECA),
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  ListTile(
                    title: const Text(
                      'Filmes para ver',
                      style: TextStyle(
                          fontSize: 18, color: AppColors.verde_escuro),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.verde_escuro,
                    ),
                    onTap: () {
                      //  Tenho que fzr a lógica para alterar senha
                    },
                  ),
                  const Divider(
                    color: Color(0xFF93AECA),
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
                icon: const Icon(
                  Icons.settings,
                  color: AppColors.verde_botoes,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

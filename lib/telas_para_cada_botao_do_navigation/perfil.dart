import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cinemood/login_e_cadastro/login_page.dart';
import '../../constantes/cores.dart';

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
                  CircleAvatar(
                    radius: 50,
                    // aqui vamos ajeitar depois
                    backgroundImage: NetworkImage(user?.photoURL ?? ''),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${user?.displayName}',
                    style: const TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Action when "Filmes Vistos" button is pressed
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFE25265),
                      ),
                    ),
                    child: const Text('Filmes Vistos'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Action when "Filmes para Ver" button is pressed
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFE25265),
                      ),
                    ),
                    child: const Text('Filmes para Ver'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Action when "Filmes Vistos" button is pressed
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFE25265),
                      ),
                    ),
                    child: const Text('Configurações de Streaming'),
                  ),
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

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CineMood',
          style: TextStyle(
            color: AppColors.vermelho,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.azul,
        iconTheme: const IconThemeData(
            color:
                AppColors.vermelho), // Altera a cor do ícone da seta de volta
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Tela de configurações',
            ),
            const SizedBox(height: 60),
            const Divider(
              color: Color(0xFF93AECA),
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
            ListTile(
              title: const Text(
                'Editar informações',
                style: TextStyle(fontSize: 20),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
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
                'Alterar senha e e-mail',
                style: TextStyle(fontSize: 20),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
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
            ListTile(
              title: const Text(
                'Sobre nós',
                style: TextStyle(fontSize: 20),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onTap: () {
                //  Tenho que fzr a lógica para a seção "Sobre nós"
              },
            ),
            const Divider(
              color: Color(0xFF93AECA),
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
            const SizedBox(height: 20),
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

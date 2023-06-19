import 'package:cinemood/telas_para_cada_botao_do_navigation/perfil/altera_dados.dart';
import 'package:cinemood/telas_para_cada_botao_do_navigation/perfil/senha.dart';
import 'package:cinemood/telas_para_cada_botao_do_navigation/perfil/sobre_nos.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cinemood/login_e_cadastro/login_page.dart';
import '../../../constantes/cores.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configurações',
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
      body: SafeArea(
        child: Center(
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
                  'Editar informações',
                  style: TextStyle(fontSize: 18, color: AppColors.verde_escuro),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.verde_escuro,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangeNamePage()),
                  );
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
                  'Alterar senha',
                  style: TextStyle(fontSize: 18, color: AppColors.verde_escuro),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.verde_escuro,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangePasswordPage()),
                  );
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
                  style: TextStyle(fontSize: 18, color: AppColors.verde_escuro),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.verde_escuro,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
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
                child: const Text('Sair da conta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

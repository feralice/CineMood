import 'package:flutter/material.dart';
import '../constantes/app_bar_usado.dart';
import 'Perguntas_escolha/escolha_filme.dart';
import 'perfil/perfil.dart';
import 'Home/filmes_home.dart';
import 'package:cinemood/constantes/cores.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  Widget getView() {
    if (_selectedIndex == 0) {
      return FilmeHome();
    } else if (_selectedIndex == 1) {
      return FilmeEscolha();
    } else {
      return const ProfilePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCinemood(),

      body: getView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: AppColors.azul,
        unselectedItemColor:
        AppColors.verde_botoes.withOpacity(0.5), // Transparência de 0.5
        selectedItemColor: AppColors.verde_botoes,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Escolha',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

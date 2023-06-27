import 'package:flutter/material.dart';
import 'package:cinemood/constantes/cores.dart';

class AppBarCinemood extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const AppBarCinemood({
    Key? key,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/images/pipoca.png',
            width: 25,
            height: 28,
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'CineMood',
              style: TextStyle(
                color: AppColors.vermelho,
                fontWeight: FontWeight.bold,
                fontFamily: 'BILYALAYEREDBASE',
                fontSize: 15,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.azul,
      iconTheme: IconThemeData(color: AppColors.vermelho), //cor da seta de voltar
    );
  }
}

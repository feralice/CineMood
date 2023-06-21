import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../constantes/cores.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _errorMessage;

  void _changePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!,
            password: _currentPasswordController.text,
          );
          await user.reauthenticateWithCredential(credential);
          await user.updatePassword(_newPasswordController.text);
          Navigator.pop(context);
        } else {
          setState(() {
            _errorMessage = 'Usuário não autenticado.';
          });
        }
      } catch (error) {
        setState(() {
          _errorMessage = 'Erro ao alterar a senha: $error';
        });
      }
    }
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Alterar Senha',
          style: TextStyle(
            color: AppColors.vermelho,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.azul,
        iconTheme: const IconThemeData(color: AppColors.vermelho),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _currentPasswordController,
                decoration: InputDecoration(
                  hintText: 'Senha Atual',
                  contentPadding: EdgeInsets.all(20.0),
                  hintStyle: const TextStyle(
                      color: AppColors.vermelho,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 0.5, color: AppColors.vermelho),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira a senha atual.';
                  }
                  return null;
                },
                obscureText: true,
                style: const TextStyle(
                  fontSize: 17, // Tamanho de texto desejado
                  color: AppColors.vermelho,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  hintText: 'Nova Senha',
                  contentPadding: EdgeInsets.all(20.0),
                  hintStyle: const TextStyle(
                      color: AppColors.vermelho,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 0.5, color: AppColors.vermelho),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira a nova senha.';
                  }
                  return null;
                },
                obscureText: true,
                style: const TextStyle(
                  fontSize: 17, // Tamanho de texto desejado
                  color: AppColors.vermelho,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  hintText: 'Confirmar Nova Senha',
                  contentPadding: EdgeInsets.all(20.0),
                  hintStyle: const TextStyle(
                      color: AppColors.vermelho,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 0.5, color: AppColors.vermelho),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, confirme a senha.';
                  }
                  if (value != _newPasswordController.text) {
                    return 'As senhas não coincidem.';
                  }
                  return null;
                },
                obscureText: true,
                style: const TextStyle(
                  fontSize: 17, // Tamanho de texto desejado
                  color: AppColors.vermelho,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _changePassword,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFFE25265),
                  ),
                ),
                child: const Text('Alterar Senha'),
              ),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

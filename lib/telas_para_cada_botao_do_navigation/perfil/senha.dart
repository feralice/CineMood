import 'package:cinemood/telas_para_cada_botao_do_navigation/perfil/configs.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cinemood/login_e_cadastro/login_page.dart';
import '../../../constantes/cores.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _errorMessage;

  void _changePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
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
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alterar Senha'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(labelText: 'Nova Senha'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira a nova senha.';
                  }
                  return null;
                },
                obscureText: true,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirmar Senha'),
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
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _changePassword,
                child: Text('Alterar Senha'),
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

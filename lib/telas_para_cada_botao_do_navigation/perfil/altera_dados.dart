import 'package:cinemood/constantes/cores.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangeNamePage extends StatefulWidget {
  @override
  _ChangeNamePageState createState() => _ChangeNamePageState();
}

class _ChangeNamePageState extends State<ChangeNamePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String? _nameErrorMessage;
  String? _emailErrorMessage;
  bool _isUpdating = false;
  String? _currentName;
  String? _currentEmail;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUserInfo();
  }

  void _fetchCurrentUserInfo() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _currentName = user.displayName;
        _currentEmail = user.email;
      });
    }
  }

  void _updateInformation() async {
    if (_formKey.currentState!.validate()) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        setState(() {
          _isUpdating = true;
        });

        String newName = _nameController.text.trim();
        String newEmail = _emailController.text.trim();

        if (newName.isEmpty && newEmail.isEmpty) {
          setState(() {
            _nameErrorMessage = 'Nenhuma alteração foi feita.';
          });
          return;
        }

        try {
          if (newName.isNotEmpty) {
            await user.updateDisplayName(newName);
          }
          if (newEmail.isNotEmpty) {
            await user.updateEmail(newEmail);
          }
          _fetchCurrentUserInfo();
          Navigator.pop(context);
        } catch (error) {
          setState(() {
            _nameErrorMessage = 'Erro ao atualizar as informações: $error';
          });
        }

        setState(() {
          _isUpdating = false;
        });
      } else {
        setState(() {
          _nameErrorMessage = 'Usuário não autenticado.';
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar Informações',
          style: TextStyle(
            color: AppColors.vermelho,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.azul,
        iconTheme: const IconThemeData(color: AppColors.vermelho),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Nome Atual: ${_currentName ?? 'Não disponível'}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.vermelho,
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Novo Nome',
                  contentPadding: EdgeInsets.all(20.0),
                  hintStyle: const TextStyle(
                    color: AppColors.vermelho,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 0.5, color: AppColors.vermelho),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 17,
                  color: AppColors.vermelho,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Email Atual: ${_currentEmail ?? 'Não disponível'}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.vermelho,
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Novo Email',
                  contentPadding: EdgeInsets.all(20.0),
                  hintStyle: const TextStyle(
                    color: AppColors.vermelho,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 0.5, color: AppColors.vermelho),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 17,
                  color: AppColors.vermelho,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isUpdating ? null : _updateInformation,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFFE25265),
                  ),
                ),
                child: _isUpdating
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.verde_escuro),
                      )
                    : const Text('Alterar Informações'),
              ),
              if (_nameErrorMessage != null)
                Text(
                  _nameErrorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

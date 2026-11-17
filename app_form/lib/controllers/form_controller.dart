import 'package:flutter/material.dart';

class FormController {
  static const users = <String, String>{
    'alejandro@example.com': 'alejandro1234',
    'diego@example.com': 'diego1234',
    'miguell@example.com': 'miguell1234',
  };
  static const userNames = <String, String>{
    'alejandro@example.com': 'Alejandro',
    'diego@example.com': 'Diego',
    'miguell@example.com': 'Miguell',
  };

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool validate() => formKey.currentState?.validate() ?? false;

  bool authenticate() {
    final email = emailController.text.trim();
    final password = passwordController.text;
    return users[email] == password;
  }

  String authenticatedUserName() {
    return userNames[emailController.text.trim()] ?? 'Usuario';
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingresa tu correo electrónico';
    }

    if (!value.contains('@')) {
      return 'Ingresa un correo electrónico válido';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingresa tu contraseña';
    }

    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }

    return null;
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}

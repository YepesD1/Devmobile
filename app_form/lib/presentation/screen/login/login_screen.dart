import 'package:app_form/controllers/form_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formController = FormController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formController.validate()) {
      return;
    }

    if (_formController.authenticate()) {
      context.go(
        '/dashboard',
        extra: {
          'email': _formController.emailController.text.trim(),
          'name': _formController.authenticatedUserName(),
        },
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Correo o contraseña incorrectos')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Form(
        key: _formController.formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Icon(Icons.lock_outline, size: 72),
            const SizedBox(height: 24),
            TextFormField(
              controller: _formController.emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: _formController.validateEmail,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _formController.passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: const Icon(Icons.lock_outline),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              validator: _formController.validatePassword,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.login),
              label: const Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}

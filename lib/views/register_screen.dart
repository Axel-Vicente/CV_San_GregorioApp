import 'dart:async';

import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'register_success_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();

  bool _loading = false;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Introduce un email';
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return 'Email no válido';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.length < 6) return 'Contraseña mínima de 6 caracteres';
    return null;
  }

  void register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      print('aaa ${emailController.text}');
      print('aaa ${emailController.value}');
      print('aa ${passwordController.text}');
      print('a ${passwordController.value}');
      final credential = await authService.registerWithEmail(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      print('✅ Usuario registrado: ${credential.user?.uid}');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RegisterSuccessScreen()),
      );
    } catch (e, stackTrace) {
      print('🧨 Error inesperado: $e');
      print('📄 Stacktrace:\n$stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error inesperado")),
      );
    } finally {
        setState(() => _loading = false);
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: validateEmail,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Contraseña"),
                validator: validatePassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 20),
              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: register,
                      child: const Text("Registrarse"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;
  String? _error;
  late FocusNode _emailFocus;

  @override
  void initState() {
    super.initState();
    _emailFocus = FocusNode();
    _emailFocus.addListener(() {
      if (!_emailFocus.hasFocus) {
        _formKey.currentState!.validate();
      }
    });
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    super.dispose();
  }

  String? validateEmail(String? value) {
      const pattern =
          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
      final regex = RegExp(pattern);

      if (value == null || value.isEmpty) {
        return 'El correo es obligatorio';
      } else if (!regex.hasMatch(value)) {
        return 'Correo no válido';
      }
      return null;
  }

  void _login() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _error = e.message;
      });
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset('lib/assets/images/app_icon.png', height: 120),
                  const SizedBox(height: 32),

                  // Email
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocus,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: validateEmail,
                  ),
                  const SizedBox(height: 20),

                  // Contraseña
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    validator: (value) =>
                        value != null && value.length < 6
                            ? 'Mínimo 6 caracteres'
                            : null,
                  ),
                  const SizedBox(height: 20),

                  // Error
                  if (_error != null)
                    Text(
                      _error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 16),

                  // Botón login o cargando
                  _loading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _login();
                            }
                          },
                          child: const Text("Iniciar sesión"),
                        ),

                  // Ir a registro
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: const Text("¿No tienes cuenta? Regístrate aquí"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

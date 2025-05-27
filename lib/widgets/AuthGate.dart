import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:volley_tracker/views/home_screen.dart';
import 'package:volley_tracker/views/login_screen.dart';

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return const MainNavigationScreen(); // Usuario autenticado
        } else {
          return const LoginScreen(); // Usuario no autenticado
        }
      },
    );
  }
}

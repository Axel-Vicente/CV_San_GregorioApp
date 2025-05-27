import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:volley_tracker/models/player.dart';
import 'package:volley_tracker/views/edit_profile_screen.dart';
import 'package:volley_tracker/views/home_screen.dart';
import 'package:volley_tracker/views/register_success_screen.dart';
import 'package:volley_tracker/widgets/AuthGate.dart';
import 'package:volley_tracker/widgets/SGTheme.dart';
import 'core/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CV San Gregorio App',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: AuthGate(),
      routes: {
        '/register_success': (context) => const RegisterSuccessScreen(),
        '/home': (context) => const MainNavigationScreen(),
        '/editProfile': (context) {
          final player = ModalRoute.of(context)!.settings.arguments as Player;
          return EditProfileScreen(player: player);
        },
      },
    );
  }
}

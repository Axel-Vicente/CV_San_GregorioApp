import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:volley_tracker/models/player.dart';
import 'package:volley_tracker/views/player_profile_screen.dart';
import 'package:volley_tracker/views/training_screen.dart';
import 'package:volley_tracker/views/stats_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreen();
}

class _MainNavigationScreen extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const StatsScreen(),
    const TrainingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final uid = FirebaseAuth.instance.currentUser?.uid;
          if (uid == null) return;

          final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
          if (!doc.exists) return;

          final player = Player.fromFirestore(doc);
          final isCoach = player.rol == "coach" ? true : false;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlayerProfileScreen(
                player: player,
                isTrainer: isCoach,
              ),
            ),
          );
        },
        backgroundColor: Colors.red,
        shape: const CircleBorder(),
        child: const Icon(Icons.person, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[900],
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.home_rounded, color: _selectedIndex == 0 ? Colors.red : Colors.white70),
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: Icon(Icons.bar_chart_rounded, color: _selectedIndex == 1 ? Colors.red : Colors.white70),
                onPressed: () => _onItemTapped(1),
              ),
              const SizedBox(width: 48), // espacio para el FAB
              IconButton(
                icon: Icon(Icons.sports_volleyball_rounded, color: _selectedIndex == 2 ? Colors.red : Colors.white70),
                onPressed: () => _onItemTapped(2),
              ),
              IconButton(
                icon: Icon(Icons.settings, color: Colors.white70),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Pantallas placeholder
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("Home"));
}

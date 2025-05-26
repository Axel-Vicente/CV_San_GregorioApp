import 'package:flutter/material.dart';
import 'package:volley_tracker/models/player.dart';

class PlayerProfileScreen extends StatelessWidget {
  final Player player;
  final bool isTrainer;

  const PlayerProfileScreen({
    super.key,
    required this.player,
    required this.isTrainer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Header
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Container(
              color: Colors.grey[900],
              padding: const EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
              width: double.infinity,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: null, // NetworkImage(player.imagenPerfil),
                    radius: 35,
                    backgroundColor: Colors.grey[800],
                    child: const Icon(Icons.person, color: Colors.red, size: 50),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      "Bienvenido ${player.nombre}!",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Contenido del perfil
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  InfoRow(label: "Edad", value: "{player}"),
                  InfoRow(label: "Altura", value: "{player.altura}"),
                  InfoRow(label: "Posición", value: "player.posicion"),
                  const SizedBox(height: 20),
                  if (isTrainer)
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/editarPerfil',
                          arguments: player,
                        );
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text("Editar Perfil"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$label:", style: const TextStyle(color: Colors.white70)),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

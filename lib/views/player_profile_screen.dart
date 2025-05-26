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
      appBar: AppBar(
        title: Text("Bienvenido ${player.nombre}!"),
        backgroundColor: Colors.grey[800]!,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: null,//NetworkImage(player.imagenPerfil),
              radius: 50,
            ),
            const SizedBox(height: 16),
            Text(
              player.nombre,
              style: const TextStyle(color: Colors.white, fontSize: 22),
            ),
            const SizedBox(height: 8),
            InfoRow(label: "Edad", value: "{player.edad}"),
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

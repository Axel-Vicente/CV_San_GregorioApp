import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:volley_tracker/models/player.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PlayerProfileScreen extends StatelessWidget {
  final String playerId;
  final bool isTrainer;

  const PlayerProfileScreen({
    super.key,
    required this.playerId,
    required this.isTrainer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(playerId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text(
                'Jugador no encontrado',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final player = Player.fromFirestore(snapshot.data!);

          return Column(
            children: [
              // Header
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Container(
                  color: Colors.grey[900],
                  padding: const EdgeInsets.only(
                    top: 30,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  width: double.infinity,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: player.imagenPerfil.isNotEmpty
                            ? NetworkImage(player.imagenPerfil)
                            : null,
                        radius: 35,
                        backgroundColor: Colors.grey[800],
                        child: player.imagenPerfil.isEmpty
                            ? const Icon(
                                Icons.person,
                                color: Colors.red,
                                size: 50,
                              )
                            : null,
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
                  child: Animate(
                    effects: [
                      FadeEffect(duration: 400.ms),
                      SlideEffect(
                        begin: const Offset(0, 0.1),
                        end: Offset.zero,
                        duration: 400.ms,
                        curve: Curves.easeOut,
                      ),
                    ],
                    child: Card(
                      color: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoRow(label: "Nombre", value: player.nombre),
                            const Divider(color: Colors.grey),
                            InfoRow(label: "Edad", value: "${player.edad}"),
                            const Divider(color: Colors.grey),
                            InfoRow(
                              label: "Altura",
                              value: "${player.altura} cm",
                            ),
                            const Divider(color: Colors.grey),
                            InfoRow(
                              label: "Dorsal",
                              value: "${player.numeroDorsal}",
                            ),
                            const Divider(color: Colors.grey),
                            InfoRow(label: "Posición", value: player.posicion),
                            const Divider(color: Colors.grey),
                            InfoRow(label: "Email", value: player.email),
                            const Divider(color: Colors.grey),
                            if (isTrainer) ...[
                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/editProfile',
                                      arguments: player,
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                  label: const Text("Editar Perfil"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
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

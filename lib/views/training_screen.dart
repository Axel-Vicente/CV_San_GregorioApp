import 'dart:ui';
import 'package:flutter/material.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  void _showWarmUpDialog(
    BuildContext context,
    String tag,
    String title,
    String duration,
    String image,
    String description,
  ) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Stack(
          children: [
            // Fondo con blur
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.black.withOpacity(0)),
            ),
            Center(
              child: Hero(
                tag: tag,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Stack(
                      children: [
                        // Tarjeta principal
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 40), // espacio para botón
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  image,
                                  height: 140,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    duration,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                description,
                                style: const TextStyle(color: Colors.white70),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        // Botón superpuesto arriba a la izquierda
                        Positioned(
                          top: 16,
                          left: 16,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTrainingCard({
    required BuildContext context,
    required String tag,
    required String title,
    required String duration,
    required String image,
    required String description,
  }) {
    return GestureDetector(
      onTap: () =>
          _showWarmUpDialog(context, tag, title, duration, image, description),
      child: Hero(
        tag: tag,
        child: Card(
          color: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  image,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      duration,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Entrenamiento"),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTrainingCard(
            context: context,
            tag: 'warmupCard',
            title: 'Calentamiento',
            duration: "5'",
            image: 'lib/assets/images/warmup.jpg',
            description:
                'Realiza estiramientos dinámicos durante 5 minutos antes de comenzar.',
          ),
          _buildTrainingCard(
            context: context,
            tag: 'coreCard',
            title: 'Core',
            duration: "10'",
            image: 'lib/assets/images/warmup.jpg',
            description:
                'Circuito de abdominales para fortalecer el core y mejorar estabilidad.',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volley_tracker/models/player.dart';

class EditProfileScreen extends StatefulWidget {
  final Player player;

  const EditProfileScreen({super.key, required this.player});

  @override
  State<EditProfileScreen> createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditProfileScreen> {
  late TextEditingController nombreController;
  late TextEditingController edadController;
  late TextEditingController alturaController;
  late TextEditingController posicionController;
  late TextEditingController dorsalController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.player.nombre);
    edadController = TextEditingController(text: widget.player.edad.toString());
    alturaController = TextEditingController(
      text: widget.player.altura.toString(),
    );
    posicionController = TextEditingController(text: widget.player.posicion);
    dorsalController = TextEditingController(
      text: widget.player.numeroDorsal.toString(),
    );
    emailController = TextEditingController(text: widget.player.email);
  }

  @override
  void dispose() {
    nombreController.dispose();
    edadController.dispose();
    alturaController.dispose();
    posicionController.dispose();
    dorsalController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _guardarCambios() async {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.player.id);

    await docRef.update({
      'nombre': nombreController.text,
      'edad': int.tryParse(edadController.text) ?? 0,
      'altura': int.tryParse(alturaController.text) ?? 0,
      'posicion': posicionController.text,
      'numeroDorsal': int.tryParse(dorsalController.text) ?? 0,
      'email': emailController.text,
    });

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Editar Perfil"),
        backgroundColor: Colors.grey[900],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTextField("Nombre", nombreController),
            _buildTextField("Edad", edadController, isNumber: true),
            _buildTextField("Altura (cm)", alturaController, isNumber: true),
            _buildTextField("Dorsal", dorsalController, isNumber: true),
            _buildTextField("Posición", posicionController),
            _buildTextField("Email", emailController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardarCambios,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.grey[850],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

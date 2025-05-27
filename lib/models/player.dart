import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  final String id;
  final String nombre;
  final String email;
  final String rol;
  final String uid;
  final String posicion;
  final String imagenPerfil;
  final int edad;
  final int altura;
  final int numeroDorsal;
  final DateTime creadoEn;

  Player({
    required this.id,
    required this.nombre,
    required this.email,
    required this.rol,
    required this.uid,
    required this.creadoEn,
    this.posicion = "",
    this.imagenPerfil = "",
    this.edad = 0,
    this.altura = 0,
    this.numeroDorsal = 0,
  });

  factory Player.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Player(
      id: doc.id,
      nombre: data['name'] ?? '',
      email: data['email'] ?? '',
      rol: data['role'] ?? '',
      uid: data['uid'] ?? '',
      posicion: data['posicion'] ?? '',
      imagenPerfil: data['imagenPerfil'] ?? '',
      edad: data['edad'] ?? 0,
      altura: data['altura'] ?? 0,
      numeroDorsal: data['numeroDorsal'] ?? 0,
      creadoEn: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}

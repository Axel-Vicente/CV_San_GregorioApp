import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  final String id;
  final String nombre;
  final String email;
  final String rol;
  final String uid;
  final DateTime creadoEn;

  Player({
    required this.id,
    required this.nombre,
    required this.email,
    required this.rol,
    required this.uid,
    required this.creadoEn,
  });

  factory Player.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Player(
      id: doc.id,
      nombre: data['name'] ?? '',
      email: data['email'] ?? '',
      rol: data['role'] ?? '',
      uid: data['uid'] ?? '',
      creadoEn: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}

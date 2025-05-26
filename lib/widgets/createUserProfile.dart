import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> createUserProfile(String name) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);

    await userDoc.set({
      'uid': user.uid,
      'email': user.email,
      'name': name,
      'role': 'player',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}

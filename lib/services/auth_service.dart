import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> registerWithEmail(String email, String password) {
    return _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> loginWithEmail(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

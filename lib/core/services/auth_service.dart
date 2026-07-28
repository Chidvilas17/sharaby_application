import 'package:firebase_auth/firebase_auth.dart';

/// Clean wrapper around Firebase Authentication to abstract logic from UI
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream of user auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Current logged in user
  User? get currentUser => _auth.currentUser;

  // Login with Email and Password (Firebase Auth)
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  // Register with Email and Password (Firebase Auth)
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  // Send Password Reset Email
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

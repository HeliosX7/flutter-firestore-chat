import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthImplementation {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<void> signOut();
  Future<String> getCurrentUserId();
  Future<String> getCurrentUserEmail();
}

class Auth implements AuthImplementation {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return authResult.toString();
  }

  Future<String> signUp(String email, String password) async {
    AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return authResult.toString();
  }

  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

  Future<String> getCurrentUserId() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  Future<String> getCurrentUserEmail() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.email;
  }
}

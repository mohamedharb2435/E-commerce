import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User? get currentUser ;
  Stream<User?> authStateChanges();
  Future<User?> loginWithEmailAndPassword(String email, String password);
  Future<User?> signupWithEmailAndPassword(String email, String password);
  Future<void> logOut();
}

class Auth implements AuthBase {
  final _fireBaseAuth = FirebaseAuth.instance;
  @override
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    final userAuth = await _fireBaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return userAuth.user;
  }

  @override
  Future<User?> signupWithEmailAndPassword(
      String email, String password) async {
    final userAuth = await _fireBaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userAuth.user;
  }

  @override
  Stream<User?> authStateChanges() =>_fireBaseAuth.authStateChanges();

  @override
  User? get currentUser => _fireBaseAuth.currentUser;

  @override
  Future<void> logOut()async => await _fireBaseAuth.signOut();
}

import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> signUp(String email, String password) async {
    final usercred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return usercred;
  }

  Future<UserCredential> signIn(String email, String password) async {
    final usercred = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return usercred;
  }
}

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

  // GET UID
  Future<String> getEmail() async {
    return (_auth.currentUser).email;
  }


  Future<void> signOut() async {
    return _auth.signOut();
  }

  // GET UID
  Future<String> getCurrentUID() async {
    return (_auth.currentUser).uid;
  }

  // GET CURRENT USER
  Future getCurrentUser() async {
    return _auth.currentUser;
  }

  // Reset Password
  Future sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }
}

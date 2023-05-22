import 'package:firebase_auth/firebase_auth.dart';

class AccountManager {
  final _auth = FirebaseAuth.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  String getFullName() {
    return _auth.currentUser != null
        ? _auth.currentUser!.displayName!
        : 'Unknown';
  }

  String getEmail() {
    return _auth.currentUser != null ? _auth.currentUser!.email! : 'Unknown';
  }

  void signOut() async {
    await _auth.signOut();
  }

  Future login({
    String email = '',
    String password = '',
  }) {
    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future register({
    String email = '',
    String password = '',
    String fullname = '',
  }) {
    return _auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((currentUser) {
      currentUser.user?.updateDisplayName(fullname);
    });
  }
}

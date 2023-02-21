import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static UserCredential? userCredential;

  static final _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;

  static Future<UserCredential> signInwithgmail() async {
    final GoogleSignInAccount? googleUSer = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUSer
        ?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential!;
  }

  static Future<void> logout() async {
    return _auth.signOut();
  }
}
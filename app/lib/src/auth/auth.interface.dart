import 'package:firebase_auth/firebase_auth.dart';

abstract class Auth {
  Future<FirebaseUser> signIn(String email, String password);
  Future<FirebaseUser> signUp(
    String email,
    String password,
    String displayName,
  );
  Future<String> getCurrentUser();
  Future<FirebaseUser> updateCurrentUser({
    String displayName,
    String photoUrl,
  });
  Future<void> signOut();
}

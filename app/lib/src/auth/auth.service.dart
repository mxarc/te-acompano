import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:te_acompano/src/shared/models/user.model.dart';

import 'auth.interface.dart';

class AuthService implements Auth {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final Firestore _firestore = Firestore.instance;
  static final StorageReference _firebaseStorageReference =
      FirebaseStorage().ref();

  Future<FirebaseUser> signIn(
    String email,
    String password,
  ) async {
    AuthResult user = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', user.user.email);
    prefs.setString('uid', user.user.uid);
    prefs.setString('displayName', user.user.displayName);
    prefs.setString('photoUrl', user.user.photoUrl);

    return user.user;
  }

  Future<FirebaseUser> signUp(
    String email,
    String password,
    String displayName,
  ) async {
    AuthResult firebaseUser =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = displayName;
    await firebaseUser.user.updateProfile(updateInfo);

    FirebaseUser currentUser = await _firebaseAuth.currentUser();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', currentUser.email);
    prefs.setString('uid', currentUser.uid);
    prefs.setString('displayName', currentUser.displayName);
    prefs.setString('photoUrl', currentUser.photoUrl);

    // send mail
    // await currentUser.sendEmailVerification();

    return currentUser;
  }

  Future<FirebaseUser> getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }

  Future<String> storeProfilePhoto(File photo) async {
    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
    StorageReference fileReference =
        _firebaseStorageReference.child('profile_pictures/' + firebaseUser.uid);

    final StorageUploadTask uploadTask = fileReference.putFile(photo);

    final StorageTaskSnapshot storageTaskSnapshot =
        (await uploadTask.onComplete);

    return await storageTaskSnapshot.ref.getDownloadURL();
  }

  Future<FirebaseUser> updateCurrentUser({
    String displayName,
    String photoUrl,
  }) async {
    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();

    UserUpdateInfo updateInfo = UserUpdateInfo();
    if (displayName != null) updateInfo.displayName = displayName;
    if (photoUrl != null) updateInfo.photoUrl = photoUrl;
    await firebaseUser.updateProfile(updateInfo);

    FirebaseUser currentUser = await _firebaseAuth.currentUser();

    User user = User();
    user.setUser({
      'email': currentUser.email,
      'displayName': currentUser.displayName,
      'uid': currentUser.uid,
      'photoUrl': currentUser.photoUrl,
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', currentUser.email);
    prefs.setString('uid', currentUser.uid);
    prefs.setString('displayName', currentUser.displayName);
    prefs.setString('photoUrl', currentUser.photoUrl);

    return currentUser;
  }

  Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    return await _firebaseAuth.signOut();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:te_acompano/src/shared/models/user.model.dart';

class DatabaseService {
  final Firestore _db = Firestore.instance;

  //un stream de un solo documento 
  Stream<UserProfile> streamUserProfile(String uid) {
    return _db
        .collection('users')
        .document(uid)
        .snapshots()
        .map((snap) => UserProfile.fromMap(snap.data));
  }
}

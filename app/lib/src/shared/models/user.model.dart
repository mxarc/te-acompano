class User {
  String _uid;
  String _email;
  String _displayName;
  String _photoUrl;

  void setUser(Map<String, dynamic> map) {
    _email = map['email'];
    _uid = map['uid'];
    _displayName = map['displayName'];
    _photoUrl = map['photoUrl'];
  }

  String get uid => _uid;
  String get email => _email;
  String get name => _displayName;
  String get photoUrl => _photoUrl;

  Map<String, String> get getUser {
    return {
      'email': _email,
      'displayName': _displayName,
      'uid': _uid,
      'photoUrl': _photoUrl,
    };
  }
}

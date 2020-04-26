import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:te_acompano/src/shared/db/db.dart';
import 'package:te_acompano/src/shared/models/user.model.dart';

class UserProfileOwner extends StatefulWidget {
  UserProfileOwner({Key key}) : super(key: key);

  @override
  _UserProfileOwnerState createState() => _UserProfileOwnerState();
}

class _UserProfileOwnerState extends State<UserProfileOwner> {
  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    if (user != null && user.uid != null) {
      return MultiProvider(
        providers: [
          StreamProvider<UserProfile>.value(
            value: DatabaseService().streamUserProfile(user.uid),
          )
        ],
        child: BuildView(),
      );
    } else {
      return Container(
        child: Text('Wait'),
      );
    }
  }
}

class BuildView extends StatefulWidget {
  const BuildView({Key key}) : super(key: key);

  @override
  _BuildViewState createState() => _BuildViewState();
}

class _BuildViewState extends State<BuildView> {
  @override
  Widget build(BuildContext context) {
    UserProfile userProfile = Provider.of<UserProfile>(context);
    // String _userName = '';
    // String _profileUrl = '';
    // if (userProfile != null) {
    //   if (userProfile.userName != null) {
    //     _userName = userProfile.userName;
    //   }
    // }

//bug enorme adelante...
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: new IconThemeData(color: Colors.grey),
        backgroundColor: Colors.white,
        primary: true,
        actions: <Widget>[],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Center(
            child: CircleAvatar(
              radius: 100.0,
              backgroundImage: AssetImage('assets/nopp.png'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            //aqui mero
            userProfile != null ? userProfile.userName : 'null',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Text(
            'Cetis 107',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Frases publicadas: 32',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
          ),
        ],
      ),
    );
  }
}

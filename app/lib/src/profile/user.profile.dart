import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
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
            'User Name',
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

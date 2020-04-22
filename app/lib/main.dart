import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:te_acompano/src/routes/routes.dart';

void main(List<String> args) {
  runApp(TeAcompanoApp());
}

class TeAcompanoApp extends StatelessWidget {
  checkSession() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final uid = sharedPreferences.get('uid').toString();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Te Acompaño',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: getAppRoutes(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:te_acompano/src/auth/auth.page.dart';

void main(List<String> args) {
  runApp(TeAcompanoApp());
}

class TeAcompanoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Te acompaño',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/': (context) => new AuthPage()},
    );
  }
}

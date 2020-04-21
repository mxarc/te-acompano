import 'package:flutter/material.dart';
import 'package:te_acompano/src/routes/routes.dart';

void main(List<String> args) {
  runApp(TeAcompanoApp());
}

class TeAcompanoApp extends StatelessWidget {
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

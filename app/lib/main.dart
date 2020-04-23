import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:te_acompano/src/auth/auth.service.dart';
import 'package:te_acompano/src/root.page.dart';
import 'package:te_acompano/src/shared/routes/routes.dart';

void main(List<String> args) {
  runApp(TeAcompanoApp());
}

class TeAcompanoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
            value: FirebaseAuth.instance.onAuthStateChanged),
      ],
      child: MaterialApp(
        title: 'Te Acompaño',
        debugShowCheckedModeBanner: false,
        home: new RootPage(auth: new AuthService()),
        routes: getAppRoutes(),
      ),
    );
  }
}

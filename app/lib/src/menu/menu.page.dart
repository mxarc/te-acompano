import 'package:flutter/material.dart';
import 'package:te_acompano/src/auth/auth.interface.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final Auth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Te acompaño')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Hola',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Mensajes'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Perfil'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Ajustes'),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Hola'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.exit_to_app),
          onPressed: () => widget.logoutCallback()),
    );
  }
}

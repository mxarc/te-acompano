import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:te_acompano/src/auth/auth.interface.dart';
import 'package:te_acompano/src/shared/widgets/info_dialog.widget.dart';

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
    final dialog = new InfoDialog(context);

    //aqui bajamos el user con provider
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    String _email = (user != null) ? user.email : '';

    return Scaffold(
      appBar: AppBar(title: Text('Te acompaño')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Hola ' + _email,
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
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Cerrar Sesion'),
              onTap: () async {
                await dialog
                    .showConfirmation(
                        'Cerrar Sesion',
                        '¿Seguro que quieres salir?',
                        null,
                        'Cancelar',
                        'Aceptar')
                    .then((value) {
                  if (value) {
                    widget.logoutCallback();
                  }
                });
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Hola'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            //do something
          }),
    );
  }
}

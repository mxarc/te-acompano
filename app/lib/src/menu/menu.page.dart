import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:te_acompano/src/auth/auth.interface.dart';
import 'package:te_acompano/src/profile/user.profile.owner.dart';
import 'package:te_acompano/src/shared/widgets/info_dialog.widget.dart';

import 'widgets/card.widget.dart';
import 'widgets/feedback.widget.dart';
import 'widgets/feel.widget.dart';

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
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: new IconThemeData(color: Colors.grey),
        backgroundColor: Colors.white,
        primary: true,
        actions: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CircleAvatar(
                radius: 18.0,
                backgroundImage: (user.photoUrl != null)
                    ? NetworkImage(user.photoUrl)
                    : AssetImage('assets/nopp.png'),
                backgroundColor: Colors.transparent,
              )),
        ],
      ),
      drawer: _buildDrawer(user),
      body: _buildMainPage(user),
    );
  }

  Widget _buildMainPage(FirebaseUser user) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    final titleStyle = TextStyle(
        color: Color.fromRGBO(62, 62, 62, 1),
        fontSize: 34,
        fontWeight: FontWeight.w700);
    final subtitleStyle = TextStyle(
      color: Color.fromRGBO(62, 62, 62, 1),
      fontSize: 24,
      fontWeight: FontWeight.w700,
    );
    return Container(
        child: ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: Colors.purpleAccent,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ListView(
                children: <Widget>[
                  Text(
                    'Hola',
                    style: titleStyle,
                  ),
                  Text(
                    user.displayName,
                    style: titleStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: <Widget>[
                    Icon(Icons.wb_sunny, color: Colors.amber),
                    SizedBox(width: 5),
                    Text('Frase del día',
                        style: Theme.of(context).textTheme.subtitle)
                  ]),
                  PhraseCardWidget(
                      phrase: 'Una frase motivadora que dijo algún wey filoso'),
                  SizedBox(height: 10),
                  Text('¿Cómo te sientes?', style: subtitleStyle),
                  FeelWidget(),
                  SizedBox(height: 10),
                  FeedbackWidget()
                ],
              ))),
    ));
  }

  Widget _buildDrawer(FirebaseUser user) {
    String _email = (user != null) ? user.email : '';
    return Drawer(
      semanticLabel: 'Abrir navegación',
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Text(
              'Te acompaño',
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
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => UserProfileOwner())),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ajustes'),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Cerrar Sesion'),
            onTap: () async {
              final dialog = new InfoDialog(context);
              await dialog
                  .showConfirmation('Cerrar Sesion',
                      '¿Seguro que quieres salir?', null, 'Cancelar', 'Aceptar')
                  .then((value) {
                if (value) {
                  widget.logoutCallback();
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:te_acompano/src/auth/auth.service.dart';
import 'package:te_acompano/src/widgets/info_dialog.widget.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _email = '';
  String _password = '';
  String _confirmationPassword = '';
  String _displayName = '';
  bool _isRegistering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [SafeArea(child: _createHeader()), _createLoginInput()],
    ));
  }

  Widget _createHeader() {
    return Column(children: [
      SizedBox(
        height: 30,
      ),
      Image(height: 120, image: AssetImage('assets/hand.png')),
      Text('Te acompaño',
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent)),
      Text('Bienvenido')
    ]);
  }

  Widget _createLoginInput() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  'Por favor introduce tus datos de usuario',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.fade,
                )),
            Divider(),
            Container(
              child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => setState(() => _email = value),
                  decoration: _createDecoration('Correo', Icon(Icons.email))),
            ),
            SizedBox(height: 20),
            Container(
                child: TextField(
                    obscureText: true,
                    onChanged: (value) => setState(() => _password = value),
                    textCapitalization: TextCapitalization.none,
                    decoration:
                        _createDecoration('Clave', Icon(Icons.lock_outline)))),
            (_isRegistering
                ? Column(children: <Widget>[
                    SizedBox(height: 20),
                    TextField(
                        obscureText: true,
                        onChanged: (value) =>
                            setState(() => _confirmationPassword = value),
                        textCapitalization: TextCapitalization.none,
                        decoration: _createDecoration(
                            'Confirma tu clave', Icon(Icons.lock_outline))),
                    SizedBox(height: 20),
                    TextField(
                        autocorrect: true,
                        keyboardType: TextInputType.text,
                        onChanged: (value) =>
                            setState(() => _displayName = value),
                        textCapitalization: TextCapitalization.none,
                        decoration: _createDecoration(
                            'Tu nombre', Icon(Icons.person_pin)))
                  ])
                : Container()),
            SizedBox(height: 15),
            Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FlatButton(
                      color: _isRegistering ? Colors.grey : Colors.blue,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: _isRegistering ? Text('Volver') : Text('Acceder'),
                      onPressed: () => _isRegistering
                          ? setState(() => _isRegistering = !_isRegistering)
                          : _doLogin(context)),
                  SizedBox(height: 5),
                  FlatButton(
                    color: _isRegistering ? Colors.blue : Colors.grey,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Text('Registrarme'),
                    onPressed: () => _isRegistering
                        ? _doRegister()
                        : setState(() {
                            _isRegistering = true;
                          }),
                  )
                ]),
          ],
        ));
  }

  Future<void> _doLogin(BuildContext context) async {
    final dialog = new InfoDialog(context);
    // do validation
    if (_email.isEmpty || _password.isEmpty) {
      await dialog.showMessage(
          'Error',
          'Necesitas rellenar todos los campos de texto',
          AssetImage('assets/warn-256.png'));
      return;
    }
    dialog.showLoading('Accediendo');
    try {
      final authResult = await new AuthService().signIn(_email, _password);
      print(authResult.email);
      print('User logged in');
      dialog.closeDialog();
      Navigator.of(context).pushNamed('/menu');
    } catch (e) {
      print('Error: ' + e.message);
      Fluttertoast.showToast(
          msg: e.message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      dialog.closeDialog();
    }
  }

  Future<void> _doRegister() async {
    print(_email);
    print(_password);
    print(_confirmationPassword);
    print(_displayName);
    final dialog = new InfoDialog(context);
    if (_email.isEmpty ||
        _password.isEmpty ||
        _confirmationPassword.isEmpty ||
        _displayName.isEmpty) {
      await dialog.showMessage(
          'Error',
          'Necesitas rellenar todos los campos de texto',
          AssetImage('assets/warn-256.png'));
      return;
    }
    if (_password != _confirmationPassword) {
      await dialog.showMessage('Error', 'Las contraseñas no coinciden',
          AssetImage('assets/warn-256.png'));
      return;
    }
    dialog.showLoading('Creando cuenta');
    try {
      final registerAuth =
          await new AuthService().signUp(_email, _password, _displayName);
      dialog.closeDialog();
      print('User registered');
      await dialog.showMessage('Cuenta creada', 'Hemos creado una cuenta nueva',
          AssetImage('assets/icons8-ok-256.png'),
          duration: Duration(seconds: 1));

      Navigator.of(context).pushNamed('/authPhoto');
    } catch (e) {
      print('Error: ' + e.message);
      Fluttertoast.showToast(
          msg: e.message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      dialog.closeDialog();
    }
  }

  InputDecoration _createDecoration(String hintText, Icon icon) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: icon,
      filled: true,
      fillColor: Colors.blueGrey.withOpacity(.1),
      contentPadding: EdgeInsets.zero,
      errorStyle: TextStyle(
        backgroundColor: Colors.orange,
        color: Colors.white,
      ),
      labelStyle: TextStyle(fontSize: 12),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade50, width: 3),
          borderRadius: BorderRadius.circular(25)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade700, width: 3),
          borderRadius: BorderRadius.circular(25)),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade700, width: 7),
        borderRadius: BorderRadius.circular(25),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade400, width: 8),
        borderRadius: BorderRadius.circular(25),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 5),
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }
}

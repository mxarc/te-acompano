import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:te_acompano/src/auth/auth.service.dart';
import 'package:te_acompano/src/shared/widgets/info_dialog.widget.dart';

class ProfilePhotoPage extends StatefulWidget {
  ProfilePhotoPage({this.loginCallback});
  final VoidCallback loginCallback;
  @override
  _ProfilePhotoPageState createState() => _ProfilePhotoPageState();
}

class _ProfilePhotoPageState extends State<ProfilePhotoPage> {
  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_forward),
          onPressed: () async {
            if (_image != null) {
              await _saveProfilePhoto(context);
            }
            widget.loginCallback();
            //Navigator.of(context).pushNamed('/menu');
          }),
      body: ListView(
        children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '¡Hey!',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('¿Qué tal si agregas una foto de perfil?'),
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                        radius: 100.0,
                        backgroundImage: _image == null
                            ? AssetImage('assets/nopp.png')
                            : FileImage(_image)),
                    SizedBox(
                      height: 10,
                    ),
                    (_image != null
                        ? Text(
                            'Te miras genial 🥳',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        : Container()),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(children: <Widget>[
                        FlatButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.camera),
                                SizedBox(width: 5),
                                Text('Tomar foto')
                              ],
                            ),
                            onPressed: () => _openCamera()),
                        SizedBox(width: 20),
                        FlatButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.photo),
                                SizedBox(width: 5),
                                Text('Abrir galeria')
                              ],
                            ),
                            onPressed: () => _openGallery()),
                      ]),
                    ),
                    /* (_image != null
                        ? Container(
                            child: FlatButton(
                                color: Colors.green,
                                textColor: Colors.white,
                                child: Text('Guardar'),
                                onPressed: () => _saveProfilePhoto(context)))
                        : Container())*/
                  ]))
        ],
      ),
    );
  }

  Future<void> _saveProfilePhoto(context) async {
    FirebaseUser user = Provider.of<FirebaseUser>(context, listen: false);

    final dialog = new InfoDialog(context);
    try {
      dialog.showLoading('Subiendo imagen');
      final profilePhoto = await new AuthService().storeProfilePhoto(_image);
      Firestore.instance
          .collection('users')
          .document(user.uid)
          .updateData({'profileUrl': profilePhoto});
      dialog.closeDialog();
      await dialog.showMessage(
          'Imagen actualizada',
          'Ahora tienes una nueva foto de perfil',
          AssetImage('assets/happy.png'));
    } catch (e) {
      print('Error');
      dialog.closeDialog();
    }
  }

  Future<void> _openCamera() async {
    print('Opening camera');
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future<void> _openGallery() async {
    print('Opening gallery');
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
}

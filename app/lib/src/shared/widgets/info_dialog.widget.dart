import 'dart:async';

import 'package:flutter/material.dart';

class InfoDialog {
  BuildContext context;

  InfoDialog(this.context);

  Future<void> showMessage(
      String title, String text, ImageProvider<dynamic> assetImage,
      {Duration duration = const Duration(seconds: 2)}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text(title),
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Image(image: assetImage, height: 100),
              SizedBox(height: 20),
              Text(text)
            ]),
          );
        });
    return Future.delayed(duration, () => this.closeDialog());
  }

  Future<bool> showConfirmation(String title, String text,
      ImageProvider<dynamic> assetImage, String cancelText, String acceptText,
      {Duration duration = const Duration(seconds: 2)}) async {
    bool _value = false;
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text(title),
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              (assetImage != null)
                  ? Image(image: assetImage, height: 100)
                  : Container(),
              SizedBox(height: 20),
              Text(text)
            ]),
            actions: <Widget>[
              FlatButton(
                color: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                onPressed: () {
                  this.closeDialog();
                  _value = false;
                },
                child: Text(
                  cancelText ?? 'Cancelar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              FlatButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                onPressed: () {
                  this.closeDialog();
                  _value = true;
                },
                child: Text(acceptText ?? 'Aceptar'),
              ),
            ],
          );
        });

    return _value;
  }

  void showLoading(String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(text),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[CircularProgressIndicator()]),
        );
      },
    );
  }

  void closeDialog() {
    Navigator.of(context).pop();
  }
}

import 'dart:async';

import 'package:flutter/material.dart';

class InfoDialog {
  BuildContext context;

  InfoDialog(this.context) {}

  void showMessage(String title, String text, AssetImage assetImage,
      {bool autoClose}) async {
    showDialog(
      context: context,
      barrierDismissible: true,
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
      },
    );
    if (autoClose) {
      print('Auto close habilitado');
      Timer(Duration(seconds: 1, milliseconds: 500), () => this.closeDialog());
    }
  }

  void showLoading(String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
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

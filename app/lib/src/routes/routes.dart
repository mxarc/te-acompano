import 'package:flutter/material.dart';
import 'package:te_acompano/src/auth/auth.page.dart';
import 'package:te_acompano/src/auth/photo.page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return {
    '/': (BuildContext context) => AuthPage(),
    '/authPhoto': (BuildContext context) => ProfilePhotoPage()
  };
}

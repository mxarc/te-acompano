import 'package:flutter/material.dart';
import 'package:te_acompano/src/auth/auth.page.dart';
import 'package:te_acompano/src/auth/photo.page.dart';
import 'package:te_acompano/src/menu/menu.page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return {
    '/': (BuildContext context) => AuthPage(),
    '/authPhoto': (BuildContext context) => ProfilePhotoPage(),
    '/menu': (BuildContext context) => MenuPage()
  };
}

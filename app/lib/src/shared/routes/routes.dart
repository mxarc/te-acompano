import 'package:flutter/material.dart';
import 'package:te_acompano/src/menu/menu.page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return {'/menu': (BuildContext context) => MenuPage()};
}

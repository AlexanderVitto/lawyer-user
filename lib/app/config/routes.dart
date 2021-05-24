import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../src/screens/signin/signin_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing
  var routes = <String, WidgetBuilder>{
    SignInScreen.routeName: (_) => SignInScreen()
  };

  WidgetBuilder builder = routes[settings.name];
  return MaterialPageRoute(settings: settings, builder: (ctx) => builder(ctx));
}

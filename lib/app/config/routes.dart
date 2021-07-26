import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../src/screens/mobile_number_verification/mobile_number_verification_scree.dart';
import '../src/screens/otp/otp_screen.dart';
import '../src/screens/signin/signin_screen.dart';
import '../src/screens/signup/signup_screen.dart';
import '../src/screens/reset_password/reset_password_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing
  var routes = <String, WidgetBuilder>{
    SignInScreen.routeName: (_) => SignInScreen(),
    MobileNumberVerificationScreen.routeName: (_) =>
        MobileNumberVerificationScreen(settings.arguments),
    OTPScreen.routeName: (_) => OTPScreen(settings.arguments),
    SignUpScreen.routeName: (_) => SignUpScreen(),
    ResetPassword.routeName: (_) => ResetPassword(),
  };

  WidgetBuilder builder = routes[settings.name];

  return PageRouteBuilder(
      settings: settings,
      pageBuilder: (ctx, __, ___) => builder(ctx),
      transitionsBuilder: (_, a, __, c) =>
          FadeTransition(opacity: a, child: c));
  //return MaterialPageRoute(settings: settings, builder: (ctx) => builder(ctx));
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../src/screens/signin/signin_screen.dart';
import '../src/screens/signup/signup_screen.dart';
import '../src/screens/forgot_password/forgot_password_screen.dart';
import '../src/screens/mobile_number_verification/mobile_number_verification_screen.dart';
import '../src/screens/otp/otp_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing
  var routes = <String, WidgetBuilder>{
    SignInScreen.routeName: (_) => SignInScreen(),
    SignUpScreen.routeName: (_) => SignUpScreen(),
    ForgotPasswordScreen.routeName: (_) => ForgotPasswordScreen(),
    MobileNumberVerificationScreen.routeName: (_) =>
        MobileNumberVerificationScreen(),
    OTPScreen.routeName: (_) => OTPScreen()
  };

  WidgetBuilder builder = routes[settings.name];

  return PageRouteBuilder(
      settings: settings,
      pageBuilder: (ctx, __, ___) => builder(ctx),
      transitionsBuilder: (_, a, __, c) =>
          FadeTransition(opacity: a, child: c));
  //return MaterialPageRoute(settings: settings, builder: (ctx) => builder(ctx));
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../src/screens/signin/signin_screen.dart';
import '../src/screens/signup/signup_screen.dart';
import '../src/screens/forgot_password/forgot_password_screen.dart';
import '../src/screens/mobile_number_verification/mobile_number_verification_screen.dart';
import '../src/screens/otp/otp_screen.dart';
import '../src/screens/main/main_screen.dart';
import '../src/screens/preference/preference_screen.dart';
import '../src/screens/psychologist/psychologist_screen.dart';
import '../src/screens/psychologist/sorting/sorting_screen.dart';
import '../src/screens/psychologist_profile/psychologist_profile_screen.dart';
import '../src/screens/book_appointment/book_appointment.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing
  var routes = <String, WidgetBuilder>{
    SignInScreen.routeName: (_) => SignInScreen(),
    SignUpScreen.routeName: (_) => SignUpScreen(),
    ForgotPasswordScreen.routeName: (_) => ForgotPasswordScreen(),
    MobileNumberVerificationScreen.routeName: (_) =>
        MobileNumberVerificationScreen(),
    OTPScreen.routeName: (_) => OTPScreen(),
    MainScreen.routeName: (_) => MainScreen(settings.arguments),
    PreferenceScreen.routeName: (_) => PreferenceScreen(settings.arguments),
    PsychologistScreen.routeName: (_) => PsychologistScreen(settings.arguments),
    SortingScreen.routeName: (_) => SortingScreen(),
    PsychologistProfileScreen.routeName: (_) =>
        PsychologistProfileScreen(settings.arguments),
    BookAppointmentScreen.routeName: (_) =>
        BookAppointmentScreen(settings.arguments)
  };

  WidgetBuilder builder = routes[settings.name];

  return PageRouteBuilder(
      settings: settings,
      pageBuilder: (ctx, __, ___) => builder(ctx),
      transitionsBuilder: (_, a, __, c) =>
          FadeTransition(opacity: a, child: c));
  //return MaterialPageRoute(settings: settings, builder: (ctx) => builder(ctx));
}

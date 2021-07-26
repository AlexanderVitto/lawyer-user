import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utils.dart' as utils;

// General provider
import '../src/providers/providers.dart';
import '../src/screens/mobile_number_verification/mobile_number_verification_provider.dart';
import '../src/screens/otp/otp_provider.dart';
import '../src/screens/signin/signin_provider.dart';
import '../src/screens/signup/signup_provider.dart';
import '../src/screens/reset_password/reset_password_provider.dart';

List<SingleChildWidget> setupProviders(SharedPreferences sharedPreferences) {
  List<SingleChildWidget> providers = [
    ...topLevelProviders(sharedPreferences),
    ...secondLinerProviders(),
    ...stateProviders()
  ];

  return providers;
}

List<SingleChildWidget> topLevelProviders(SharedPreferences sharedPreferences) {
  List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (_) => AuthGeneral(sharedPreferences),
      lazy: false,
    ),
  ];

  return providers;
}

List<SingleChildWidget> secondLinerProviders() {
  List<SingleChildWidget> providers = [
    ChangeNotifierProxyProvider<AuthGeneral, SigninProvider>(
      create: (ctx) => SigninProvider(ctx.read<AuthGeneral>()),
      update: (_, authGeneral, prevProvider) =>
          prevProvider..update(authGeneral),
    ),
    ChangeNotifierProxyProvider<AuthGeneral, MobileNumberVerificationProvider>(
      create: (ctx) =>
          MobileNumberVerificationProvider(ctx.read<AuthGeneral>()),
      update: (_, authGeneral, prevProvider) =>
          prevProvider..update(authGeneral),
    ),
    ChangeNotifierProxyProvider<AuthGeneral, OTPProvider>(
      create: (ctx) => OTPProvider(ctx.read<AuthGeneral>()),
      update: (_, authGeneral, prevProvider) =>
          prevProvider..update(authGeneral),
    ),
    ChangeNotifierProxyProvider<AuthGeneral, SignUpProvider>(
      create: (ctx) => SignUpProvider(ctx.read<AuthGeneral>()),
      update: (_, authGeneral, prevProvider) =>
          prevProvider..update(authGeneral),
    ),
    ChangeNotifierProxyProvider<AuthGeneral, ResetPasswordProvider>(
      create: (ctx) => ResetPasswordProvider(ctx.read<AuthGeneral>()),
      update: (_, authGeneral, prevProvider) =>
          prevProvider..update(authGeneral),
    ),
  ];

  return providers;
}

List<SingleChildWidget> stateProviders() {
  List<SingleChildWidget> providers = [];

  return providers;
}

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../src/screens/signup/provider/signup_provider.dart';
import '../src/screens/signin/provider/signin_provider.dart';
import '../src/screens/mobile_number_verification/provider/mobile_number_verification_provider.dart';
import '../src/screens/forgot_password/provider/forgot_password_provider.dart';
import '../src/screens/otp/provider/otp_provider.dart';
import '../src/screens/main/home/provider/home_provider.dart';
import '../src/screens/preference/provider/preference_provider.dart';
import '../src/screens/psychologist/provider/psychologist_provider.dart';
import '../src/screens/psychologist_profile/provider/psychologist_profile_provider.dart';
import '../src/screens/book_appointment/provider/book_appointment_provider.dart';
import '../src/screens/cart/provider/cart_provider.dart';
import '../src/screens/checkout/provider/checkout_provider.dart';
import '../src/screens/manual_payment/provider/manual_payment_provider.dart';
import '../src/screens/main/transaction/provider/transaction_provider.dart';

import '../utils/utils.dart' as utils;

// General provider
import '../src/providers/providers.dart';

List<SingleChildWidget> setupProviders() {
  List<SingleChildWidget> providers = [
    ...topLevelProviders(),
    ...secondLinerProviders(),
    ...stateProviders()
  ];

  return providers;
}

List<SingleChildWidget> topLevelProviders() {
  List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
        create: (_) => utils.ConnectivityUtils(), lazy: false),
    ChangeNotifierProvider(create: (_) => utils.Connection(), lazy: false)
  ];

  return providers;
}

List<SingleChildWidget> secondLinerProviders() {
  List<SingleChildWidget> providers = [
    ChangeNotifierProxyProvider<utils.Connection, Auth>(
        create: (ctx) => Auth(ctx.read<utils.Connection>()),
        update: (_, connection, prevProvider) =>
            prevProvider..update(connection),
        lazy: false),
    ChangeNotifierProxyProvider<Auth, Appointment>(
        create: (ctx) => Appointment(),
        update: (_, auth, prevProvider) => prevProvider..update(auth),
        lazy: false),
    ChangeNotifierProxyProvider<Auth, Cart>(
        create: (ctx) => Cart(),
        update: (_, auth, prevProvider) => prevProvider..update(auth),
        lazy: false),
    ChangeNotifierProxyProvider<Auth, Financial>(
        create: (ctx) => Financial(),
        update: (_, auth, prevProvider) => prevProvider..update(auth),
        lazy: false),
    ChangeNotifierProxyProvider<Auth, Notification>(
        create: (ctx) => Notification(),
        update: (_, auth, prevProvider) => prevProvider..update(auth),
        lazy: false),
    ChangeNotifierProxyProvider<Auth, Payment>(
        create: (ctx) => Payment(),
        update: (_, auth, prevProvider) => prevProvider..update(auth),
        lazy: false),
    ChangeNotifierProxyProvider<Auth, StaticData>(
        create: (ctx) => StaticData(),
        update: (_, auth, prevProvider) => prevProvider..update(auth),
        lazy: false),
    ChangeNotifierProxyProvider<Auth, Partner>(
        create: (ctx) => Partner(),
        update: (_, auth, prevProvider) => prevProvider..update(auth),
        lazy: false),
  ];

  return providers;
}

List<SingleChildWidget> stateProviders() {
  List<SingleChildWidget> providers = [
    ChangeNotifierProxyProvider<Auth, SignUpProvider>(
      create: (ctx) => SignUpProvider(ctx.read<Auth>()),
      update: (_, auth, prevProvider) => prevProvider..update(auth),
    ),
    ChangeNotifierProxyProvider<Auth, SignInProvider>(
      create: (ctx) => SignInProvider(ctx.read<Auth>()),
      update: (_, auth, prevProvider) => prevProvider..update(auth),
    ),
    ChangeNotifierProxyProvider<Auth, ForgotPasswordProvider>(
      create: (ctx) => ForgotPasswordProvider(ctx.read<Auth>()),
      update: (_, auth, prevProvider) => prevProvider..update(auth),
    ),
    ChangeNotifierProxyProvider<Auth, MobileNumberVerificationProvider>(
      create: (ctx) => MobileNumberVerificationProvider(ctx.read<Auth>()),
      update: (_, auth, prevProvider) => prevProvider..update(auth),
    ),
    ChangeNotifierProxyProvider<Auth, OTPProvider>(
      create: (ctx) => OTPProvider(ctx.read<Auth>()),
      update: (_, auth, prevProvider) => prevProvider..update(auth),
    ),
    ChangeNotifierProxyProvider5<Appointment, Financial, Notification,
        StaticData, Cart, HomeProvider>(
      create: (ctx) => HomeProvider(
        ctx.read<Appointment>(),
        ctx.read<Financial>(),
        ctx.read<Notification>(),
        ctx.read<StaticData>(),
        ctx.read<Cart>(),
      ),
      update: (_, appointment, financial, notification, staticData, cart,
              prevProvider) =>
          prevProvider
            ..update(appointment, financial, notification, staticData, cart),
    ),
    ChangeNotifierProxyProvider<Partner, PreferenceProvider>(
      create: (ctx) => PreferenceProvider(ctx.read<Partner>()),
      update: (_, partner, prevProvider) => prevProvider..update(partner),
    ),
    ChangeNotifierProxyProvider<Partner, PsychologistProvider>(
      create: (ctx) => PsychologistProvider(ctx.read<Partner>()),
      update: (_, partner, prevProvider) => prevProvider..update(partner),
    ),
    ChangeNotifierProxyProvider2<Partner, StaticData,
        PsychologistProfileProvider>(
      create: (ctx) => PsychologistProfileProvider(
          ctx.read<Partner>(), ctx.read<StaticData>()),
      update: (_, partner, staticData, prevProvider) =>
          prevProvider..update(partner, staticData),
    ),
    ChangeNotifierProxyProvider2<Partner, Appointment, BookAppointmentProvider>(
      create: (ctx) =>
          BookAppointmentProvider(ctx.read<Partner>(), ctx.read<Appointment>()),
      update: (_, partner, appointment, prevProvider) =>
          prevProvider..update(partner, appointment),
    ),
    ChangeNotifierProxyProvider<Cart, CartProvider>(
      create: (ctx) => CartProvider(ctx.read<Cart>()),
      update: (_, cart, prevProvider) => prevProvider..update(cart),
    ),
    ChangeNotifierProxyProvider2<Cart, Payment, CheckoutProvider>(
      create: (ctx) => CheckoutProvider(ctx.read<Cart>(), ctx.read<Payment>()),
      update: (_, cart, payment, prevProvider) =>
          prevProvider..update(cart, payment),
    ),
    ChangeNotifierProxyProvider2<Cart, Payment, ManualPaymentProvider>(
      create: (ctx) =>
          ManualPaymentProvider(ctx.read<Cart>(), ctx.read<Payment>()),
      update: (_, cart, payment, prevProvider) =>
          prevProvider..update(cart, payment),
    ),
    ChangeNotifierProxyProvider2<Payment, StaticData, TransactionProvider>(
      create: (ctx) =>
          TransactionProvider(ctx.read<Payment>(), ctx.read<StaticData>()),
      update: (_, payment, staticData, prevProvider) =>
          prevProvider..update(payment, staticData),
    ),
  ];

  return providers;
}

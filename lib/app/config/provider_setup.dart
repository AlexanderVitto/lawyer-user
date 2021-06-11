import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../src/screens/otp/provider/otp_provider.dart';
import '../src/screens/main/home/provider/home_provider.dart';
import '../src/screens/preference/provider/preference_provider.dart';
import '../src/screens/psychologist/provider/psychologist_provider.dart';

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
    ChangeNotifierProxyProvider<Auth, OTPProvider>(
      create: (ctx) => OTPProvider(ctx.read<Auth>()),
      update: (_, auth, prevProvider) => prevProvider..update(auth),
    ),
    ChangeNotifierProxyProvider4<Appointment, Financial, Notification,
        StaticData, HomeProvider>(
      create: (ctx) => HomeProvider(
        ctx.read<Appointment>(),
        ctx.read<Financial>(),
        ctx.read<Notification>(),
        ctx.read<StaticData>(),
      ),
      update: (_, appointment, financial, notification, staticData,
              prevProvider) =>
          prevProvider
            ..update(appointment, financial, notification, staticData),
    ),
    ChangeNotifierProxyProvider<Partner, PreferenceProvider>(
      create: (ctx) => PreferenceProvider(ctx.read<Partner>()),
      update: (_, partner, prevProvider) => prevProvider..update(partner),
    ),
    ChangeNotifierProxyProvider<Partner, PsychologistProvider>(
      create: (ctx) => PsychologistProvider(ctx.read<Partner>()),
      update: (_, partner, prevProvider) => prevProvider..update(partner),
    ),
  ];

  return providers;
}

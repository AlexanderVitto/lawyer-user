import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../utils/utils.dart' as utils;

// General provider
import '../src/providers/providers.dart';

List<SingleChildWidget> setupProviders() {
  List<SingleChildWidget> providers = [
    ...topLevelProviders(),
    ...secondLinerProviders()
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
  ];

  return providers;
}

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// import '../config/config.dart' as config;
import '../utils/utils.dart' as utils;

// General provider
import '../src/providers/providers.dart';

// Local provider
import '../src/screens/signin/providers/signin_provider.dart';

List<SingleChildWidget> setupProviders() {
  List<SingleChildWidget> providers = [
    ...topLevelProviders(),
    ...secondLinerProviders(),
    ...thirdLinerProviders()
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
        update: (_, connection, prevAuth) => prevAuth..update(connection),
        lazy: false),
  ];

  return providers;
}

List<SingleChildWidget> thirdLinerProviders() {
  List<SingleChildWidget> providers = [
    ChangeNotifierProxyProvider<Auth, SigninProvider>(
      create: (_) => SigninProvider(),
      update: (_, auth, prevSignin) => prevSignin..update(auth),
    )
  ];

  return providers;
}

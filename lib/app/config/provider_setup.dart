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
  ];

  return providers;
}

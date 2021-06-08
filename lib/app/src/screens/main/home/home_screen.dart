import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constraint.dart';

import '../../../../utils/utils.dart' as utils;
import '../../../../splash_animation.dart';

import '../../../providers/providers.dart' as providers;

import 'provider/home_provider.dart';
import 'tablet/body.dart' as tablet;
import 'phone/body.dart' as phone;
import 'mini/body.dart' as mini;

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  final Animation<Offset> animation;

  const HomeScreen({Key key, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return ChangeNotifierProxyProvider4<
        providers.Appointment,
        providers.Financial,
        providers.Notification,
        providers.StaticData,
        HomeProvider>(
      create: (ctx) => HomeProvider(
          ctx.read<providers.Appointment>(),
          ctx.read<providers.Financial>(),
          ctx.read<providers.Notification>(),
          ctx.read<providers.StaticData>(),
          padding.top),
      update: (_, appointment, financial, notification, staticData,
              prevProvider) =>
          prevProvider
            ..update(appointment, financial, notification, staticData),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            print('Width ${constraints.maxWidth}');
            print('Height ${constraints.maxHeight}');

            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Provider.of<HomeProvider>(context, listen: false)
                  .setAppBarPosition(padding.top);
            });

            if (constraints.maxWidth > TabletThreshold) {
              return tablet.Body();
            } else if (constraints.maxWidth > PhoneThreshold &&
                constraints.maxWidth <= TabletThreshold) {
              return phone.Body(
                animation: animation,
              );
            } else {
              return mini.Body();
            }
          },
        ),
      ),
    );
  }
}

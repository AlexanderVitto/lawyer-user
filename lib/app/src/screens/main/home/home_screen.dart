import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constraint.dart';

import '../../../../utils/utils.dart' as utils;
import '../../../../splash_animation.dart';

import '../../../providers/providers.dart';

import 'provider/home_provider.dart';
import 'tablet/body.dart' as tablet;
import 'phone/body.dart' as phone;
import 'mini/body.dart' as mini;

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return ChangeNotifierProxyProvider<Auth, HomeProvider>(
      create: (ctx) => HomeProvider(ctx.read<Auth>(), padding.top),
      update: (_, auth, prevProvider) => prevProvider..update(auth),
      child: Scaffold(
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
              return phone.Body();
            } else {
              return mini.Body();
            }
          },
        ),
      ),
    );
  }
}

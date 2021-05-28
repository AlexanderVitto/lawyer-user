import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constraint.dart';

import '../../../helpers/helpers.dart' as helpers;
import '../../../utils/utils.dart' as utils;
import '../../../splash_animation.dart';

import '../../providers/providers.dart';

import 'provider/mobile_number_verification_provider.dart';
import 'tablet/body.dart' as tablet;
import 'phone/body.dart' as phone;
import 'mini/body.dart' as mini;

class MobileNumberVerificationScreen extends StatelessWidget {
  static const routeName = '/mobile-number-verification-screen';

  const MobileNumberVerificationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final connection = Provider.of<utils.Connection>(context, listen: false);

    return ChangeNotifierProxyProvider<Auth, MobileNumberVerificationProvider>(
      create: (ctx) => MobileNumberVerificationProvider(ctx.read<Auth>()),
      update: (_, auth, prevProvider) => prevProvider..update(auth),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<bool>(
          future: connection.init(),
          builder: (_, AsyncSnapshot<bool> snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? SplashAnimation()
                  : LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        print('Width ${constraints.maxWidth}');
                        print('Height ${constraints.maxHeight}');

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
      ),
    );
  }
}

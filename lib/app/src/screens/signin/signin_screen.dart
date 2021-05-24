import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constraint.dart';
import '../../../utils/utils.dart' as utils;
import '../../../splash_animation.dart';

import 'tablet/signin_body.dart' as tablet;
import 'phone/signin_body.dart' as phone;
import 'mini/signin_body.dart' as mini;

class SignInScreen extends StatelessWidget {
  static const routeName = '/signin-screen';

  @override
  Widget build(BuildContext context) {
    final connection = Provider.of<utils.Connection>(context, listen: false);
    return Scaffold(
      backgroundColor: PsykayGreenColor,
      body: FutureBuilder(
        future: connection.init(),
        builder: (_, AsyncSnapshot snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? SplashAnimation()
            : LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  print('Width ${constraints.maxWidth}');
                  print('Height ${constraints.maxHeight}');

                  if (constraints.maxWidth > TabletThreshold) {
                    return tablet.SigninBody();
                  } else if (constraints.maxWidth > PhoneThreshold &&
                      constraints.maxWidth <= TabletThreshold) {
                    return phone.SigninBody();
                  } else {
                    return mini.SigninBody();
                  }
                },
              ),
      ),
    );
  }
}

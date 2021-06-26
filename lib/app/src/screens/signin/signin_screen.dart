import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constraint.dart';

import '../../../utils/utils.dart' as utils;
import '../../../splash_animation.dart';

import '../../providers/providers.dart';

import 'provider/signin_provider.dart';
import 'tablet/body.dart' as tablet;
import 'phone/body.dart' as phone;
import 'mini/body.dart' as mini;

class SignInScreen extends StatefulWidget {
  static const routeName = '/signin-screen';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  SignInProvider provider;

  @override
  void initState() {
    super.initState();

    provider = Provider.of<SignInProvider>(context, listen: false);
    provider.initResource();
  }

  @override
  void dispose() {
    provider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<SignInProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: PsykayGreenColor,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
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
    );
  }
}

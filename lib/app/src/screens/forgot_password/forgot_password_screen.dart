import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constraint.dart';
import '../../../utils/utils.dart' as utils;
import '../../../helpers/helpers.dart' as helpers;

import '../../providers/providers.dart';

import 'provider/forgot_password_provider.dart';
import 'tablet/body.dart' as tablet;
import 'phone/body.dart' as phone;
import 'mini/body.dart' as mini;

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot-password-screen';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  ForgotPasswordProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<ForgotPasswordProvider>(context, listen: false);

    provider.initResource();
  }

  @override
  void dispose() {
    provider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ForgotPasswordProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
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

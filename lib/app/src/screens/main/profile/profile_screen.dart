import 'package:flutter/material.dart';

import '../../../../../constraint.dart';

import '../../../../helpers/helpers.dart' as helpers;

import 'tablet/body.dart' as tablet;
import 'phone/body.dart' as phone;
import 'mini/body.dart' as mini;

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > TabletThreshold) {
          return tablet.Body();
        } else if (constraints.maxWidth > PhoneThreshold &&
            constraints.maxWidth <= TabletThreshold) {
          return phone.Body();
        } else {
          return mini.Body();
        }
      },
    ));
  }
}

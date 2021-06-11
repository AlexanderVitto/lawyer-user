import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constraint.dart';

import '../../../utils/utils.dart' as utils;
import '../../../helpers/helpers.dart' as helpers;

import 'tablet/body.dart' as tablet;
import 'phone/body.dart' as phone;
import 'mini/body.dart' as mini;

class PreferenceScreen extends StatelessWidget {
  static const routeName = '/preference-screen';

  final helpers.ScreenArguments arguments;

  const PreferenceScreen(this.arguments);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PsykayGreenColor,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          print('Width ${constraints.maxWidth}');
          print('Height ${constraints.maxHeight}');

          if (constraints.maxWidth > TabletThreshold) {
            return tablet.Body(
              staticData: arguments.staticData,
            );
          } else if (constraints.maxWidth > PhoneThreshold &&
              constraints.maxWidth <= TabletThreshold) {
            return phone.Body(
              staticData: arguments.staticData,
            );
          } else {
            return mini.Body(
              staticData: arguments.staticData,
            );
          }
        },
      ),
    );
  }
}

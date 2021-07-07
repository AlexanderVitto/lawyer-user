import 'package:flutter/material.dart';

import '../../../../../constraint.dart';

import '../../../../helpers/helpers.dart' as helpers;

import 'tablet/body.dart' as tablet;
import 'phone/body.dart' as phone;
import 'mini/body.dart' as mini;

class TransactionScreen extends StatelessWidget {
  static const routeName = '/transaction-screen';

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(localization.translate('Transaction'.pascalCase())),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: LayoutBuilder(
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

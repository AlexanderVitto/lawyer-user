import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constraint.dart';

import '../../../helpers/helpers.dart' as helpers;

import 'provider/account_information_provider.dart';
import 'tablet/body.dart' as tablet;
import 'phone/body.dart' as phone;
import 'mini/body.dart' as mini;

class AccountInformationScreen extends StatefulWidget {
  static const routeName = '/account-information-screen';

  @override
  _AccountInformationScreenState createState() =>
      _AccountInformationScreenState();
}

class _AccountInformationScreenState extends State<AccountInformationScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AccountInformationProvider>(context, listen: false)
        .initResource();
  }

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.translate('Account information'.pascalCase())),
      ),
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

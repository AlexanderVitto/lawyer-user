import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constraint.dart';

import '../../../helpers/helpers.dart' as helpers;

import 'provider/manual_payment_provider.dart';

import 'tablet/body.dart' as tablet;
import 'phone/body.dart' as phone;
import 'mini/body.dart' as mini;

class ManualPaymentScreen extends StatefulWidget {
  static const routeName = '/manual-payment-screen';

  @override
  _ManualPaymentScreenState createState() => _ManualPaymentScreenState();
}

class _ManualPaymentScreenState extends State<ManualPaymentScreen> {
  ManualPaymentProvider provider;

  @override
  void initState() {
    super.initState();

    provider = Provider.of<ManualPaymentProvider>(context, listen: false);
    provider.initResource();
  }

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.translate('Manual Payment')),
      ),
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

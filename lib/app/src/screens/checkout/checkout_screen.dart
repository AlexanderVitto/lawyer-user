import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constraint.dart';
import '../../../../enum.dart';

import '../../../helpers/helpers.dart' as helpers;
import '../../../native/payment_gateway.dart';

import '../../providers/providers.dart' as providers;
import '../../screens/shared/shared.dart';

import '../main/main_screen.dart';

import 'provider/checkout_provider.dart';

import 'tablet/body.dart' as tablet;
import 'phone/body.dart' as phone;
import 'mini/body.dart' as mini;

class CheckoutScreen extends StatefulWidget {
  static const routeName = '/checkout-screen';

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  CheckoutProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<CheckoutProvider>(context, listen: false);
    provider.initResource();
  }

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    provider = Provider.of<CheckoutProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.translate('Checkout')),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: PaymentGateway.paymentStatus,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['status'] == PaymentGateway.STATUS_PENDING ||
                snapshot.data['status'] == PaymentGateway.STATUS_SUCCESS) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await provider.initPaymentMidtrans(snapshot.data);

                final status =
                    Provider.of<providers.Payment>(context, listen: false)
                        .paymentStatus;

                if (status == helpers.AuthResultStatus.initPaymentSuccess) {
                  await successDialog(
                      context: context,
                      barrierDismissible: false,
                      iconSize: 72,
                      title: 'Payment Success!',
                      titleFontSize: 14,
                      description:
                          'Click the button to go to transactions page',
                      descriptionFontSize: 12,
                      buttonText: 'Okay',
                      buttonFontSize: 12,
                      sizedBox1: 12,
                      sizedBox2: 5,
                      sizedBox3: 10);

                  Navigator.of(context).pushNamedAndRemoveUntil(
                      MainScreen.routeName, (route) => false,
                      arguments: helpers.ScreenArguments(
                          mainScreenTab: MainScreenTab.home));
                } else {
                  await errorDialog(
                      context: context,
                      iconSize: 45,
                      title: 'Login Error!',
                      titleFontSize: 14,
                      description:
                          helpers.AuthExceptionHandler.generateExceptionMessage(
                              status),
                      descriptionFontSize: 12,
                      buttonText: 'Okay',
                      buttonFontSize: 12,
                      sizedBox1: 12,
                      sizedBox2: 5,
                      sizedBox3: 10);
                }
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                provider.setToIdle();
              });
            }
          }

          return LayoutBuilder(
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
          );
        },
      ),
    );
  }
}

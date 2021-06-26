import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constraint.dart';

import '../../../helpers/helpers.dart' as helpers;

import 'provider/cart_provider.dart';

import 'tablet/body.dart' as tablet;
import 'phone/body.dart' as phone;
import 'mini/body.dart' as mini;

class CartScreen extends StatefulWidget {
  static const routeName = '/cart-screen';

  final helpers.ScreenArguments arguments;

  const CartScreen(this.arguments);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartProvider provider;

  @override
  void initState() {
    super.initState();

    provider = Provider.of<CartProvider>(context, listen: false);
    provider.initResource();
  }

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    provider = Provider.of<CartProvider>(context, listen: false);

    return WillPopScope(
      onWillPop: () => provider.onWillPop(context, widget.arguments.prevRoute),
      child: Scaffold(
        appBar: AppBar(
          title: Text(localization.translate('Cart')),
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
      ),
    );
  }
}

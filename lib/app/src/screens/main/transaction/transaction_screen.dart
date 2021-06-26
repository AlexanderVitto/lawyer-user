import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constraint.dart';

import '../../../../../enum.dart';
import '../../../../helpers/helpers.dart' as helpers;

import 'provider/transaction_provider.dart';
import 'tablet/body.dart' as tablet;
import 'phone/body.dart' as phone;
import 'mini/body.dart' as mini;

class TransactionScreen extends StatefulWidget {
  static const routeName = '/transaction-screen';

  final TransactionScreenTab tab;

  const TransactionScreen({Key key, this.tab}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  TransactionProvider provider;

  @override
  void initState() {
    super.initState();

    provider = Provider.of<TransactionProvider>(context, listen: false);
    provider.initResource(widget.tab);
  }

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(localization.translate('Transaction'.pascalCase())),
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
        ));
  }
}

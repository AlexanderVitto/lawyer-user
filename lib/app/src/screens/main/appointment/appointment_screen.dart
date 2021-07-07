import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constraint.dart';

import '../../../../helpers/helpers.dart' as helpers;

import 'provider/appointment_provider.dart';
import 'tablet/body.dart' as tablet;
import 'phone/body.dart' as phone;
import 'mini/body.dart' as mini;

class AppointmentScreen extends StatefulWidget {
  static const routeName = '/appointment-screen';

  final helpers.ScreenArguments arguments;

  const AppointmentScreen({Key key, this.arguments}) : super(key: key);

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime date;
  AppointmentProvider provider;
  @override
  void initState() {
    super.initState();

    date = widget.arguments.initialDate;

    provider = Provider.of<AppointmentProvider>(context, listen: false);

    if (widget.arguments.initialDate == null) date = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.initEvent(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(localization.translate('Appointment'.pascalCase())),
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

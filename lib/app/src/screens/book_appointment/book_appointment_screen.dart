import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constraint.dart';

import '../../../helpers/helpers.dart' as helpers;

import 'provider/book_appointment_provider.dart';

import 'tablet/body.dart' as tablet;
import 'phone/body.dart' as phone;
import 'mini/body.dart' as mini;

class BookAppointmentScreen extends StatefulWidget {
  static const routeName = '/book-appointment-screen';

  final helpers.ScreenArguments arguments;

  const BookAppointmentScreen(this.arguments);

  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  BookAppointmentProvider provider;
  @override
  void initState() {
    super.initState();

    provider = Provider.of<BookAppointmentProvider>(context, listen: false);
    provider.initResource(
        widget.arguments.partnerData.id, widget.arguments.staticData);
  }

  @override
  void dispose() {
    provider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    provider = Provider.of<BookAppointmentProvider>(context, listen: false);

    return WillPopScope(
      onWillPop: provider.onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(localization.translate('Book appointment'.pascalCase())),
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
      ),
    );
  }
}

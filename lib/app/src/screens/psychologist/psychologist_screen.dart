import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constraint.dart';

import '../../../helpers/helpers.dart' as helpers;

import 'provider/psychologist_provider.dart';

import 'tablet/body.dart' as tablet;
import 'phone/body.dart' as phone;
import 'mini/body.dart' as mini;

class PsychologistScreen extends StatefulWidget {
  static const routeName = '/psychologist-screen';

  final helpers.ScreenArguments arguments;

  const PsychologistScreen(this.arguments);

  @override
  _PsychologistScreenState createState() => _PsychologistScreenState();
}

class _PsychologistScreenState extends State<PsychologistScreen> {
  PsychologistProvider _provider;
  @override
  void initState() {
    super.initState();

    _provider = Provider.of<PsychologistProvider>(context, listen: false);
    _provider.initResource();
  }

  @override
  void dispose() {
    _provider?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    _provider = Provider.of<PsychologistProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.arguments.staticData.name ??
            localization.translate('Psychologist')),
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

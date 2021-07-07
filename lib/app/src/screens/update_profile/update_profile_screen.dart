import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constraint.dart';

import '../../../helpers/helpers.dart' as helpers;

import 'provider/update_profile_provider.dart';
import 'tablet/body.dart' as tablet;
import 'phone/body.dart' as phone;
import 'mini/body.dart' as mini;

class UpdateProfileScreen extends StatefulWidget {
  static const routeName = '/update-profile-screen';

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  UpdateProfileProvider provider;

  @override
  void initState() {
    super.initState();

    provider = Provider.of<UpdateProfileProvider>(context, listen: false);
    provider.initResource();
  }

  @override
  void dispose() {
    provider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    provider = Provider.of<UpdateProfileProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.translate('Update profile'.pascalCase())),
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

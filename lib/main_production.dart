import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'app/config/config.dart' as config;
import 'app/app.dart';

Future<void> main() async {
  config.FlavorConfig(
      flavor: config.Flavor.PRODUCTION,
      values: config.FlavorValues(
          host: 'https://userapi-dev.psykay.co.id',
          chatHost: 'https://twillio-dev.psykay.co.id',
          googleApiUrl:
              'https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=AIzaSyAvz02RmKRJUPDVidwhT9iPQh2COFOg99I',
          enableBearerToken: true));

  await Firebase.initializeApp();

  config.setuptLocator();

  runZonedGuarded(() {
    runApp(MyApp());
  }, FirebaseCrashlytics.instance.recordError);
}

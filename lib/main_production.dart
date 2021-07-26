import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/config/config.dart' as config;
import 'app/app.dart';

Future<void> main() async {
  config.FlavorConfig(
      flavor: config.Flavor.PRODUCTION,
      values: config.FlavorValues(
        host: 'https://userapi-dev.psykay.co.id',
        enableBearerToken: true,
      ));

  SharedPreferences sharedPreferences;

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  final futures = <Future>[
    Firebase.initializeApp(),
    SharedPreferences.getInstance().then((value) => sharedPreferences = value),
  ];

  await Future.wait(futures);

  config.setuptLocator();

  runZonedGuarded(() {
    runApp(MyApp(sharedPreferences));
  }, FirebaseCrashlytics.instance.recordError);
}

import 'package:flutter/material.dart';

import '../utils/utils.dart';

enum Flavor { DEV, QA, PRODUCTION }

class FlavorValues {
  final String host;
  final String chatHost;
  final String googleApiUrl;
  final int timeout;
  final int consultationTime;
  final int paymentExpiredTime;
  final bool enableBearerToken;
  final int bookingTimeThreshold;
  final List<int> operationTimeStart;
  final List<int> operationalTimeOff;

  FlavorValues(
      {this.host,
      this.chatHost,
      this.googleApiUrl,
      this.timeout = 15,
      this.paymentExpiredTime = 120,
      this.consultationTime = 30,
      this.enableBearerToken = false,
      this.bookingTimeThreshold,
      this.operationTimeStart,
      this.operationalTimeOff});
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final Color color;
  final FlavorValues values;
  static FlavorConfig _instance;

  factory FlavorConfig(
      {@required Flavor flavor,
      Color color: Colors.blue,
      @required FlavorValues values}) {
    _instance ??= FlavorConfig._internal(
        flavor, StringUtils.enumName(flavor.toString()), color, values);
    WidgetsFlutterBinding.ensureInitialized();

    return _instance;
  }

  FlavorConfig._internal(this.flavor, this.name, this.color, this.values);
  static FlavorConfig get instance {
    return _instance;
  }

  static bool isProduction() => _instance.flavor == Flavor.PRODUCTION;
  static bool isDevelopment() => _instance.flavor == Flavor.DEV;
  static bool isQA() => _instance.flavor == Flavor.QA;
}

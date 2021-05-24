import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

class AnalyticUtils {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();
  FirebaseAnalyticsObserver observer() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future<void> setUserProperties(
      {@required String name, @required String value}) async {
    await _analytics.setUserProperty(name: name, value: value);
  }

  Future<void> setUserId({@required String userId}) async {
    await _analytics.setUserId(userId);
  }

  Future<void> setCurrentScreen(
      {@required String screenName, @required String className}) async {
    await _analytics.setCurrentScreen(
        screenName: screenName, screenClassOverride: className);
  }

  Future<void> sendAnalyticsEvent(
      {@required String eventName,
      @required Map<String, dynamic> parameters}) async {
    await _analytics.logEvent(
      name: eventName,
      parameters: parameters,
    );
  }
}

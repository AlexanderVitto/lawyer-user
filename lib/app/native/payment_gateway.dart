import 'package:flutter/services.dart';

class PaymentGateway {
  static const String STATUS_SUCCESS = "success";
  static const String STATUS_PENDING = "pending";
  static const String STATUS_INVALID = "invalid";
  static const String STATUS_FAILED = "failed";
  static const String STATUS_CANCELED = "canceled";

  static const MethodChannel _channel =
      const MethodChannel('com.example.lawyer_user_app.payment_gateway');

  static const EventChannel _eventChannel =
      const EventChannel('com.example.lawyer_user_app.payment_gateway/status');

  static Stream<dynamic> _paymentStatus;

  static Future<String> payment(Map<String, dynamic> data) async {
    final String result = await _channel.invokeMethod('showMidtrans', data);

    print('result $result');

    return result;
  }

  static Stream<dynamic> get paymentStatus {
    if (_paymentStatus == null) {
      _paymentStatus =
          _eventChannel.receiveBroadcastStream().map<dynamic>((value) => value);

      print('masuk');
    }

    return _paymentStatus;
  }

  static resetStatus() {
    _paymentStatus = null;
  }
}

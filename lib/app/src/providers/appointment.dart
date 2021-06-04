import 'package:flutter/material.dart';

import '../../config/config.dart' as config;
import '../../helpers/helpers.dart' as helpers;
import '../../utils/utils.dart' as utils;
import '../../services/appointment.dart' as appointment;
import '../../services/payment.dart' as payment;

import 'providers.dart';

class Appointment with ChangeNotifier {
  static const fileName = 'lib/app/src/providers/appointment.dart';

  utils.Connection _connection;
  utils.LogUtils _log;

  appointment.AppointmentAPI _appointmentAPI;
  payment.PaymentAPI _paymentAPI;

  Auth _auth;
  Auth get auth => _auth;

  Appointment(utils.Connection connection) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._appointmentAPI = config.locator<appointment.AppointmentAPI>();
    this._paymentAPI = config.locator<payment.PaymentAPI>();

    this._connection = connection;
  }

  update(Auth auth) {
    this._auth = auth;

    notifyListeners();
  }

  Future fetchAppointment() async{
    final String method = 'checkMobileNumber';

    await _connection.check();

    if(_connection.isConnected){
      
    }
  }
}

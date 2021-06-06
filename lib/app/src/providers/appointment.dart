import 'package:flutter/material.dart';

import '../../config/config.dart' as config;
import '../../helpers/helpers.dart' as helpers;
import '../../utils/utils.dart' as utils;
import '../../services/appointment.dart' as appointment;
import '../../services/payment.dart' as payment;

import '../models/models.dart' as models;

import 'providers.dart';

class Appointment with ChangeNotifier {
  static const fileName = 'lib/app/src/providers/appointment.dart';

  DateTime _startDate;
  DateTime get startDate => _startDate;
  DateTime _endDate;
  DateTime get endDate => _endDate;

  utils.Connection _connection;
  utils.LogUtils _log;

  appointment.AppointmentAPI _appointmentAPI;
  payment.PaymentAPI _paymentAPI;

  helpers.AuthResultStatus _appointmentStatus;
  helpers.AuthResultStatus get appointmentStatus => _appointmentStatus;

  Auth _auth;
  Auth get auth => _auth;

  List<models.Appointment> _appointments;
  List<models.Appointment> _freeAppointments;

  // By status
  List<models.Appointment> _payments;
  List<models.Appointment> get payments => _payments;
  List<models.Appointment> _partnerConfrimations;
  List<models.Appointment> get partnerConfirmation => _partnerConfrimations;
  List<models.Appointment> _confirmed;
  List<models.Appointment> get confirmed => _confirmed;
  List<models.Appointment> _onProgress;
  List<models.Appointment> get onProgress => _onProgress;
  List<models.Appointment> _complated;
  List<models.Appointment> get complated => _complated;
  List<models.Appointment> _canceled;
  List<models.Appointment> get canceled => _canceled;
  List<models.Appointment> _reschedule;
  List<models.Appointment> get reschedule => _reschedule;

  Appointment(utils.Connection connection) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._appointmentAPI = config.locator<appointment.AppointmentAPI>();
    this._paymentAPI = config.locator<payment.PaymentAPI>();

    this._connection = connection;

    this._appointmentStatus = helpers.AuthResultStatus.undefined;
    this._appointments = [];
    this._freeAppointments = [];
    this._payments = [];
    this._partnerConfrimations = [];
    this._confirmed = [];
    this._onProgress = [];
    this._complated = [];
    this._canceled = [];
    this._reschedule = [];
  }

  update(Auth auth) {
    this._auth = auth;

    notifyListeners();
  }

  setStartDate(DateTime data) {
    this._startDate = data;

    notifyListeners();
  }

  setEndDate(DateTime data) {
    this._endDate = data;

    notifyListeners();
  }

  Future booking(models.AppointmentBody body) async {
    final String method = 'fetchAppointment';

    await _connection.check();

    if (_connection.isConnected) {
      utils.ApiReturn<models.ResponseAppointment> apiRequest =
          await _appointmentAPI.bookAppontment(body, _auth.token);

      if (!apiRequest.status) {
        // Problem with connection to API

        if (apiRequest.value.code == '401') {
          // Force logout

        }

        _appointmentStatus = helpers.AuthResultStatus.apiConnectionError;
      } else {}

      notifyListeners();
    }
  }

  Future fetchAppointment(Map<String, dynamic> queryParameter) async {
    final String method = 'fetchAppointment';

    await _connection.check();

    if (_connection.isConnected) {
      utils.ApiReturn<models.ResponseListAppointment> apiRequest =
          await _appointmentAPI.getAppointment(queryParameter, _auth.token);

      if (!apiRequest.status) {
        // Problem with connection to API

        if (apiRequest.value.code == '401') {
          // Force logout

        }

        _appointments = [];
      } else {
        if (apiRequest.value.status) {
          _appointments = apiRequest.value.result;
          _appointments.sort((a, b) {
            var aDateTime;
            var bDataTime;

            if (a.startDate != null && b.startDate != null) {
              aDateTime =
                  DateTime.parse("${a.startDate.split('T')[0]} ${a.startTime}");

              bDataTime =
                  DateTime.parse("${b.startDate.split('T')[0]} ${b.startTime}");
            }

            return aDateTime.compareTo(bDataTime);
          });
        } else {
          _appointments = [];
        }
      }

      notifyListeners();
    }
  }

  Future fetchFreeAppointment() async {
    final String method = 'fetchFreeAppointment';

    await _connection.check();

    if (_connection.isConnected) {
      Map<String, dynamic> queryParameter = {
        "userId": _auth.userId,
      };

      utils.ApiReturn<models.ResponseListAppointment> apiRequest =
          await _appointmentAPI.getFreeAppointment(queryParameter, _auth.token);

      if (!apiRequest.status) {
        // Problem with connection to API

        if (apiRequest.value.code == '401') {
          // Force logout

        }

        _freeAppointments = [];
      } else {
        if (apiRequest.value.status) {
          _freeAppointments = apiRequest.value.result;
          _freeAppointments.sort((a, b) {
            var aDateTime;
            var bDataTime;

            if (a.startDate != null && b.startDate != null) {
              aDateTime =
                  DateTime.parse("${a.startDate.split('T')[0]} ${a.startTime}");

              bDataTime =
                  DateTime.parse("${b.startDate.split('T')[0]} ${b.startTime}");
            }

            return aDateTime.compareTo(bDataTime);
          });
        } else {
          _freeAppointments = [];
        }
      }

      notifyListeners();
    }
  }

  Future filterAppointment() async {
    final String method = 'filterAppointment';

    if (_appointments.isNotEmpty) {
      _payments = [];
      _partnerConfrimations = [];
      _confirmed = [];
      _onProgress = [];
      _complated = [];
      _canceled = [];
      _reschedule = [];

      _appointments.forEach((element) {
        switch (element.appointmentStatusId) {
          case 1:
            _payments.add(element);
            break;
          case 2:
            if (element.isRescheduled && !element.rescheduledByUser) {
              _reschedule.add(element);
            } else {
              _partnerConfrimations.add(element);
            }
            break;
          case 3:
            _confirmed.add(element);
            break;
          case 4:
            _onProgress.add(element);
            break;
          case 5:
            _complated.add(element);
            break;
          case 6:
            _canceled.add(element);
            break;
          default:
        }
      });

      notifyListeners();
    }
  }
}

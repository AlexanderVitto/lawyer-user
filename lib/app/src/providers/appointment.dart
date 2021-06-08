import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/config.dart' as config;
import '../../helpers/helpers.dart' as helpers;
import '../../utils/utils.dart' as utils;
import '../../services/appointment.dart' as appointment;

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

  helpers.AuthResultStatus _appointmentStatus;
  helpers.AuthResultStatus get appointmentStatus => _appointmentStatus;

  Auth _auth;
  Auth get auth => _auth;

  List<models.Appointment> _appointments;
  List<models.Appointment> _freeAppointments;
  List<models.Appointment> get freeAppointments => _freeAppointments;

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

  Appointment() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._appointmentAPI = config.locator<appointment.AppointmentAPI>();

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
    this._connection = auth.connection;

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
    final String method = 'booking';

    await _connection.check();

    utils.ApiReturn<models.ResponseAppointment> apiRequest =
        await _appointmentAPI.bookAppontment(body, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Force logout

      }

      _appointmentStatus = helpers.AuthResultStatus.apiConnectionError;
    } else {
      if (apiRequest.value.status) {
        _appointmentStatus = helpers.AuthResultStatus.bookAppointmentSuccess;

        await tryFetch();
      } else {
        _appointmentStatus = helpers.AuthResultStatus.bookAppointmentFailed;
      }
    }

    notifyListeners();
  }

  Future updateAppointment(models.AppointmentBody body) async {
    final String method = 'updateAppointment';

    await _connection.check();

    utils.ApiReturn<models.ResponseAppointment> apiRequest =
        await _appointmentAPI.updateAppointment(body, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Force logout

      }

      _appointmentStatus = helpers.AuthResultStatus.apiConnectionError;
    } else {
      if (apiRequest.value.status) {
        _appointmentStatus = helpers.AuthResultStatus.updateAppointmentSuccess;

        await tryFetch();
      } else {
        _appointmentStatus = helpers.AuthResultStatus.updateAppointmentFailed;
      }
    }

    notifyListeners();
  }

  Future rescheduleAppointment(models.AppointmentBody body) async {
    final String method = 'rescheduleAppointment';

    await _connection.check();

    utils.ApiReturn<models.ResponseAppointment> apiRequest =
        await _appointmentAPI.rescheduleAppointment(body, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Force logout

      }

      _appointmentStatus = helpers.AuthResultStatus.apiConnectionError;
    } else {
      if (apiRequest.value.status) {
        _appointmentStatus =
            helpers.AuthResultStatus.rescheduleAppointmentSuccess;

        await tryFetch();
      } else {
        _appointmentStatus =
            helpers.AuthResultStatus.rescheduleAppointmentFailed;
      }
    }

    notifyListeners();
  }

  Future complateAppointment(models.CompleteAppointment body) async {
    final String method = 'complateAppointment';

    await _connection.check();

    utils.ApiReturn<models.ResponseAppointment> apiRequest =
        await _appointmentAPI.completeAppointment(body, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Force logout

      }

      _appointmentStatus = helpers.AuthResultStatus.apiConnectionError;
    } else {
      if (apiRequest.value.status) {
        _appointmentStatus =
            helpers.AuthResultStatus.complateAppointmentSuccess;

        await tryFetch();
      } else {
        _appointmentStatus = helpers.AuthResultStatus.complateAppointmentFailed;
      }
    }

    notifyListeners();
  }

  Future rateAppointment(models.RateAppointment body) async {
    final String method = 'rateAppointment';

    await _connection.check();

    utils.ApiReturn<models.ResponseAppointment> apiRequest =
        await _appointmentAPI.rateAppointment(body, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Force logout

      }

      _appointmentStatus = helpers.AuthResultStatus.apiConnectionError;
    } else {
      if (apiRequest.value.status) {
        _appointmentStatus = helpers.AuthResultStatus.rateAppointmentSuccess;

        await tryFetch();
      } else {
        _appointmentStatus = helpers.AuthResultStatus.rateAppointmentFailed;
      }
    }

    notifyListeners();
  }

  Future tryFetch() async {
    Map<String, dynamic> queryParameter = {
      "userId": _auth.userId,
      "startDate": DateFormat('MM/dd/yyyy').format(new DateTime.now()),
      "endDate": DateFormat('MM/dd/yyyy')
          .format(new DateTime.now().add(new Duration(days: 90)))
    };

    var futures = <Future>[
      fetchAppointment(queryParameter),
      fetchFreeAppointment()
    ];

    await Future.wait(futures);
  }

  Future fetchAppointment(Map<String, dynamic> queryParameter) async {
    final String method = 'fetchAppointment';

    await _connection.check();

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

  Future fetchFreeAppointment() async {
    final String method = 'fetchFreeAppointment';

    await _connection.check();

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
      } else {
        _freeAppointments = [];
      }
    }

    notifyListeners();
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

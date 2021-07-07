import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../constraint.dart';
import '../../../../../../enum.dart';

import '../../../../../config/config.dart' as config;
import '../../../../../helpers/helpers.dart' as helpers;
import '../../../../../utils/utils.dart' as utils;

import '../../../../models/models.dart' as models;
import '../../../../providers/providers.dart' as providers;

class AppointmentProvider with ChangeNotifier {
  static const fileName =
      'lib/app/src/screens/main/appointment/provider/appointment_provider.dart';

  utils.LogUtils _log;

  providers.Appointment _appointmentProvider;
  providers.Appointment get appointmentProvider => _appointmentProvider;

  List<models.Appointment> _selectedEvents;
  List<models.Appointment> get selectedEvents => _selectedEvents;

  Map<DateTime, List<models.Appointment>> _mapAppointment;
  Map<DateTime, List<models.Appointment>> get mapAppointment => _mapAppointment;

  Map<DateTime, List> _holidays;
  Map<DateTime, List> get holidays => _holidays;

  bool _isInit;
  bool get isInit => _isInit;
  bool _isBusy;
  bool get isBusy => _isBusy;

  AppointmentProvider(providers.Appointment appointment) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);

    this._appointmentProvider = appointment;
  }

  update(providers.Appointment appointment) {
    this._appointmentProvider = appointment;

    notifyListeners();
  }

  onDaySelected(DateTime day, List events) {
    _selectedEvents = events.isEmpty ? [] : events;

    notifyListeners();
  }

  onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    _log.info(
        method: 'onVisibleDaysChanged',
        message:
            'First ${first.toIso8601String()} last ${last.toIso8601String()} format ${format.toString()}');

    int length = last.difference(first).inDays;

    List<DateTime> listDate = List<DateTime>.generate(
        length,
        (i) => DateTime.utc(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ).add(Duration(days: i)));

    getNewValue(listDate);
  }

  onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    _log.info(
        method: 'onCalendarCreated',
        message:
            'First ${first.toIso8601String()} last ${last.toIso8601String()} format ${format.toString()}');
  }

  initEvent(DateTime date) async {
    _isInit = true;
    notifyListeners();

    DateTime startDate = DateTime.now().subtract(Duration(days: 31));
    DateTime endDate = DateTime.now().add(Duration(days: 31));

    Map<String, dynamic> queryParameter = {
      'userId': _appointmentProvider.auth.userId,
      'startDate': DateFormat('MM/dd/yyyy').format(startDate),
      'endDate': DateFormat('MM/dd/yyyy').format(endDate)
    };

    final futures = <Future>[
      _appointmentProvider.fetchAppointment(queryParameter)
    ];

    await Future.wait(futures);

    List<DateTime> listDate =
        List<DateTime>.generate(62, (i) => startDate.add(Duration(days: i)));

    _generateAppointment(listDate);

    _log.info(
        method: 'initEvent',
        message: '_mapAppointment ${_mapAppointment.length}');

    _selectedEvents =
        _mapAppointment[DateTime(date.year, date.month, date.day)] ?? [];

    setToIdle();
  }

  setToBusy() {
    _isBusy = true;

    notifyListeners();
  }

  setToIdle() {
    _isInit = false;
    _isBusy = false;

    notifyListeners();
  }

  Future initResource() async {
    this._isInit = true;
    this._isBusy = false;

    this._selectedEvents = [];
    this._mapAppointment = {};
    this._holidays = {};

    await initialLoad();
  }

  Future initialLoad() async {
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now().add(Duration(days: 31));

    Map<String, dynamic> queryParameter = {
      'userId': _appointmentProvider.auth.userId,
      'startDate': DateFormat('MM/dd/yyyy').format(startDate),
      'endDate': DateFormat('MM/dd/yyyy').format(endDate)
    };

    final futures = <Future>[
      _appointmentProvider.fetchAppointment(queryParameter)
    ];

    await Future.wait(futures);

    List<DateTime> listDate =
        List<DateTime>.generate(62, (i) => startDate.add(Duration(days: i)));

    _generateAppointment(listDate);

    setToIdle();
  }

  Future getNewValue(List<DateTime> listDate) async {
    Map<String, dynamic> queryParameter = {
      'userId': _appointmentProvider.auth.userId,
      'startDate': DateFormat('MM/dd/yyyy').format(listDate[0]),
      'endDate': DateFormat('MM/dd/yyyy').format(listDate[listDate.length - 1])
    };

    await _appointmentProvider.fetchAppointment(queryParameter);

    _generateAppointment(listDate);

    notifyListeners();
  }

  _generateAppointment(List<DateTime> listDate) {
    listDate.forEach((element) {
      List<models.Appointment> temp = [];
      String startDate = DateFormat('yyyy-MM-dd').format(element);

      temp = _appointmentProvider.appointments
          .where((appointmentElement) =>
              appointmentElement.startDate.split('T')[0] == startDate)
          .toList();

      if (temp.isNotEmpty) {
        if (_mapAppointment.isEmpty) {
          _mapAppointment = {DateTime.parse(startDate): temp};
        } else {
          if (_mapAppointment.containsKey(DateTime.parse(startDate))) {
            _mapAppointment[DateTime.parse(startDate)] = temp;
          } else {
            _mapAppointment.addAll({DateTime.parse(startDate): temp});
          }
        }
      }
    });
  }
}

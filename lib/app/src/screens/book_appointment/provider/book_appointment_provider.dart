import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psykay_userapp_v2/constraint.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../enum.dart';

import '../../../../config/config.dart' as config;
import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;

import '../../../models/models.dart' as models;
import '../../../providers/providers.dart' as providers;

class BookAppointmentProvider with ChangeNotifier {
  static const fileName =
      'lib/app/src/screens/book_appointment/provider/book_appointment_provider.dart';

  TabController _tabController;

  Color _progressLine1Color;
  Color get progressLine1Color => _progressLine1Color;
  Color _progressLine2Color;
  Color get progressLine2Color => _progressLine2Color;
  Color _indicator1Color;
  Color get indicator1Color => _indicator1Color;
  Color _indicator2Color;
  Color get indicator2Color => _indicator2Color;
  Color _indicator3Color;
  Color get indicator3Color => _indicator3Color;

  utils.LogUtils _log;

  providers.Partner _partnerProvider;

  models.Partner _partnerDetail;
  models.Partner get partnerDetail => _partnerDetail;

  List<models.WorkingHour> _selectedEvents;
  List<models.WorkingHour> get selectedEvents => _selectedEvents;

  Map<DateTime, List<models.WorkingHour>> _mapWorkingHour;
  Map<DateTime, List<models.WorkingHour>> get workingHour => _mapWorkingHour;

  Map<DateTime, List> _holidays;
  Map<DateTime, List> get holidays => _holidays;

  bool _isInit;
  bool get isInit => _isInit;

  int _currentPageIndex;
  int get currentPageIndex => _currentPageIndex;

  BookAppointmentProvider(providers.Partner partner) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);

    this._partnerProvider = partner;
  }

  update(providers.Partner partner) {
    this._partnerProvider = partner;

    notifyListeners();
  }

  initResource(String id) {
    DateTime now = DateTime.now();

    this._isInit = true;
    this._currentPageIndex = 0;
    this._progressLine1Color = PsykayGreyLightColor;
    this._progressLine2Color = PsykayGreyLightColor;
    this._indicator1Color = PsykayOrangeMediumColor;
    this._indicator2Color = PsykayGreyColor;
    this._indicator3Color = PsykayGreyColor;

    this._holidays = {};

    this._selectedEvents = [];

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initialLoad(id);
    });
  }

  close() {}

  onSubmitTime(
      models.WorkingHour workingHour, TabController tabController, int page) {
    onNext(tabController, page);
  }

  onNext(TabController tabController, int page) {
    _currentPageIndex = page;
    _tabController = tabController;
    _tabController.animateTo(page);

    switch (page) {
      case 0:
        _progressLine1Color = PsykayGreyLightColor;
        _progressLine2Color = PsykayGreyLightColor;
        _indicator1Color = PsykayOrangeMediumColor;
        _indicator2Color = PsykayGreyColor;
        _indicator3Color = PsykayGreyColor;
        break;
      case 1:
        _progressLine1Color = PsykayGreenLightColor;
        _progressLine2Color = PsykayGreyLightColor;
        _indicator1Color = PsykayGreenColor;
        _indicator2Color = PsykayOrangeMediumColor;
        _indicator3Color = PsykayGreyColor;
        break;
      case 2:
        _progressLine1Color = PsykayGreenLightColor;
        _progressLine2Color = PsykayGreenLightColor;
        _indicator1Color = PsykayGreenColor;
        _indicator2Color = PsykayGreenColor;
        _indicator3Color = PsykayOrangeMediumColor;
        break;
      default:
    }

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
            'First ${first.toIso8601String()} last ${last.toIso8601String()} formant ${format.toString()}');
  }

  onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    _log.info(
        method: 'onCalendarCreated',
        message:
            'First ${first.toIso8601String()} last ${last.toIso8601String()} formant ${format.toString()}');
  }

  Future initialLoad(String id) async {
    DateTime now = DateTime.now();

    Map<String, dynamic> queryParameter = {'partnerId': id};

    Map<String, dynamic> queryParameterSchedule = {
      'partnerId': id,
      'startDate': DateFormat('MM/dd/yyyy').format(now),
      'endDate': DateFormat('MM/dd/yyyy').format(now.add(Duration(days: 90)))
    };

    final futures = <Future>[
      _partnerProvider.fetchPartnerDetail(queryParameter),
      _partnerProvider.fetchSchedule(queryParameterSchedule)
    ];

    await Future.wait(futures);

    _generateWorkingHour();

    _selectedEvents =
        _mapWorkingHour[DateTime(now.year, now.month, now.day)] ?? [];

    _isInit = false;

    notifyListeners();
  }

  Future<bool> onWillPop() {
    if (_currentPageIndex != 0) {
      _currentPageIndex--;
      _tabController.animateTo(_currentPageIndex);

      switch (_currentPageIndex) {
        case 0:
          _progressLine1Color = PsykayGreyLightColor;
          _progressLine2Color = PsykayGreyLightColor;
          _indicator1Color = PsykayOrangeMediumColor;
          _indicator2Color = PsykayGreyColor;
          _indicator3Color = PsykayGreyColor;
          break;
        case 1:
          _progressLine1Color = PsykayGreenColor;
          _progressLine2Color = PsykayGreyLightColor;
          _indicator1Color = PsykayGreenColor;
          _indicator2Color = PsykayOrangeMediumColor;
          _indicator3Color = PsykayGreyColor;
          break;
        case 2:
          _progressLine1Color = PsykayGreenColor;
          _progressLine2Color = PsykayGreenColor;
          _indicator1Color = PsykayGreenColor;
          _indicator2Color = PsykayGreenColor;
          _indicator3Color = PsykayOrangeMediumColor;
          break;
        default:
      }

      notifyListeners();

      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  _generateWorkingHour() {
    Map<DateTime, List<models.WorkingHour>> result = {};

    _partnerProvider.listAvailabilityFull.forEach((element) {
      List<models.WorkingHour> wh = [];
      models.Availability tempAvailability;

      // Set booking time limit before 21:00
      var now = DateTime.now();
      var bookingTimeLimit = DateTime(
          now.year,
          now.month,
          now.day,
          config.FlavorConfig.instance.values.operationalTimeOff[0],
          config.FlavorConfig.instance.values.operationalTimeOff[1]);

      // Set start booking time 6 hours after 08:00 on off day (21:00 - 08:00)
      var startOperational = DateTime(
              now.year,
              now.month,
              now.day + 1,
              config.FlavorConfig.instance.values.operationTimeStart[0],
              config.FlavorConfig.instance.values.operationTimeStart[1])
          .add(Duration(
              hours: config.FlavorConfig.instance.values.bookingTimeThreshold));

      if (now.isAfter(bookingTimeLimit)) {
        if (element.startTime.isBefore(startOperational)) {
          // Start 6 hours after now
          if (element.endTime.isAfter(startOperational)) {
            tempAvailability = models.Availability(
                id: element.id,
                day: element.day,
                startTime: startOperational,
                endTime: element.endTime);
          }
        } else {
          tempAvailability = element;
        }
      } else {
        tempAvailability = element;
      }

      DateTime startTime;
      int difference;
      int sessions;

      List<models.PartnerSchedule> listAppointment = [];
      listAppointment
          .addAll(_partnerProvider.scheduleResource.appointmentResources);

      bool isBooked = false;

      if (tempAvailability != null) {
        // If schedule is same moment as today, show schedule six hour after this time
        if (DateFormat('yyyy-MM-dd').format(tempAvailability.startTime) ==
            DateFormat('yyyy-MM-dd').format(now)) {
          // First schedule is now + 6 hour
          var firstStartTime = DateTime(now.year, now.month, now.day, now.hour,
                  now.minute < 30 ? 0 : 30)
              .add(Duration(
                  hours: config
                      .FlavorConfig.instance.values.bookingTimeThreshold));

          if (firstStartTime.isAfter(tempAvailability.endTime)) {
            wh = [];
          } else {
            if (firstStartTime.isBefore(tempAvailability.startTime)) {
              difference = tempAvailability.endTime
                  .difference(tempAvailability.startTime)
                  .inMinutes;

              startTime = tempAvailability.startTime;
            } else {
              difference =
                  tempAvailability.endTime.difference(firstStartTime).inMinutes;
              startTime = firstStartTime;
            }

            sessions = (difference / 30).round() - 1;

            //  Check appointment schedule here
            listAppointment.forEach((value) {
              var valueDateTime = DateTime.parse(
                  '${value.startDate.split('T')[0]} ${value.startTime}');

              if (valueDateTime.isAtSameMomentAs(startTime)) {
                isBooked = true;

                return;
              }
            });

            wh.add(models.WorkingHour(
                partnerId: _partnerProvider.partnerData.id,
                dateTime: startTime,
                startTime: DateFormat('jm', 'ID').format(startTime),
                isBooked: isBooked));

            for (int i = 0; i < sessions; i++) {
              startTime = startTime.add(Duration(minutes: 30));

              // TODO: Check appointment schedule here
              isBooked = false;
              listAppointment.forEach((value) {
                var valueDateTime = DateTime.parse(
                    '${value.startDate.split('T')[0]} ${value.startTime}');

                if (valueDateTime.isAtSameMomentAs(startTime)) {
                  isBooked = true;

                  return;
                }
              });

              wh.add(models.WorkingHour(
                  partnerId: _partnerProvider.partnerData.id,
                  dateTime: startTime,
                  startTime: DateFormat('jm', 'ID').format(startTime),
                  isBooked: isBooked));
            }
          }
        } else {
          difference = tempAvailability.endTime
              .difference(tempAvailability.startTime)
              .inMinutes;

          startTime = tempAvailability.startTime;

          sessions = (difference / 30).round() - 1;

          //  Check appointment schedule here
          listAppointment.forEach((value) {
            var valueDateTime = DateTime.parse(
                '${value.startDate.split('T')[0]} ${value.startTime}');

            if (valueDateTime.isAtSameMomentAs(startTime)) {
              isBooked = true;

              return;
            }
          });

          wh.add(models.WorkingHour(
              partnerId: _partnerProvider.partnerData.id,
              dateTime: startTime,
              startTime: DateFormat('jm', 'ID').format(startTime),
              isBooked: isBooked));

          for (int i = 0; i < sessions; i++) {
            startTime = startTime.add(Duration(minutes: 30));

            // TODO: Check appointment schedule here
            isBooked = false;
            listAppointment.forEach((value) {
              var valueDateTime = DateTime.parse(
                  '${value.startDate.split('T')[0]} ${value.startTime}');

              if (valueDateTime.isAtSameMomentAs(startTime)) {
                isBooked = true;

                return;
              }
            });

            wh.add(models.WorkingHour(
                partnerId: _partnerProvider.partnerData.id,
                dateTime: startTime,
                startTime: DateFormat('jm', 'ID').format(startTime),
                isBooked: isBooked));
          }
        }

        DateTime key = DateFormat('yyyy-MM-dd')
            .parse(tempAvailability.startTime.toIso8601String());

        if (result.containsKey(key)) {
          result.update(key, (event) {
            event.addAll(wh);

            return event;
          });
        } else {
          result.addAll({key: wh});
        }
      }
    });
    _mapWorkingHour = result;
  }
}

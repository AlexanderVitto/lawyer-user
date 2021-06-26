import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../constraint.dart';
import '../../../../../enum.dart';

import '../../../../config/config.dart' as config;
import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;

import '../../../models/models.dart' as models;
import '../../../providers/providers.dart' as providers;

import '../../cart/cart_screen.dart';

import '../../shared/shared.dart';

import '../book_appointment_screen.dart';

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
  Color _text1Color;
  Color get text1Color => _text1Color;
  Color _text2Color;
  Color get text2Color => _text2Color;
  Color _text3Color;
  Color get text3Color => _text3Color;

  utils.LogUtils _log;

  helpers.AuthResultStatus _appointmentStatus;
  helpers.AuthResultStatus get appointmentStatus => _appointmentStatus;

  providers.Appointment _appointmentProvider;
  providers.Appointment get appointmentProvider => _appointmentProvider;
  providers.Partner _partnerProvider;
  providers.Partner get partnerProvider => _partnerProvider;

  models.Partner _partnerDetail;
  models.Partner get partnerDetail => _partnerDetail;
  models.PartnerPrice _partnerPrice;
  models.PartnerPrice get partnerPrice => _partnerPrice;

  models.StaticData _expertise;
  models.StaticData get expertise => _expertise;
  models.WorkingHour _selectedWorkingHour;
  models.WorkingHour get selectedWorkingHour => _selectedWorkingHour;

  List<models.PartnerPrice> _listPartnerPrice;
  List<models.PartnerPrice> get listPartnerPrice => _listPartnerPrice;
  List<models.WorkingHour> _selectedEvents;
  List<models.WorkingHour> get selectedEvents => _selectedEvents;

  Map<DateTime, List<models.WorkingHour>> _mapWorkingHour;
  Map<DateTime, List<models.WorkingHour>> get workingHour => _mapWorkingHour;

  Map<DateTime, List> _holidays;
  Map<DateTime, List> get holidays => _holidays;

  bool _isInit;
  bool get isInit => _isInit;
  bool _isBusy;
  bool get isBusy => _isBusy;

  int _currentPageIndex;
  int get currentPageIndex => _currentPageIndex;

  BookAppointmentProvider(
      providers.Partner partner, providers.Appointment appointment) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);

    this._appointmentProvider = appointment;
    this._partnerProvider = partner;
  }

  update(providers.Partner partner, providers.Appointment appointment) {
    this._appointmentProvider = appointment;
    this._partnerProvider = partner;

    notifyListeners();
  }

  initResource(String id, models.StaticData expertise) {
    this._expertise = expertise;
    this._isInit = true;
    this._isBusy = false;
    this._currentPageIndex = 0;
    this._progressLine1Color = PsykayGreyLightColor;
    this._progressLine2Color = PsykayGreyLightColor;
    this._indicator1Color = PsykayGreenColor;
    this._indicator2Color = PsykayGreyColor;
    this._indicator3Color = PsykayGreyColor;
    this._text1Color = PsykayGreenColor;
    this._text2Color = PsykayGreyLightColor;
    this._text3Color = PsykayGreyLightColor;

    this._holidays = {};

    this._selectedEvents = [];
    this._listPartnerPrice = [];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialLoad(id);
    });
  }

  close() {}

  onSubmitTime(
      models.WorkingHour workingHour, TabController tabController, int page) {
    _selectedWorkingHour = workingHour;
    onNext(tabController, page);
  }

  onSubmitPackage(int index, TabController tabController, int page) {
    _partnerPrice = _listPartnerPrice[index];

    onNext(tabController, page);
  }

  onNext(TabController tabController, int page) {
    _currentPageIndex = page;
    _tabController = tabController;
    _animateToIndex(page);

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
  }

  onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    _log.info(
        method: 'onCalendarCreated',
        message:
            'First ${first.toIso8601String()} last ${last.toIso8601String()} format ${format.toString()}');
  }

  setToBusy() {
    _isBusy = true;

    notifyListeners();
  }

  setToIdle() {
    _isBusy = false;

    notifyListeners();
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
      _partnerProvider.fetchPartnerPrice(queryParameter),
      _partnerProvider.fetchSchedule(queryParameterSchedule)
    ];

    await Future.wait(futures);

    _generateWorkingHour();

    _selectedEvents =
        _mapWorkingHour[DateTime(now.year, now.month, now.day)] ?? [];
    _partnerDetail = _partnerProvider.partnerData;
    _listPartnerPrice = _partnerDetail.partnerPrices
        .where((element) => element.priceSchema.isEnabled)
        .toList();
    // _listPartnerPrice = _partnerProvider.partnerPrice
    //     .where((value) => value.serviceCategoryId == 0)
    //     .toList();

    _isInit = false;

    notifyListeners();
  }

  Future onSubmit(BuildContext context) async {
    bool dialogValue = await questionDialog(
        context: context,
        title: 'Book Appointment',
        titleFontSize: 14,
        description: 'Do you want to proceed to payment?',
        descriptionFontSize: 12,
        buttonYesText: 'Ok',
        buttonNoText: 'No',
        buttonFontSize: 12,
        sizedBox2: 5,
        sizedBox3: 10);

    _log.debug(method: 'onSubmit', message: dialogValue.toString());

    if (dialogValue) {
      setToBusy();

      // submit appointment and redirect to cart screen
      models.AppointmentBody body = models.AppointmentBody(
          partnerId: _partnerDetail.id,
          serviceId: _expertise.id,
          priceSchemaId: _partnerPrice.priceSchemaId,
          partnerPriceId: _partnerPrice.id,
          price: _partnerPrice.priceSchema.basePrice,
          startDate:
              DateFormat('MM/dd/yyyy').format(_selectedWorkingHour.dateTime),
          endDate:
              DateFormat('MM/dd/yyyy').format(_selectedWorkingHour.dateTime),
          startTime: DateFormat('HH:mm').format(_selectedWorkingHour.dateTime),
          endTime: DateFormat('HH:mm').format(_selectedWorkingHour.dateTime.add(
              Duration(
                  minutes:
                      config.FlavorConfig.instance.values.consultationTime))),
          appointmentStatusId: 1);

      _log.info(method: 'onSubmit', message: jsonEncode(body));

      await _appointmentProvider.booking(body);

      _appointmentStatus = _appointmentProvider.appointmentStatus;

      setToIdle();

      if (_appointmentStatus ==
          helpers.AuthResultStatus.bookAppointmentSuccess) {
        Navigator.of(context).pushNamed(CartScreen.routeName,
            arguments: helpers.ScreenArguments(
                prevRoute: BookAppointmentScreen.routeName));
      } else {
        errorDialog(
            context: context,
            iconSize: 45,
            title: 'Book Appointment Failed!',
            titleFontSize: 12,
            description: helpers.AuthExceptionHandler.generateExceptionMessage(
                _appointmentStatus),
            descriptionFontSize: 10,
            buttonText: 'Okay',
            buttonFontSize: 10,
            sizedBox1: 15,
            sizedBox2: 5,
            sizedBox3: 20);
      }
    }
  }

  Future<bool> onWillPop() {
    if (_currentPageIndex != 0) {
      _currentPageIndex--;
      _animateToIndex(_currentPageIndex);

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
                startTime: DateFormat('jm', _partnerProvider.auth.language)
                    .format(startTime),
                endTime: DateFormat('jm', _partnerProvider.auth.language)
                    .format(startTime.add(Duration(
                        minutes: config
                            .FlavorConfig.instance.values.consultationTime))),
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
                  startTime: DateFormat('jm', _partnerProvider.auth.language)
                      .format(startTime),
                  endTime: DateFormat('jm', _partnerProvider.auth.language)
                      .format(startTime.add(Duration(
                          minutes: config
                              .FlavorConfig.instance.values.consultationTime))),
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
              startTime: DateFormat('jm', _partnerProvider.auth.language)
                  .format(startTime),
              endTime: DateFormat('jm', _partnerProvider.auth.language).format(
                  startTime.add(Duration(
                      minutes: config
                          .FlavorConfig.instance.values.consultationTime))),
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
                startTime: DateFormat('jm', _partnerProvider.auth.language)
                    .format(startTime),
                endTime: DateFormat('jm', _partnerProvider.auth.language)
                    .format(startTime.add(Duration(
                        minutes: config
                            .FlavorConfig.instance.values.consultationTime))),
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

  _animateToIndex(int page) {
    _tabController.animateTo(page);

    switch (page) {
      case 0:
        _progressLine1Color = PsykayGreyLightColor;
        _progressLine2Color = PsykayGreyLightColor;
        _indicator1Color = PsykayGreenColor;
        _indicator2Color = PsykayGreyColor;
        _indicator3Color = PsykayGreyColor;

        _text1Color = PsykayGreenColor;
        _text2Color = PsykayGreyLightColor;
        _text3Color = PsykayGreyLightColor;
        break;
      case 1:
        _progressLine1Color = PsykayGreenLightColor;
        _progressLine2Color = PsykayGreyLightColor;
        _indicator1Color = PsykayGreenLightColor;
        _indicator2Color = PsykayGreenColor;
        _indicator3Color = PsykayGreyColor;

        _text1Color = PsykayGreenLightColor;
        _text2Color = PsykayGreenColor;
        _text3Color = PsykayGreyLightColor;
        break;
      case 2:
        _progressLine1Color = PsykayGreenLightColor;
        _progressLine2Color = PsykayGreenLightColor;
        _indicator1Color = PsykayGreenLightColor;
        _indicator2Color = PsykayGreenLightColor;
        _indicator3Color = PsykayGreenColor;

        _text1Color = PsykayGreenLightColor;
        _text2Color = PsykayGreenLightColor;
        _text3Color = PsykayGreenColor;
        break;
      default:
    }
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../enum.dart';

import '../../../../config/config.dart' as config;
import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;

import '../../../models/models.dart' as models;
import '../../../providers/providers.dart' as providers;

import '../../book_appointment/book_appointment_screen.dart';

class PsychologistProfileProvider with ChangeNotifier {
  static const fileName =
      'lib/app/src/screens/psychologist_profile/provider/psychologist_profile_provider.dart';

  utils.LogUtils _log;

  providers.Partner _partnerProvider;
  providers.StaticData _staticDataProvider;
  providers.StaticData get staticDataProvider => _staticDataProvider;

  models.Partner _partnerDetail;
  models.Partner get partnerDetail => _partnerDetail;
  models.StaticData _expertise;
  models.StaticData get expertise => _expertise;

  Map<DaysOfWeek, List<models.Availability>> get mapAvailability {
    Map<DaysOfWeek, List<models.Availability>> result = {};

    _partnerProvider.listAvailability.forEach((element) {
      if (result.containsKey(element.day)) {
        var isNew = false;

        result[element.day].forEach((resultData) {
          if (element.startTime.isBefore(resultData.startTime) &&
              element.endTime.isAfter(resultData.endTime)) {
            resultData.id.addAll(element.id);
            resultData.startTime = element.startTime;
            resultData.endTime = element.endTime;
          } else if (element.startTime.isAtSameMomentAs(resultData.startTime)) {
            resultData.id.addAll(element.id);
            if (element.endTime.isAfter(resultData.endTime))
              resultData.endTime = element.endTime;
          } else if (element.startTime.isAtSameMomentAs(resultData.endTime)) {
            resultData.id.addAll(element.id);
            resultData.endTime = element.endTime;
          } else if (element.endTime.isAtSameMomentAs(resultData.endTime)) {
            resultData.id.addAll(element.id);
            if (element.startTime.isBefore(resultData.startTime))
              resultData.startTime = element.startTime;
          } else if (element.endTime.isAtSameMomentAs(resultData.startTime)) {
            resultData.id.addAll(element.id);
            resultData.startTime = element.startTime;
          } else if (element.startTime.isAfter(resultData.startTime) &&
              element.startTime.isBefore(resultData.endTime)) {
            resultData.id.addAll(element.id);
            if (element.endTime.isAfter(resultData.endTime))
              resultData.endTime = element.endTime;
          } else if (element.endTime.isAfter(resultData.startTime) &&
              element.endTime.isBefore(resultData.endTime)) {
            resultData.id.addAll(element.id);
            if (element.startTime.isBefore(resultData.startTime))
              resultData.startTime = element.startTime;
          } else {
            isNew = true;
          }
        });

        if (isNew) {
          result[element.day].add(models.Availability(
              id: element.id,
              startTime: element.startTime,
              endTime: element.endTime));
        }
      } else {
        result[element.day] = [
          models.Availability(
            id: element.id,
            startTime: element.startTime,
            endTime: element.endTime,
          )
        ];
      }
    });

    return result;
  }

  bool _isInit;
  bool get isInit => _isInit;

  PsychologistProfileProvider(
      providers.Partner partner, providers.StaticData staticData) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);

    this._partnerProvider = partner;
    this._staticDataProvider = staticData;
  }

  update(providers.Partner partner, providers.StaticData staticData) {
    this._partnerProvider = partner;
    this._staticDataProvider = staticData;

    notifyListeners();
  }

  initResource(String id, models.StaticData expertise) {
    this._isInit = true;
    this._expertise = expertise;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialLoad(id);
    });
  }

  navigateToBookAppointment(BuildContext context) {
    Navigator.of(context).pushNamed(BookAppointmentScreen.routeName,
        arguments: helpers.ScreenArguments(
            partnerData: _partnerDetail, staticData: _expertise));
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

    _partnerDetail = _partnerProvider.partnerData;

    _isInit = false;
    notifyListeners();
  }
}

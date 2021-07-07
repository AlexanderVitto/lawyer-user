import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rrule/rrule.dart';
import 'package:time_machine/time_machine.dart';

import '../../../enum.dart';
import '../../config/config.dart' as config;
import '../../helpers/helpers.dart' as helpers;
import '../../utils/utils.dart' as utils;
import '../../services/partner.dart' as partner;

import '../models/models.dart' as models;

import 'providers.dart';

class Partner with ChangeNotifier {
  static const fileName = 'lib/app/src/providers/partner.dart';

  utils.LogUtils _log;

  partner.PartnerAPI _partnerAPI;

  Auth _auth;
  Auth get auth => _auth;

  models.Partner _partnerData;
  models.Partner get partnerData => _partnerData;
  models.ScheduleResource _scheduleResource;
  models.ScheduleResource get scheduleResource => _scheduleResource;

  List<models.Partner> _listPartner;
  List<models.Partner> get listPartner => _listPartner;
  List<models.PartnerPrice> _partnerPrice;
  List<models.PartnerPrice> get partnerPrice => _partnerPrice;

  List<models.Availability> _listAvailability;
  List<models.Availability> get listAvailability => _listAvailability;
  List<models.Availability> _listAvailabilityFull;
  List<models.Availability> get listAvailabilityFull => _listAvailabilityFull;
  List<models.WorkingHour> _listWorkingHour;
  List<models.WorkingHour> get listWorkingHour => _listWorkingHour;

  Map<String, dynamic> _currentQueryParamLisPartner;
  Map<String, dynamic> get currentQueryParamListPartner =>
      _currentQueryParamLisPartner;

  Partner() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._partnerAPI = config.locator<partner.PartnerAPI>();

    this._listPartner = [];
    this._partnerPrice = [];
    this._listAvailability = [];
    this._listAvailabilityFull = [];
    this._listWorkingHour = [];
    this._currentQueryParamLisPartner = {};
  }

  update(Auth auth) {
    this._auth = auth;

    notifyListeners();
  }

  setQueryParamListPartner(Map<String, dynamic> data) {
    _currentQueryParamLisPartner = data;
  }

  Future fetchListPartner(Map<String, dynamic> queryParameter) async {
    final String method = 'fetchListPartner';

    utils.ApiReturn<models.ResponseListPartner> apiRequest = await _partnerAPI
        .listPartnerByPreference3(_currentQueryParamLisPartner, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }

      _listPartner = [];
    } else {
      if (apiRequest.value.status) {
        _listPartner = apiRequest.value.result;
      } else {
        _listPartner = [];
      }
    }

    notifyListeners();
  }

  Future fetchSchedule(Map<String, dynamic> queryParameter) async {
    final String method = 'fetchSchedule';

    utils.ApiReturn<models.ResponseScheduleResource> apiRequest =
        await _partnerAPI.scheduleResource(queryParameter, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }

      _scheduleResource = null;
    } else {
      if (apiRequest.value.status) {
        _scheduleResource = apiRequest.value.result;

        _listAvailability =
            _generateAvailability(_scheduleResource.scheduleRules, 1);
        _listAvailabilityFull =
            _generateAvailability(_scheduleResource.scheduleRules, 12);

        listAvailability.sort((a, b) => a.startTime.compareTo(b.startTime));
        listAvailability.sort((a, b) => a.day.index.compareTo(b.day.index));

        _listAvailabilityFull
            .sort((a, b) => a.startTime.compareTo(b.startTime));
        _listAvailabilityFull
            .sort((a, b) => a.day.index.compareTo(b.day.index));
      } else {
        _scheduleResource = null;
      }
    }

    notifyListeners();
  }

  Future<bool> fetchMoreListPartner(Map<String, dynamic> queryParameter) async {
    final String method = 'fetchMoreListPartner';
    bool result = false;

    utils.ApiReturn<models.ResponseListPartner> apiRequest =
        await _partnerAPI.listPartnerByPreference3(queryParameter, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }

      result = true;
    } else {
      if (apiRequest.value.status) {
        _listPartner.addAll(apiRequest.value.result);
        result = false;
      } else {
        result = true;
      }
    }

    notifyListeners();

    return result;
  }

  Future fetchPartnerDetail(Map<String, dynamic> queryParameter) async {
    final String method = 'fetchPartnerDetail';

    utils.ApiReturn<models.ResponsePartner> apiRequest =
        await _partnerAPI.detail(queryParameter, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }

      _partnerData = null;
    } else {
      if (apiRequest.value.status) {
        _partnerData = apiRequest.value.result;
      } else {
        _partnerData = null;
      }
    }

    notifyListeners();
  }

  Future fetchPartnerDetailByExpertise(
      Map<String, dynamic> queryParameter) async {
    final String method = 'fetchPartnerDetailByExpertise';

    utils.ApiReturn<models.ResponsePartner> apiRequest =
        await _partnerAPI.detailByExpertise(queryParameter, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }

      _partnerData = null;
    } else {
      if (apiRequest.value.status) {
        _partnerData = apiRequest.value.result;
      } else {
        _partnerData = null;
      }
    }

    notifyListeners();
  }

  Future fetchPartnerPrice(Map<String, dynamic> queryParameter) async {
    final String method = 'fetchPartnerPrice';

    utils.ApiReturn<models.ResponsePartnerPrice> apiRequest =
        await _partnerAPI.price(queryParameter, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }

      _partnerPrice = [];
    } else {
      if (apiRequest.value.status) {
        _partnerPrice = apiRequest.value.result;
      } else {
        _partnerPrice = [];
      }
    }

    notifyListeners();
  }

  List<models.Availability> _generateAvailability(
      List<models.PartnerSchedule> schedule, day) {
    List<models.Availability> result = [];

    schedule.forEach((scheduleData) {
      var dates =
          RecurrenceRule.fromString('RRULE:${scheduleData.recurrenceRule}')
              .getInstances(start: LocalDateTime.now())
              .take(day);

      dates.forEach((datesData) {
        DaysOfWeek day;

        String dateTime =
            DateFormat('yyyy-MM-dd').format(datesData.toDateTimeLocal());

        var startDateFormat =
            DateTime.parse('$dateTime ${scheduleData.startTime}');
        var endDateFormat = DateTime.parse('$dateTime ${scheduleData.endTime}');

        day = DaysOfWeek.values[startDateFormat.weekday - 1];

        result.add(models.Availability(
            id: [scheduleData.id],
            day: day,
            startTime: startDateFormat,
            endTime: endDateFormat));
      });
    });

    return result;
  }

  clear() {
    this._partnerData = null;
    this._scheduleResource = null;
    this._listPartner = [];
    this._partnerPrice = [];
    this._listAvailability = [];
    this._listAvailabilityFull = [];
    this._listWorkingHour = [];
    this._currentQueryParamLisPartner = {};
    notifyListeners();
  }
}

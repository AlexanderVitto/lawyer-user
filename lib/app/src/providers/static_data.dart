import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/config.dart' as config;
import '../../helpers/helpers.dart' as helpers;
import '../../utils/utils.dart' as utils;
import '../../services/geo_location.dart' as geoLocation;
import '../../services/master_bank.dart' as bank;
import '../../services/master_expertise.dart' as expertise;
import '../../services/static.dart' as staticService;

import '../models/models.dart' as models;

import 'providers.dart';

class StaticData with ChangeNotifier {
  static const fileName = 'lib/app/src/providers/static_data.dart';

  final List<models.StaticData> maritalStatus = [
    models.StaticData(id: 1, name: 'Single'),
    models.StaticData(id: 2, name: 'Married'),
    models.StaticData(id: 3, name: 'Divorce')
  ];

  final List<models.StaticData> genderStatus = [
    models.StaticData(id: 1, name: 'Male'),
    models.StaticData(id: 2, name: 'Female'),
    models.StaticData(id: 3, name: 'Others')
  ];

  utils.LogUtils _log;

  geoLocation.GeoLocationAPI _geoLocationAPI;
  bank.MasterBankAPI _masterBankAPI;
  expertise.MasterExpertiseAPI _masterExpertiseAPI;
  staticService.StaticAPI _staticAPI;

  Auth _auth;
  Auth get auth => _auth;

  helpers.AuthResultStatus _geoLocationResult;
  helpers.AuthResultStatus get geoLocationResult => _geoLocationResult;

  List<models.MasterBank> _bankData;
  List<models.MasterBank> get bankData => _bankData;
  List<models.GeoLocation> _location;
  List<models.GeoLocation> get location => _location;

  List<models.StaticData> _expertiseData;
  List<models.StaticData> get expertiseData => _expertiseData;
  List<models.StaticData> _cardTypeData;
  List<models.StaticData> get cardTypeData => _cardTypeData;
  List<models.StaticData> _religionData;
  List<models.StaticData> get religionData => _religionData;
  List<models.StaticData> _lastEducationData;
  List<models.StaticData> get lastEducationData => _lastEducationData;
  List<models.StaticData> _occupationData;
  List<models.StaticData> get occupationData => _occupationData;

  List<String> _countriesData;
  List<String> get countriesData => _countriesData;

  StaticData() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);

    this._geoLocationAPI = config.locator<geoLocation.GeoLocationAPI>();
    this._masterBankAPI = config.locator<bank.MasterBankAPI>();
    this._masterExpertiseAPI = config.locator<expertise.MasterExpertiseAPI>();
    this._staticAPI = config.locator<staticService.StaticAPI>();

    this._bankData = [];
    this._location = [];
    this._expertiseData = [];
    this._cardTypeData = [];
    this._religionData = [];
    this._lastEducationData = [];
    this._occupationData = [];
    this._countriesData = [];
  }

  update(Auth auth) {
    this._auth = auth;

    notifyListeners();
  }

  Future fetchExpertise() async {
    final String method = 'fetchExpertise';

    utils.ApiReturn<models.ResponseListMasterExpertise> apiRequest =
        await _masterExpertiseAPI.getAll(_auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }
    } else {
      if (apiRequest.value.status) {
        _expertiseData = apiRequest.value.result;
      }
    }

    notifyListeners();
  }

  Future fetchBank() async {
    final String method = 'fetchBank';

    utils.ApiReturn<models.ResponseListMasterBank> apiRequest =
        await _masterBankAPI.getAll(_auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }
    } else {
      if (apiRequest.value.status) {
        _bankData = apiRequest.value.result;
      }
    }

    notifyListeners();
  }

  Future fetchCountries() async {
    final String method = 'fetchCountries';

    utils.ApiReturn<models.ResponseListString> apiRequest =
        await _geoLocationAPI.getCountry(_auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }
    } else {
      if (apiRequest.value.status) {
        _countriesData = apiRequest.value.result;
      }
    }

    notifyListeners();
  }

  Future fetchCardType() async {
    final String method = 'fetchCardType';

    utils.ApiReturn<models.ResponseListStaticData> apiRequest =
        await _staticAPI.staticData('IdType', _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }
    } else {
      if (apiRequest.value.status) {
        _cardTypeData = apiRequest.value.result;
      }
    }

    notifyListeners();
  }

  Future fetchReligion() async {
    final String method = 'fetchReligion';

    utils.ApiReturn<models.ResponseListStaticData> apiRequest =
        await _staticAPI.staticData('Religion', _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }
    } else {
      if (apiRequest.value.status) {
        _religionData = apiRequest.value.result;
      }
    }

    notifyListeners();
  }

  Future fetchEducation() async {
    final String method = 'fetchEducation';

    utils.ApiReturn<models.ResponseListStaticData> apiRequest =
        await _staticAPI.staticData('Education', _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }
    } else {
      if (apiRequest.value.status) {
        _lastEducationData = apiRequest.value.result;
      }
    }

    notifyListeners();
  }

  Future fetchOccupation() async {
    final String method = 'fetchOccupation';

    utils.ApiReturn<models.ResponseListStaticData> apiRequest =
        await _staticAPI.staticData('Occupation', _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }
    } else {
      if (apiRequest.value.status) {
        _occupationData = apiRequest.value.result;
      }
    }

    notifyListeners();
  }

  Future searchLocation(Map<String, dynamic> queryParameter) async {
    final String method = 'searchLocation';

    utils.ApiReturn<models.ResponseGeoLocation> apiRequest =
        await _geoLocationAPI.search(queryParameter, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }

      _geoLocationResult = helpers.AuthResultStatus.apiConnectionError;
    } else {
      if (apiRequest.value.status) {
        if (apiRequest.value.result.isEmpty) {
          _geoLocationResult = helpers.AuthResultStatus.zipCodeNotFound;
        } else {
          _geoLocationResult = helpers.AuthResultStatus.successful;

          _location = apiRequest.value.result;
        }
      } else {
        _geoLocationResult = helpers.AuthResultStatus.zipCodeNotFound;
      }
    }

    notifyListeners();
  }

  models.StaticData getMaritalStatus(int id) {
    models.StaticData result = maritalStatus
        .firstWhere((element) => element.id == id, orElse: () => null);
    if (result != null) {
      result.isSelected = true;
    }
    return result;
  }

  models.StaticData getGenderStatus(int id) {
    models.StaticData result = genderStatus
        .firstWhere((element) => element.id == id, orElse: () => null);

    if (result != null) {
      result.isSelected = true;
    }
    return result;
  }

  models.StaticData getCardTypeById(int key) {
    models.StaticData result = _cardTypeData
        .firstWhere((element) => element.id == key, orElse: () => null);

    if (result != null) {
      result.isSelected = true;
    }
    return result;
  }

  models.StaticData getCardTypeByName(String key) {
    models.StaticData result = _cardTypeData.firstWhere(
        (element) =>
            element.name.contains(new RegExp(key, caseSensitive: false)),
        orElse: () => null);

    if (result != null) {
      result.isSelected = true;
    }

    return result;
  }

  models.StaticData getReligionById(int key) {
    models.StaticData result = _religionData
        .firstWhere((element) => element.id == key, orElse: () => null);

    if (result != null) {
      result.isSelected = true;
    }
    return result;
  }

  models.StaticData getReligionByName(String key) {
    models.StaticData result = _religionData.firstWhere(
        (element) =>
            element.name.contains(new RegExp(key, caseSensitive: false)),
        orElse: () => null);

    if (result != null) {
      result.isSelected = true;
    }
    return result;
  }

  models.StaticData getLastEducationById(int key) {
    models.StaticData result = _lastEducationData
        .firstWhere((element) => element.id == key, orElse: () => null);

    if (result != null) {
      result.isSelected = true;
    }
    return result;
  }

  models.StaticData getLastEducationByName(String key) {
    models.StaticData result = _lastEducationData.firstWhere(
        (element) =>
            element.name.contains(new RegExp(key, caseSensitive: false)),
        orElse: () => null);

    if (result != null) {
      result.isSelected = true;
    }
    return result;
  }

  models.StaticData getOccupationById(int key) {
    models.StaticData result = _occupationData
        .firstWhere((element) => element.id == key, orElse: () => null);

    if (result != null) {
      result.isSelected = true;
    }
    return result;
  }

  models.StaticData getOccupationByName(String key) {
    models.StaticData result = _occupationData.firstWhere(
        (element) =>
            element.name.contains(new RegExp(key, caseSensitive: false)),
        orElse: () => null);

    if (result != null) {
      result.isSelected = true;
    }
    return result;
  }
}

import 'package:flutter/material.dart';

import '../../config/config.dart' as config;
import '../../helpers/helpers.dart' as helpers;
import '../../utils/utils.dart' as utils;
import '../../services/partner.dart' as partner;

import '../models/models.dart' as models;

import 'providers.dart';

class Partner with ChangeNotifier {
  static const fileName = 'lib/app/src/providers/partner.dart';

  utils.Connection _connection;
  utils.LogUtils _log;

  partner.PartnerAPI _partnerAPI;

  Auth _auth;
  Auth get auth => _auth;

  models.Partner _partnerData;
  models.Partner get partnerData => _partnerData;

  List<models.Partner> _listPartner;
  List<models.Partner> get listPartner => _listPartner;

  Map<String, dynamic> _currentQueryParamLisPartner;
  Map<String, dynamic> get currentQueryParamListPartner =>
      _currentQueryParamLisPartner;

  Partner() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._partnerAPI = config.locator<partner.PartnerAPI>();

    this._listPartner = [];
    this._currentQueryParamLisPartner = {};
  }

  update(Auth auth) {
    this._auth = auth;
    this._connection = auth.connection;

    notifyListeners();
  }

  setQueryParamListPartner(Map<String, dynamic> data) {
    _currentQueryParamLisPartner = data;
  }

  Future fetchListPartner(Map<String, dynamic> queryParameter) async {
    final String method = 'fetchListPartner';

    await _connection.check();

    utils.ApiReturn<models.ResponseListPartner> apiRequest = await _partnerAPI
        .listPartnerByPreference3(_currentQueryParamLisPartner, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Force logout

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

  Future fetchPartnerDetail(Map<String, dynamic> queryParameter) async {
    final String method = 'fetchPartnerDetail';

    await _connection.check();

    utils.ApiReturn<models.ResponsePartner> apiRequest =
        await _partnerAPI.detail(queryParameter, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Force logout

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

    await _connection.check();

    utils.ApiReturn<models.ResponsePartner> apiRequest =
        await _partnerAPI.detailByExpertise(queryParameter, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Force logout

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
}

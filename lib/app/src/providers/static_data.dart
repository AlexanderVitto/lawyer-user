import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/config.dart' as config;
import '../../helpers/helpers.dart' as helpers;
import '../../utils/utils.dart' as utils;
import '../../services/master_expertise.dart' as expertise;

import '../models/models.dart' as models;

import 'providers.dart';

class StaticData with ChangeNotifier {
  static const fileName = 'lib/app/src/providers/static_data.dart';

  utils.Connection _connection;
  utils.LogUtils _log;

  expertise.MasterExpertiseAPI _masterExpertiseAPI;

  Auth _auth;
  Auth get auth => _auth;

  List<models.StaticData> _expertiseData;
  List<models.StaticData> get expertiseData => _expertiseData;

  StaticData() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._masterExpertiseAPI = config.locator<expertise.MasterExpertiseAPI>();

    this._expertiseData = [];
  }

  update(Auth auth) {
    this._auth = auth;
    this._connection = auth.connection;

    notifyListeners();
  }

  Future fetchExpertise() async {
    final String method = 'fetchExpertise';

    await _connection.check();

    utils.ApiReturn<models.ResponseListMasterExpertise> apiRequest =
        await _masterExpertiseAPI.getAll(_auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Force logout
      }
    } else {
      if (apiRequest.value.status) {
        _expertiseData = apiRequest.value.result;
      }
    }

    notifyListeners();
  }
}

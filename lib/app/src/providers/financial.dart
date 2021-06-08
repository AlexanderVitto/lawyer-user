import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psykay_userapp_v2/app/services/appointment.dart';

import '../../config/config.dart' as config;
import '../../helpers/helpers.dart' as helpers;
import '../../utils/utils.dart' as utils;
import '../../services/financial.dart' as financial;

import '../models/models.dart' as models;

import 'providers.dart';

class Financial with ChangeNotifier {
  static const fileName = 'lib/app/src/providers/financial.dart';

  utils.Connection _connection;
  utils.LogUtils _log;

  financial.FinancialAPI _financialAPI;

  Auth _auth;
  Auth get auth => _auth;

  double _balance = 0;
  String get balance => NumberFormat('#,##0.00', 'ID').format(_balance);

  Financial() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._financialAPI = config.locator<financial.FinancialAPI>();
  }

  update(Auth auth) {
    this._auth = auth;
    this._connection = auth.connection;

    notifyListeners();
  }

  Future fetchBalance(Map<String, dynamic> queryParameter) async {
    final String method = 'fetchBalance';

    await _connection.check();

    utils.ApiReturn<models.ResponseBalance> apiRequest =
        await _financialAPI.getWalletBalance(queryParameter, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Force logout

      }

      _balance = 0;
    } else {
      if (apiRequest.value.status) {
        _balance = apiRequest.value.result;
      } else {
        _balance = 0;
      }
    }

    notifyListeners();
  }
}

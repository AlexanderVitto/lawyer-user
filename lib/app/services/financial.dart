import 'dart:io';

import '../config/config.dart' as config;
import '../helpers/helpers.dart' as helpers;
import '../src/models/models.dart' as models;
import '../utils/utils.dart' as utils;

abstract class FinancialAPI {
  Future<utils.ApiReturn<models.ResponseBalance>> getWalletBalance(
      Map<String, dynamic> queryParameter, String token);

  Future<utils.ApiReturn<models.ResponseWithdrawal>> requestWithdraw(
      models.Withdrawal body, String token);
}

class Production implements FinancialAPI {
  static const fileName = 'lib/app/services/financial.dart';

  utils.LogUtils _log;
  helpers.Request _request;

  Production() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._request = config.locator<helpers.Request>();
  }

  @override
  Future<utils.ApiReturn<models.ResponseBalance>> getWalletBalance(
      Map<String, dynamic> queryParameter, String token) async {
    final String method = 'getWalletBalance';
    models.ResponseBalance result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/Financial/GetWalletBalance';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token, queryParameter: queryParameter);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseBalance>(
            status: false,
            value: models.ResponseBalance(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseBalance>(
            status: false,
            value: models.ResponseBalance(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseBalance.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseBalance>(status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseWithdrawal>> requestWithdraw(
      models.Withdrawal body, String token) async {
    final String method = 'requestWithdraw';
    models.ResponseWithdrawal result;

    final url =
        "${config.FlavorConfig.instance.values.host}/api/Financial/requestWithdraw";
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.postRequest(url, body.toJson(), token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseWithdrawal>(
            status: false,
            value: models.ResponseWithdrawal(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseWithdrawal>(
            status: false,
            value: models.ResponseWithdrawal(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseWithdrawal.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseWithdrawal>(
        status: true, value: result);
  }
}

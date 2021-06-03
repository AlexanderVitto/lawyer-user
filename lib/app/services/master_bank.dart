import 'dart:io';

import '../config/config.dart' as config;
import '../helpers/helpers.dart' as helpers;
import '../src/models/models.dart' as models;
import '../utils/utils.dart' as utils;

abstract class MasterBankAPI {
  Future<utils.ApiReturn<models.ResponseMasterBank>> getBank(
      Map<String, dynamic> queryParameter, String token);

  Future<utils.ApiReturn<models.ResponseListMasterBank>> getAll(String token);
}

class Production implements MasterBankAPI {
  static const fileName = 'lib/app/services/master_bank.dart';

  utils.LogUtils _log;
  helpers.Request _request;

  Production() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._request = config.locator<helpers.Request>();
  }

  @override
  Future<utils.ApiReturn<models.ResponseListMasterBank>> getAll(
      String token) async {
    final String method = 'getAll';
    models.ResponseListMasterBank result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/Masterbank/getAll';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseListMasterBank>(
            status: false,
            value: models.ResponseListMasterBank(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseListMasterBank>(
            status: false,
            value: models.ResponseListMasterBank(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseListMasterBank.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseListMasterBank>(
        status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseMasterBank>> getBank(
      Map<String, dynamic> queryParameter, String token) async {
    final String method = 'getBank';
    models.ResponseMasterBank result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/Masterbank/get';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token, queryParameter: queryParameter);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseMasterBank>(
            status: false,
            value: models.ResponseMasterBank(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseMasterBank>(
            status: false,
            value: models.ResponseMasterBank(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseMasterBank.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseMasterBank>(
        status: true, value: result);
  }
}

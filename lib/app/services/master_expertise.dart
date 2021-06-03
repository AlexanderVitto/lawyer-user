import 'dart:io';

import '../config/config.dart' as config;
import '../helpers/helpers.dart' as helpers;
import '../src/models/models.dart' as models;
import '../utils/utils.dart' as utils;

abstract class MasterExpertiseAPI {
  Future<utils.ApiReturn<models.ResponseMasterExpertise>> getExpertise(
      Map<String, dynamic> queryParameter, String token);

  Future<utils.ApiReturn<models.ResponseListMasterExpertise>> getAll(
      String token);
}

class Production implements MasterExpertiseAPI {
  static const fileName = 'lib/app/services/master_expertise.dart';

  utils.LogUtils _log;
  helpers.Request _request;

  Production() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._request = config.locator<helpers.Request>();
  }

  @override
  Future<utils.ApiReturn<models.ResponseListMasterExpertise>> getAll(
      String token) async {
    final String method = 'getAll';
    models.ResponseListMasterExpertise result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/MasterExpertise/Get';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseListMasterExpertise>(
            status: false,
            value: models.ResponseListMasterExpertise(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseListMasterExpertise>(
            status: false,
            value:
                models.ResponseListMasterExpertise(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseListMasterExpertise.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseListMasterExpertise>(
        status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseMasterExpertise>> getExpertise(
      Map<String, dynamic> queryParameter, String token) async {
    final String method = 'getExpertise';
    models.ResponseMasterExpertise result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/MasterExpertise/GetById';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token, queryParameter: queryParameter);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseMasterExpertise>(
            status: false,
            value: models.ResponseMasterExpertise(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseMasterExpertise>(
            status: false,
            value: models.ResponseMasterExpertise(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseMasterExpertise.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseMasterExpertise>(
        status: true, value: result);
  }
}

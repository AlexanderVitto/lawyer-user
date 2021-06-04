import 'dart:io';

import '../config/config.dart' as config;
import '../helpers/helpers.dart' as helpers;
import '../src/models/models.dart' as models;
import '../utils/utils.dart' as utils;

abstract class PartnerAPI {
  Future<utils.ApiReturn<models.ResponseListPartner>> listPartnerByPreference3(
      Map<String, dynamic> queryParameter, String token);

  Future<utils.ApiReturn<models.ResponsePartner>> detail(
      Map<String, dynamic> queryParameter, String token);

  Future<utils.ApiReturn<models.ResponsePartner>> detailByExpertise(
      Map<String, dynamic> queryParameter, String token);
}

class Production implements PartnerAPI {
  static const fileName = 'lib/app/services/partner.dart';

  utils.LogUtils _log;
  helpers.Request _request;

  Production() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._request = config.locator<helpers.Request>();
  }

  @override
  Future<utils.ApiReturn<models.ResponsePartner>> detail(
      Map<String, dynamic> queryParameter, String token) async {
    final String method = 'detail';
    models.ResponsePartner result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/Partner/Detail';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token, queryParameter: queryParameter);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponsePartner>(
            status: false,
            value: models.ResponsePartner(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponsePartner>(
            status: false,
            value: models.ResponsePartner(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponsePartner.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponsePartner>(status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponsePartner>> detailByExpertise(
      Map<String, dynamic> queryParameter, String token) async {
    final String method = 'detailByExpertise';
    models.ResponsePartner result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/Partner/DetailByExpertise';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token, queryParameter: queryParameter);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponsePartner>(
            status: false,
            value: models.ResponsePartner(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponsePartner>(
            status: false,
            value: models.ResponsePartner(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponsePartner.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponsePartner>(status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseListPartner>> listPartnerByPreference3(
      Map<String, dynamic> queryParameter, String token) async {
    final String method = 'listPartnerByPreference3';
    models.ResponseListPartner result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/Partner/listPartnerByPreference3';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token, queryParameter: queryParameter);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseListPartner>(
            status: false,
            value: models.ResponseListPartner(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseListPartner>(
            status: false,
            value: models.ResponseListPartner(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseListPartner.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseListPartner>(
        status: true, value: result);
  }
}

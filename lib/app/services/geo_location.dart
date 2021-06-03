import 'dart:io';

import '../config/config.dart' as config;
import '../helpers/helpers.dart' as helpers;
import '../src/models/models.dart' as models;
import '../utils/utils.dart' as utils;

abstract class GeoLocationAPI {
  Future<utils.ApiReturn<models.ResponseListString>> getCountry(String token);

  Future<utils.ApiReturn<models.ResponseGeoLocation>> search(
      Map<String, dynamic> queryParameter, String token);
}

class Production implements GeoLocationAPI {
  static const fileName = 'lib/app/services/geo_location.dart';

  utils.LogUtils _log;
  helpers.Request _request;

  Production() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._request = config.locator<helpers.Request>();
  }

  @override
  Future<utils.ApiReturn<models.ResponseListString>> getCountry(
      String token) async {
    final String method = 'getCountry';
    models.ResponseListString result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/GeoLocation/GetCountry';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseListString>(
            status: false,
            value: models.ResponseListString(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseListString>(
            status: false,
            value: models.ResponseListString(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseListString.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseListString>(
        status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseGeoLocation>> search(
      Map<String, dynamic> queryParameter, String token) async {
    final String method = 'search';
    models.ResponseGeoLocation result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/GeoLocation/Search';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token, queryParameter: queryParameter);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseGeoLocation>(
            status: false,
            value: models.ResponseGeoLocation(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseGeoLocation>(
            status: false,
            value: models.ResponseGeoLocation(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseGeoLocation.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseGeoLocation>(
        status: true, value: result);
  }
}

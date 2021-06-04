import 'dart:io';

import '../config/config.dart' as config;
import '../helpers/helpers.dart' as helpers;
import '../src/models/models.dart' as models;
import '../utils/utils.dart' as utils;

abstract class NotificationAPI {
  Future<utils.ApiReturn<models.ResponseAllNotification>> getNotification(
      Map<String, dynamic> queryParameter, String token);

  Future<utils.ApiReturn<models.ResponseNotification>> readNotification(
      models.NotificationBody body, String token);
}

class Production implements NotificationAPI {
  static const fileName = 'lib/app/services/notification.dart';

  utils.LogUtils _log;
  helpers.Request _request;

  Production() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._request = config.locator<helpers.Request>();
  }

  @override
  Future<utils.ApiReturn<models.ResponseAllNotification>> getNotification(
      Map<String, dynamic> queryParameter, String token) async {
    final String method = 'getNotification';
    models.ResponseAllNotification result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/notification/Get';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token, queryParameter: queryParameter);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseAllNotification>(
            status: false,
            value: models.ResponseAllNotification(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseAllNotification>(
            status: false,
            value: models.ResponseAllNotification(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseAllNotification.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseAllNotification>(
        status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseNotification>> readNotification(
      models.NotificationBody body, String token) async {
    final String method = 'requestWithdraw';
    models.ResponseNotification result;

    final url =
        "${config.FlavorConfig.instance.values.host}/api/Notification/ReadNotifInfo";
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.postRequest(url, body.toJson(), token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseNotification>(
            status: false,
            value: models.ResponseNotification(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseNotification>(
            status: false,
            value: models.ResponseNotification(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseNotification.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseNotification>(
        status: true, value: result);
  }
}

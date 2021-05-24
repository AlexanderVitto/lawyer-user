import 'dart:io';

import '../config/config.dart' as config;
import '../helpers/helpers.dart' as helpers;
import '../src/models/models.dart' as models;
import '../utils/utils.dart' as utils;

abstract class IdentityAPI {
  Future<utils.ApiReturn<models.ChannelResponse>> updateUser(
      models.Channel body, String token);
}

class Production implements IdentityAPI {
  static const fileName = 'lib/app/services/identity.dart';

  utils.LogUtils _log;
  helpers.Request _request;

  Production() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._request = config.locator<helpers.Request>();
  }

  @override
  Future<utils.ApiReturn<models.ChannelResponse>> updateUser(
      models.Channel body, String token) async {
    String method = 'updateUser';
    models.ChannelResponse result;

    final url =
        '${config.FlavorConfig.instance.values.chatHost}/api/Identity/UpdateUser';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.postRequest(url, body.toJson(), token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ChannelResponse>(
            status: false,
            value: models.ChannelResponse(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ChannelResponse>(
            status: false,
            value: models.ChannelResponse(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ChannelResponse.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ChannelResponse>(status: true, value: result);
  }
}

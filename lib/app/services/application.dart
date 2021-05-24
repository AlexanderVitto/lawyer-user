import 'dart:io';

import '../config/config.dart' as config;
import '../helpers/helpers.dart' as helpers;
import '../src/models/models.dart' as models;
import '../utils/utils.dart' as utils;

abstract class ApplicationAPI {
  Future registerDevice(models.ApplicationBody body, String token);
}

class Production implements ApplicationAPI {
  static const fileName = 'lib/app/services/application.dart';

  utils.LogUtils _log;
  helpers.Request _request;

  Production() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._request = config.locator<helpers.Request>();
  }

  @override
  Future registerDevice(models.ApplicationBody body, String token) async {
    String method = 'registerDevice';

    final url =
        "${config.FlavorConfig.instance.values.host}/api/Application/RegisterDevice";
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.postRequest(url, body.toJson(), token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      return null;
    }

    await utils.ResponseParser().from(response, _log, method);

    return null;
  }
}

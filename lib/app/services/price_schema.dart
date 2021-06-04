import 'dart:io';

import '../config/config.dart' as config;
import '../helpers/helpers.dart' as helpers;
import '../src/models/models.dart' as models;
import '../utils/utils.dart' as utils;

abstract class PriceSchemaAPI {
  Future<utils.ApiReturn<models.ResponsePrice>> getPrice(String token);
}

class Production implements PriceSchemaAPI {
  static const fileName = 'lib/app/services/price_schema.dart';

  utils.LogUtils _log;
  helpers.Request _request;

  Production() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._request = config.locator<helpers.Request>();
  }

  @override
  Future<utils.ApiReturn<models.ResponsePrice>> getPrice(String token) async {
    final String method = 'getPrice';
    models.ResponsePrice result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/PriceSchema/Get';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponsePrice>(
            status: false,
            value: models.ResponsePrice(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponsePrice>(
            status: false,
            value: models.ResponsePrice(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponsePrice.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponsePrice>(status: true, value: result);
  }
}

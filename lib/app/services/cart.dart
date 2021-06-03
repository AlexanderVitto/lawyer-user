import 'dart:io';

import '../config/config.dart' as config;
import '../helpers/helpers.dart' as helpers;
import '../src/models/models.dart' as models;
import '../utils/utils.dart' as utils;

abstract class CartAPI {
  Future<utils.ApiReturn<models.ResponseCart>> getCart(
      Map<String, dynamic> queryParameter, String token);
}

class Production implements CartAPI {
  static const fileName = 'lib/app/services/cart.dart';

  utils.LogUtils _log;
  helpers.Request _request;

  Production() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._request = config.locator<helpers.Request>();
  }

  @override
  Future<utils.ApiReturn<models.ResponseCart>> getCart(
      Map<String, dynamic> queryParameter, String token) async {
    final String method = 'getCart';
    models.ResponseCart result;

    final url = '${config.FlavorConfig.instance.values.host}/api/Cart/Get';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token, queryParameter: queryParameter);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseCart>(
            status: false,
            value: models.ResponseCart(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseCart>(
            status: false,
            value: models.ResponseCart(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseCart.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseCart>(status: true, value: result);
  }
}

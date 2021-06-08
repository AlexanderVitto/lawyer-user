import 'dart:convert';
import 'dart:io';

import '../config/config.dart' as config;
import '../utils/utils.dart' as utils;

class Request {
  static const fileName = 'lib/app/helpers/request.dart';

  int _timeout;
  bool _enableBearerToken;

  utils.LogUtils _log;

  Request() {
    this._timeout = config.FlavorConfig.instance.values.timeout;
    this._enableBearerToken =
        config.FlavorConfig.instance.values.enableBearerToken;

    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
  }

  Future<utils.ApiReturn<HttpClientResponse>> getRequest(
      String url, String token,
      {Map<String, dynamic> queryParameter}) async {
    String method = 'getRequest';
    try {
      HttpClient httpClient = new HttpClient();

      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      Uri uri = queryParameter != null
          ? Uri.parse(url).replace(queryParameters: queryParameter)
          : Uri.parse(url);

      HttpClientRequest request =
          await httpClient.getUrl(uri).timeout(Duration(seconds: _timeout));

      if (_enableBearerToken)
        request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $token');

      _log.info(
          method: method,
          message: 'Uri ${jsonEncode(uri.queryParameters)} Token $token');

      HttpClientResponse response = await request.close();

      if (response.statusCode != HttpStatus.ok) {
        print(response.statusCode);

        return utils.ApiReturn<HttpClientResponse>(
            status: false, value: response);
      }

      httpClient.close();

      return utils.ApiReturn<HttpClientResponse>(status: true, value: response);
    } catch (error) {
      print(error);

      return utils.ApiReturn<HttpClientResponse>(
          status: false, message: error.toString(), value: null);
    }
  }

  Future<utils.ApiReturn> postRequest(
      String url, Object body, String token) async {
    String method = 'postRequest';
    try {
      HttpClient httpClient = new HttpClient();

      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      Uri uri = Uri.parse(url);
      String _body = json.encode(body);

      HttpClientRequest request =
          await httpClient.postUrl(uri).timeout(Duration(seconds: _timeout));

      request.headers.set('content-type', 'application/json');

      if (_enableBearerToken)
        request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $token');

      request.add(utf8.encode(_body));

      _log.info(
          method: method,
          message:
              'Uri ${uri.path} Body ${jsonEncode(json.encode(_body))} Token $token');

      HttpClientResponse response = await request.close();

      if (response.statusCode != HttpStatus.ok) {
        print(response.statusCode);

        return utils.ApiReturn<HttpClientResponse>(
            status: false, value: response);
      }

      httpClient.close();

      return utils.ApiReturn<HttpClientResponse>(status: true, value: response);
    } catch (error) {
      print(error);

      return utils.ApiReturn<HttpClientResponse>(
          status: false, message: error.toString(), value: null);
    }
  }
}

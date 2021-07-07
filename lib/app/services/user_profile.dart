import 'dart:io';

import '../config/config.dart' as config;
import '../helpers/helpers.dart' as helpers;
import '../src/models/models.dart' as models;
import '../utils/utils.dart' as utils;

abstract class UserProfileAPI {
  Future<utils.ApiReturn<models.UserResponse>> getUserProfile(
      String id, String token);

  Future<utils.ApiReturn<models.UserResponse>> create2(
      models.User body, String token);

  Future<utils.ApiReturn<models.ResponseString>> update(
      models.User body, String token);

  Future<utils.ApiReturn<models.ResponseString>> checkEmail(
      String email, String token);

  Future<utils.ApiReturn<models.ResponseString>> checkMobileNumber(
      String mobileNumber, String token);

  Future<utils.ApiReturn<models.ResponseBool>> checkRegistered(
      Map<String, dynamic> queryParameter, String token);

  Future<utils.ApiReturn<models.ResponseBool>> checkAccount(
      Map<String, dynamic> queryParameter, String token);
}

class Production implements UserProfileAPI {
  static const fileName = 'lib/app/services/user_profile.dart';

  utils.LogUtils _log;
  helpers.Request _request;

  Production() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._request = config.locator<helpers.Request>();
  }

  @override
  Future<utils.ApiReturn<models.ResponseString>> checkEmail(
      String email, String token) async {
    final String method = 'checkEmail';
    models.ResponseString result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/UserProfile/checkemail?email=$email';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseString>(
            status: false,
            value: models.ResponseString(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseString>(
            status: false,
            value: models.ResponseString(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseString.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseString>(status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseString>> checkMobileNumber(
      String mobileNumber, String token) async {
    final String method = 'checkMobileNumber';
    models.ResponseString result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/UserProfile/checkmobileNumber?mobileNumber=$mobileNumber';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseString>(
            status: false,
            value: models.ResponseString(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseString>(
            status: false,
            value: models.ResponseString(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseString.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseString>(status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.UserResponse>> create2(
      models.User body, String token) async {
    final String method = 'create2';
    models.UserResponse result;

    final url =
        "${config.FlavorConfig.instance.values.host}/api/UserProfile/Create2";
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.postRequest(url, body.toJson(), token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.UserResponse>(
            status: false,
            value: models.UserResponse(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.UserResponse>(
            status: false,
            value: models.UserResponse(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.UserResponse.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.UserResponse>(status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.UserResponse>> getUserProfile(
      String id, String token) async {
    final String method = 'getUserProfile';
    models.UserResponse result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/UserProfile/Get?id=$id';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.UserResponse>(
            status: false,
            value: models.UserResponse(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.UserResponse>(
            status: false,
            value: models.UserResponse(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.UserResponse.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.UserResponse>(status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseString>> update(
      models.User body, String token) async {
    final String method = 'update';
    models.ResponseString result;

    final url =
        "${config.FlavorConfig.instance.values.host}/api/UserProfile/Update";
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.postRequest(url, body.toJson(), token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseString>(
            status: false,
            value: models.ResponseString(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseString>(
            status: false,
            value: models.ResponseString(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseString.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseString>(status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseBool>> checkAccount(
      Map<String, dynamic> queryParameter, String token) async {
    final String method = 'checkAccount';
    models.ResponseBool result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/UserProfile/checkAccount';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token, queryParameter: queryParameter);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseBool>(
            status: false,
            value: models.ResponseBool(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseBool>(
            status: false,
            value: models.ResponseBool(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseBool.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseBool>(status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseBool>> checkRegistered(
      Map<String, dynamic> queryParameter, String token) async {
    final String method = 'checkRegistered';
    models.ResponseBool result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/UserProfile/checkRegistered';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token, queryParameter: queryParameter);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseBool>(
            status: false,
            value: models.ResponseBool(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseBool>(
            status: false,
            value: models.ResponseBool(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseBool.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseBool>(status: true, value: result);
  }
}

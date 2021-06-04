import 'dart:io';

import '../config/config.dart' as config;
import '../helpers/helpers.dart' as helpers;
import '../src/models/models.dart' as models;
import '../utils/utils.dart' as utils;

abstract class PaymentAPI {
  Future<utils.ApiReturn<models.ResponseListInvoice>> getPendingPayment(
      Map<String, dynamic> queryParameter, String token);

  Future<utils.ApiReturn<models.ResponseListInvoice>> getSettledPayment(
      Map<String, dynamic> queryParameter, String token);

  Future<utils.ApiReturn<models.ResponseListInvoice>> getCanceledInvoice(
      Map<String, dynamic> queryParameter, String token);

  Future<utils.ApiReturn<models.ResponseListInvoice>> getExpiredInvoice(
      Map<String, dynamic> queryParameter, String token);

  Future<utils.ApiReturn<models.ResponseString>> confirmBankTransfer(
      models.ConfirmBankBody body, String token);

  Future<utils.ApiReturn<models.ResponseInvoice>> initPayment(
      models.InitPaymentBody body, String token);

  Future<utils.ApiReturn<models.ResponseInvoice>> initPaymentMidtrans(
      models.InitPaymentMidtransBody body, String token);
}

class Production implements PaymentAPI {
  static const fileName = 'lib/app/services/payment.dart';

  utils.LogUtils _log;
  helpers.Request _request;

  Production() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._request = config.locator<helpers.Request>();
  }

  @override
  Future<utils.ApiReturn<models.ResponseString>> confirmBankTransfer(
      models.ConfirmBankBody body, String token) async {
    final String method = 'confirmBankTransfer';
    models.ResponseString result;

    final url =
        "${config.FlavorConfig.instance.values.host}/api/Payment/ConfirmBankTransfer";
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
  Future<utils.ApiReturn<models.ResponseListInvoice>> getCanceledInvoice(
      Map<String, dynamic> queryParameter, String token) async {
    final String method = 'getCanceledInvoice';
    models.ResponseListInvoice result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/Payment/GetCanceledInvoice';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token, queryParameter: queryParameter);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseListInvoice>(
            status: false,
            value: models.ResponseListInvoice(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseListInvoice>(
            status: false,
            value: models.ResponseListInvoice(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseListInvoice.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseListInvoice>(
        status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseListInvoice>> getExpiredInvoice(
      Map<String, dynamic> queryParameter, String token) async {
    final String method = 'getExpiredInvoice';
    models.ResponseListInvoice result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/Payment/GetExpiredInvoice';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token, queryParameter: queryParameter);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseListInvoice>(
            status: false,
            value: models.ResponseListInvoice(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseListInvoice>(
            status: false,
            value: models.ResponseListInvoice(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseListInvoice.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseListInvoice>(
        status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseListInvoice>> getPendingPayment(
      Map<String, dynamic> queryParameter, String token) async {
    final String method = 'getPendingPayment';
    models.ResponseListInvoice result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/Payment/GetPendingPayment';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token, queryParameter: queryParameter);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseListInvoice>(
            status: false,
            value: models.ResponseListInvoice(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseListInvoice>(
            status: false,
            value: models.ResponseListInvoice(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseListInvoice.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseListInvoice>(
        status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseListInvoice>> getSettledPayment(
      Map<String, dynamic> queryParameter, String token) async {
    final String method = 'getSettledPayment';
    models.ResponseListInvoice result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/Payment/GetSettledPayment';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token, queryParameter: queryParameter);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseListInvoice>(
            status: false,
            value: models.ResponseListInvoice(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseListInvoice>(
            status: false,
            value: models.ResponseListInvoice(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseListInvoice.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseListInvoice>(
        status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseInvoice>> initPayment(
      models.InitPaymentBody body, String token) async {
    final String method = 'initPayment';
    models.ResponseInvoice result;

    final url =
        "${config.FlavorConfig.instance.values.host}/api/Payment/InitPayment";
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.postRequest(url, body.toJson(), token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseInvoice>(
            status: false,
            value: models.ResponseInvoice(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseInvoice>(
            status: false,
            value: models.ResponseInvoice(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseInvoice.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseInvoice>(status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseInvoice>> initPaymentMidtrans(
      models.InitPaymentMidtransBody body, String token) async {
    final String method = 'initPaymentMidtrans';
    models.ResponseInvoice result;

    final url =
        "${config.FlavorConfig.instance.values.host}/api/Payment/InitMidtransPayment";
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.postRequest(url, body.toJson(), token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseInvoice>(
            status: false,
            value: models.ResponseInvoice(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseInvoice>(
            status: false,
            value: models.ResponseInvoice(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseInvoice.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseInvoice>(status: true, value: result);
  }
}

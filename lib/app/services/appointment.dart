import 'dart:convert';
import 'dart:io';

import '../config/config.dart' as config;
import '../helpers/helpers.dart' as helpers;
import '../src/models/models.dart' as models;
import '../utils/utils.dart' as utils;

import '../../dummy_data/appointment.dart' as dummyData;

abstract class AppointmentAPI {
  Future<utils.ApiReturn<models.ResponseAppointment>> createAppointment(
      models.AppointmentBody body, String token);

  Future<utils.ApiReturn<models.ResponseAppointment>> bookAppontment(
      models.AppointmentBody body, String token);

  Future<utils.ApiReturn<models.ResponseAppointment>> updateAppointment(
      models.AppointmentBody body, String token);

  Future<utils.ApiReturn<models.ResponseAppointment>> updatStatusAppointment(
      models.UpdateAppointmentStatus body, String token);

  Future<utils.ApiReturn<models.ResponseAppointment>> rescheduleAppointment(
      models.AppointmentBody body, String token);

  Future<utils.ApiReturn<models.ResponseListAppointment>> getAppointment(
      Map<String, dynamic> queryParameter, String token);

  Future<utils.ApiReturn<models.ResponseAppointment>> completeAppointment(
      models.CompleteAppointment body, String token);

  Future<utils.ApiReturn<models.ResponseAppointment>> rateAppointment(
      models.RateAppointment body, String token);

  Future<utils.ApiReturn<models.ResponseAppointment>> resetAppointment(
      models.ResetAppointment body, String token);

  Future<utils.ApiReturn<models.ResponseListAppointment>> getFreeAppointment(
      Map<String, dynamic> queryParameter, String token);

  Future<utils.ApiReturn<models.ResponseListAppointment>> getByBookingCode(
      Map<String, dynamic> queryParameter, String token);
}

class Production implements AppointmentAPI {
  static const fileName = 'lib/app/services/appointment.dart';

  utils.LogUtils _log;
  helpers.Request _request;

  Production() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._request = config.locator<helpers.Request>();
  }

  @override
  Future<utils.ApiReturn<models.ResponseAppointment>> bookAppontment(
      models.AppointmentBody body, String token) async {
    final String method = 'bookAppontment';
    models.ResponseAppointment result;

    final url =
        "${config.FlavorConfig.instance.values.host}/api/Appointment/bookappointment";
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.postRequest(url, body.toJson(), token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseAppointment>(
            status: false,
            value: models.ResponseAppointment(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseAppointment>(
            status: false,
            value: models.ResponseAppointment(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseAppointment.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseAppointment>(
        status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseAppointment>> completeAppointment(
      models.CompleteAppointment body, String token) async {
    final String method = 'completeAppointment';
    models.ResponseAppointment result;

    final url =
        "${config.FlavorConfig.instance.values.host}/api/Appointment/CompleteAppointment";
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.postRequest(url, body.toJson(), token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseAppointment>(
            status: false,
            value: models.ResponseAppointment(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseAppointment>(
            status: false,
            value: models.ResponseAppointment(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseAppointment.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseAppointment>(
        status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseAppointment>> createAppointment(
      models.AppointmentBody body, String token) async {
    final String method = 'createAppointment';
    models.ResponseAppointment result;

    final url =
        "${config.FlavorConfig.instance.values.host}/api/Appointment/Create";
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.postRequest(url, body.toJson(), token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseAppointment>(
            status: false,
            value: models.ResponseAppointment(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseAppointment>(
            status: false,
            value: models.ResponseAppointment(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseAppointment.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseAppointment>(
        status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseListAppointment>> getAppointment(
      Map<String, dynamic> queryParameter, String token) async {
    final String method = 'getAppointment';
    models.ResponseListAppointment result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/Appointment/Get';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token, queryParameter: queryParameter);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseListAppointment>(
            status: false,
            value: models.ResponseListAppointment(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseListAppointment>(
            status: false,
            value: models.ResponseListAppointment(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseListAppointment.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseListAppointment>(
        status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseListAppointment>> getByBookingCode(
      Map<String, dynamic> queryParameter, String token) async {
    final String method = 'getByBookingCode';
    models.ResponseListAppointment result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/Appointment/GetByBookingCode';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token, queryParameter: queryParameter);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseListAppointment>(
            status: false,
            value: models.ResponseListAppointment(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseListAppointment>(
            status: false,
            value: models.ResponseListAppointment(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseListAppointment.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseListAppointment>(
        status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseListAppointment>> getFreeAppointment(
      Map<String, dynamic> queryParameter, String token) async {
    final String method = 'getFreeAppointment';
    models.ResponseListAppointment result;

    final url =
        '${config.FlavorConfig.instance.values.host}/api/Appointment/GetUserFreeAppointment';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token, queryParameter: queryParameter);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseListAppointment>(
            status: false,
            value: models.ResponseListAppointment(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseListAppointment>(
            status: false,
            value: models.ResponseListAppointment(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseListAppointment.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseListAppointment>(
        status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseAppointment>> rateAppointment(
      models.RateAppointment body, String token) async {
    final String method = 'rateAppointment';
    models.ResponseAppointment result;

    final url =
        "${config.FlavorConfig.instance.values.host}/api/Appointment/ResetAppointment";
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.postRequest(url, body.toJson(), token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseAppointment>(
            status: false,
            value: models.ResponseAppointment(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseAppointment>(
            status: false,
            value: models.ResponseAppointment(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseAppointment.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseAppointment>(
        status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseAppointment>> rescheduleAppointment(
      models.AppointmentBody body, String token) async {
    final String method = 'rescheduleAppointment';
    models.ResponseAppointment result;

    final url =
        "${config.FlavorConfig.instance.values.host}/api/Appointment/Reschedule";
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.postRequest(url, body.toJson(), token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseAppointment>(
            status: false,
            value: models.ResponseAppointment(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseAppointment>(
            status: false,
            value: models.ResponseAppointment(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseAppointment.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseAppointment>(
        status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseAppointment>> resetAppointment(
      models.ResetAppointment body, String token) async {
    final String method = 'resetAppointment';
    models.ResponseAppointment result;

    final url =
        "${config.FlavorConfig.instance.values.host}/api/Appointment/ResetAppointment";
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.postRequest(url, body.toJson(), token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseAppointment>(
            status: false,
            value: models.ResponseAppointment(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseAppointment>(
            status: false,
            value: models.ResponseAppointment(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseAppointment.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseAppointment>(
        status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseAppointment>> updatStatusAppointment(
      models.UpdateAppointmentStatus body, String token) async {
    final String method = 'updatStatusAppointment';
    models.ResponseAppointment result;

    final url =
        "${config.FlavorConfig.instance.values.host}/api/Appointment/UpdateStatus";
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.postRequest(url, body.toJson(), token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseAppointment>(
            status: false,
            value: models.ResponseAppointment(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseAppointment>(
            status: false,
            value: models.ResponseAppointment(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseAppointment.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseAppointment>(
        status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseAppointment>> updateAppointment(
      models.AppointmentBody body, String token) async {
    final String method = 'updateAppointment';
    models.ResponseAppointment result;

    final url =
        "${config.FlavorConfig.instance.values.host}/api/Appointment/Update";
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.postRequest(url, body.toJson(), token);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseAppointment>(
            status: false,
            value: models.ResponseAppointment(
                code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseAppointment>(
            status: false,
            value: models.ResponseAppointment(message: response.message));
      }
    }

    Map responseMap = await utils.ResponseParser().from(response, _log, method);
    result = models.ResponseAppointment.fromJson(responseMap);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseAppointment>(
        status: true, value: result);
  }
}

class Development implements AppointmentAPI {
  static const fileName = 'lib/app/services/appointment.dart';

  utils.LogUtils _log;
  helpers.Request _request;

  Development() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._request = config.locator<helpers.Request>();
  }

  @override
  Future<utils.ApiReturn<models.ResponseAppointment>> bookAppontment(
      models.AppointmentBody body, String token) {
    // TODO: implement bookAppontment
    throw UnimplementedError();
  }

  @override
  Future<utils.ApiReturn<models.ResponseAppointment>> completeAppointment(
      models.CompleteAppointment body, String token) {
    // TODO: implement completeAppointment
    throw UnimplementedError();
  }

  @override
  Future<utils.ApiReturn<models.ResponseAppointment>> createAppointment(
      models.AppointmentBody body, String token) {
    // TODO: implement createAppointment
    throw UnimplementedError();
  }

  @override
  Future<utils.ApiReturn<models.ResponseListAppointment>> getAppointment(
      Map<String, dynamic> queryParameter, String token) async {
    final String method = 'getAppointment';
    models.ResponseListAppointment result;

    result = models.ResponseListAppointment.fromJson(dummyData.getAppointment);

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseListAppointment>(
        status: true, value: result);
  }

  @override
  Future<utils.ApiReturn<models.ResponseListAppointment>> getByBookingCode(
      Map<String, dynamic> queryParameter, String token) {
    // TODO: implement getByBookingCode
    throw UnimplementedError();
  }

  @override
  Future<utils.ApiReturn<models.ResponseListAppointment>> getFreeAppointment(
      Map<String, dynamic> queryParameter, String token) {
    // TODO: implement getFreeAppointment
    throw UnimplementedError();
  }

  @override
  Future<utils.ApiReturn<models.ResponseAppointment>> rateAppointment(
      models.RateAppointment body, String token) {
    // TODO: implement rateAppointment
    throw UnimplementedError();
  }

  @override
  Future<utils.ApiReturn<models.ResponseAppointment>> rescheduleAppointment(
      models.AppointmentBody body, String token) {
    // TODO: implement rescheduleAppointment
    throw UnimplementedError();
  }

  @override
  Future<utils.ApiReturn<models.ResponseAppointment>> resetAppointment(
      models.ResetAppointment body, String token) {
    // TODO: implement resetAppointment
    throw UnimplementedError();
  }

  @override
  Future<utils.ApiReturn<models.ResponseAppointment>> updatStatusAppointment(
      models.UpdateAppointmentStatus body, String token) {
    // TODO: implement updatStatusAppointment
    throw UnimplementedError();
  }

  @override
  Future<utils.ApiReturn<models.ResponseAppointment>> updateAppointment(
      models.AppointmentBody body, String token) {
    // TODO: implement updateAppointment
    throw UnimplementedError();
  }
}

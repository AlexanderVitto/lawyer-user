import 'dart:convert';
import 'dart:io';

import '../config/config.dart' as config;
import '../helpers/helpers.dart' as helpers;
import '../src/models/models.dart' as models;
import '../utils/utils.dart' as utils;

abstract class QuestionnaireAPI {
  Future<utils.ApiReturn<models.ResponseListQuestionnaire>> getResultByUser(
      Map<String, dynamic> queryParameter, String token);

  Future<utils.ApiReturn<models.ResponseString>> submitResult(
      models.AnswerBody body, String token);

  Future<utils.ApiReturn<models.ResponseString>> updateResult(
      models.AnswerBody body, String token);
}

class Production implements QuestionnaireAPI {
  static const fileName = 'lib/app/services/questionnaire.dart';

  utils.LogUtils _log;
  helpers.Request _request;

  Production() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._request = config.locator<helpers.Request>();
  }

  @override
  Future<utils.ApiReturn<models.ResponseListQuestionnaire>> getResultByUser(
      Map<String, dynamic> queryParameter, String token) async {
    final String method = 'getResultByUser';
    models.ResponseListQuestionnaire result;
    List<models.Questionnaire> temp = [];

    final url =
        '${config.FlavorConfig.instance.values.host}/api/Questionnaire/GetResultByUser';
    _log.info(method: method, message: 'url $url');

    utils.ApiReturn<HttpClientResponse> response =
        await _request.getRequest(url, token, queryParameter: queryParameter);

    if (!response.status) {
      _log.error(method: method, message: 'response ${response.status}');

      if (response.value != null) {
        return utils.ApiReturn<models.ResponseListQuestionnaire>(
            status: false,
            value: models.ResponseListQuestionnaire(
                status: false, code: response.value.statusCode.toString()));
      } else {
        return utils.ApiReturn<models.ResponseListQuestionnaire>(
            status: false,
            value: models.ResponseListQuestionnaire(
                status: false, message: response.message));
      }
    }

    String reply = await response.value.transform(utf8.decoder).join();
    print(reply);

    var jsonResult = jsonDecode(reply);

    jsonResult.forEach((element) {
      Map responseMap = element;

      temp.add(models.Questionnaire.fromJson(responseMap));
    });

    _log.info(method: method, message: 'result status: ${result.status}');

    return utils.ApiReturn<models.ResponseListQuestionnaire>(
        status: true,
        value: models.ResponseListQuestionnaire(status: true, result: temp));
  }

  @override
  Future<utils.ApiReturn<models.ResponseString>> submitResult(
      models.AnswerBody body, String token) async {
    final String method = 'submitResult';
    models.ResponseString result;

    final url =
        "${config.FlavorConfig.instance.values.host}/api/Questionnaire/SubmitResult";
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
  Future<utils.ApiReturn<models.ResponseString>> updateResult(
      models.AnswerBody body, String token) async {
    final String method = 'updateResult';
    models.ResponseString result;

    final url =
        "${config.FlavorConfig.instance.values.host}/api/Questionnaire/UpdateAnswers";
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
}

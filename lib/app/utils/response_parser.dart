import 'dart:convert';
import 'dart:io';

import 'api_response.dart';

import 'log_utils.dart';

class ResponseParser {
  Future<Map> from(ApiReturn<HttpClientResponse> response, LogUtils log,
      String method) async {
    String reply = await response.value.transform(utf8.decoder).join();
    log.debug(method: method, message: 'reply $reply');

    return jsonDecode(reply);
  }
}

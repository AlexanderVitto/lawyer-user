import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/config.dart' as config;
import '../../helpers/helpers.dart' as helpers;
import '../../utils/utils.dart' as utils;
import '../../services/cart.dart' as cart;

import '../models/models.dart' as models;

import 'providers.dart';

class Cart with ChangeNotifier {
  static const fileName = 'lib/app/src/providers/cart.dart';

  utils.Connection _connection;
  utils.LogUtils _log;

  cart.CartAPI _cartAPI;

  Auth _auth;
  Auth get auth => _auth;

  List<models.Cart> _carts;
  List<models.Cart> get carts => _carts;

  Cart() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._cartAPI = config.locator<cart.CartAPI>();

    this._carts = [];
  }

  update(Auth auth) {
    this._auth = auth;
    this._connection = auth.connection;

    notifyListeners();
  }

  Future fetchCart() async {
    final String method = 'fetchCart';

    await _connection.check();

    Map<String, dynamic> queryParameter = {"userId": _auth.userId};

    utils.ApiReturn<models.ResponseCart> apiRequest =
        await _cartAPI.getCart(queryParameter, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }

      _carts = [];
    } else {
      if (apiRequest.value.status) {
        _carts = apiRequest.value.result;
        // _carts = apiRequest.value.result
        //     .where((value) =>
        //         DateTime.now().isBefore(DateTime.tryParse(value.expiredIn)))
        //     .toList();

        _carts.sort((a, b) => a.appointmentId.compareTo(b.appointmentId));
      } else {
        _carts = [];
      }
    }

    notifyListeners();
  }
}

import 'package:flutter/material.dart';

import '../../config/config.dart' as config;
import '../../helpers/helpers.dart' as helpers;
import '../../utils/utils.dart' as utils;
import '../../services/payment.dart' as payment;

import '../models/models.dart' as models;

import 'providers.dart';

class Payment with ChangeNotifier {
  static const fileName = 'lib/app/src/providers/payment.dart';

  utils.Connection _connection;
  utils.LogUtils _log;

  payment.PaymentAPI _paymentAPI;

  helpers.AuthResultStatus _paymentStatus;
  helpers.AuthResultStatus get paymentStatus => _paymentStatus;

  Auth _auth;
  Auth get auth => _auth;

  models.Invoice _initPaymentResult;
  models.Invoice get initPaymentResult => _initPaymentResult;

  List<models.Invoice> _open;
  List<models.Invoice> get open => _open;
  List<models.Invoice> _pending;
  List<models.Invoice> get pending => _pending;
  List<models.Invoice> _settled;
  List<models.Invoice> get settled => _settled;
  List<models.Invoice> _canceled;
  List<models.Invoice> get canceled => _canceled;
  List<models.Invoice> _expired;
  List<models.Invoice> get expired => _expired;

  Payment() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._paymentAPI = config.locator<payment.PaymentAPI>();

    this._paymentStatus = helpers.AuthResultStatus.undefined;
    this._open = [];
    this._pending = [];
    this._settled = [];
    this._canceled = [];
    this._expired = [];
  }

  update(Auth auth) {
    this._auth = auth;
    this._connection = auth.connection;

    notifyListeners();
  }

  Future initPayment(models.InitPaymentBody body) async {
    final String method = 'initPayment';

    await _connection.check();

    utils.ApiReturn<models.ResponseInvoice> apiRequest =
        await _paymentAPI.initPayment(body, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }

      _paymentStatus = helpers.AuthResultStatus.apiConnectionError;
      _initPaymentResult = null;
    } else {
      if (apiRequest.value.status) {
        _paymentStatus = helpers.AuthResultStatus.initPaymentSuccess;
        _initPaymentResult = apiRequest.value.result;

        // await tryFetch();
      } else {
        _paymentStatus = helpers.AuthResultStatus.initPaymentFailed;
        _initPaymentResult = null;
      }
    }

    notifyListeners();
  }

  Future initMidtransPayment(models.InitPaymentMidtransBody body) async {
    final String method = 'initMidtransPayment';

    await _connection.check();

    utils.ApiReturn<models.ResponseInvoice> apiRequest =
        await _paymentAPI.initPaymentMidtrans(body, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }

      _paymentStatus = helpers.AuthResultStatus.apiConnectionError;
      _initPaymentResult = null;
    } else {
      if (apiRequest.value.status) {
        _paymentStatus = helpers.AuthResultStatus.initPaymentSuccess;
        _initPaymentResult = apiRequest.value.result;

        // await tryFetch();
      } else {
        _paymentStatus = helpers.AuthResultStatus.initPaymentFailed;
        _initPaymentResult = null;
      }
    }

    notifyListeners();
  }

  Future tryFetch() async {
    var futures = <Future>[
      fetchOpenPayment(),
      fetchPendingPayment(),
      fetchSettledPayment(),
      fetchCanceledPayment(),
      fetchExpiredPayment()
    ];

    await Future.wait(futures);
  }

  Future fetchOpenPayment() async {
    final String method = 'fetchOpenPayment';

    await _connection.check();

    Map<String, dynamic> queryParameter = {'userId': _auth.userId};

    utils.ApiReturn<models.ResponseListInvoice> apiRequest =
        await _paymentAPI.getOpenPayment(queryParameter, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }

      _open = [];
    } else {
      if (apiRequest.value.status) {
        _open = apiRequest.value.result;
        _open.sort((a, b) => a.id.compareTo(b.id));
      } else {
        _open = [];
      }
    }

    notifyListeners();
  }

  Future fetchPendingPayment() async {
    final String method = 'fetchPendingPayment';

    await _connection.check();

    Map<String, dynamic> queryParameter = {'userId': _auth.userId};

    utils.ApiReturn<models.ResponseListInvoice> apiRequest =
        await _paymentAPI.getPendingPayment(queryParameter, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }

      _pending = [];
    } else {
      if (apiRequest.value.status) {
        _pending = apiRequest.value.result;
        _pending.sort((a, b) => a.id.compareTo(b.id));
      } else {
        _pending = [];
      }
    }

    notifyListeners();
  }

  Future fetchSettledPayment() async {
    final String method = 'fetchSettledPayment';

    await _connection.check();

    Map<String, dynamic> queryParameter = {'userId': _auth.userId};

    utils.ApiReturn<models.ResponseListInvoice> apiRequest =
        await _paymentAPI.getSettledPayment(queryParameter, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }

      _settled = [];
    } else {
      if (apiRequest.value.status) {
        _settled = apiRequest.value.result;
        _settled.sort((a, b) => a.id.compareTo(b.id));
      } else {
        _settled = [];
      }
    }

    notifyListeners();
  }

  Future fetchCanceledPayment() async {
    final String method = 'fetchCanceledPayment';

    await _connection.check();

    Map<String, dynamic> queryParameter = {'userId': _auth.userId};

    utils.ApiReturn<models.ResponseListInvoice> apiRequest =
        await _paymentAPI.getCanceledInvoice(queryParameter, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }

      _canceled = [];
    } else {
      if (apiRequest.value.status) {
        _canceled = apiRequest.value.result;
        _canceled.sort((a, b) => a.id.compareTo(b.id));
      } else {
        _canceled = [];
      }
    }

    notifyListeners();
  }

  Future fetchExpiredPayment() async {
    final String method = 'fetchExpiredPayment';

    await _connection.check();

    Map<String, dynamic> queryParameter = {'userId': _auth.userId};

    utils.ApiReturn<models.ResponseListInvoice> apiRequest =
        await _paymentAPI.getExpiredInvoice(queryParameter, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Refresh token
        _auth.setToken();
      }

      _expired = [];
    } else {
      if (apiRequest.value.status) {
        _expired = apiRequest.value.result;
        _expired.sort((a, b) => a.id.compareTo(b.id));
      } else {
        _expired = [];
      }
    }

    notifyListeners();
  }
}

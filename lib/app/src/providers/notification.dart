import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/config.dart' as config;
import '../../helpers/helpers.dart' as helpers;
import '../../utils/utils.dart' as utils;
import '../../services/notification.dart' as notification;

import '../models/models.dart' as models;

import 'providers.dart';

class Notification with ChangeNotifier {
  static const fileName = 'lib/app/src/providers/notification.dart';

  final List<models.ItemFilter> itemFilters = [
    models.ItemFilter(id: 1, name: "Promo", isFilterActive: false),
    models.ItemFilter(id: 2, name: "Info", isFilterActive: false),
    models.ItemFilter(
        id: 3, name: "Transaction", isFilterActive: false, ignore: true)
  ];

  utils.Connection _connection;
  utils.LogUtils _log;

  notification.NotificationAPI _notificationAPI;

  Auth _auth;
  Auth get auth => _auth;

  List<models.Notification> _notificationInfos;
  List<models.Notification> get notificationInfos => _notificationInfos;
  List<models.Notification> _notificationPromos;
  List<models.Notification> get notificationPromos => _notificationPromos;
  List<models.Notification> _notificationTransactions;
  List<models.Notification> get notificationTransaction =>
      _notificationTransactions;

  Notification() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._notificationAPI = config.locator<notification.NotificationAPI>();

    this._notificationInfos = [];
    this._notificationPromos = [];
    this._notificationTransactions = [];
  }

  update(Auth auth) {
    this._auth = auth;
    this._connection = auth.connection;

    notifyListeners();
  }

  Future fetchNotification() async {
    final String method = 'fetchNotification';

    await _connection.check();

    Map<String, dynamic> queryParameter = {'userId': _auth.userId};

    utils.ApiReturn<models.ResponseAllNotification> apiRequest =
        await _notificationAPI.getNotification(queryParameter, _auth.token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Force logout

      }

      _notificationInfos = [];
      _notificationPromos = [];
      _notificationTransactions = [];
    } else {
      _notificationInfos = [];
      _notificationPromos = [];
      _notificationTransactions = [];
      if (apiRequest.value.status) {
        apiRequest.value.result.notificationPromos?.forEach((value) {
          models.Notification data = value;
          data.filterId = itemFilters[0].id;
          data.filterName = itemFilters[0].name;

          _notificationPromos.add(data);
        });

        apiRequest.value.result.notificationInfos?.forEach((value) {
          models.Notification data = value;
          data.filterId = itemFilters[1].id;
          data.filterName = itemFilters[1].name;

          _notificationInfos.add(data);
        });

        apiRequest.value.result.notificationTransactions?.forEach((value) {
          models.Notification data = value;
          data.filterId = itemFilters[2].id;
          data.filterName = itemFilters[2].name;

          _notificationTransactions.add(data);
        });

        _notificationPromos.sort((a, b) => a.addDate.compareTo(b.addDate));
        _notificationInfos.sort((a, b) => a.addDate.compareTo(b.addDate));
        _notificationTransactions
            .sort((a, b) => a.addDate.compareTo(b.addDate));
      }
    }

    notifyListeners();
  }

  Future readNotification(models.NotificationBody body) async {
    final String method = 'readNotification';

    await _connection.check();

    await _notificationAPI.readNotification(body, _auth.token);

    // notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../../enum.dart';

import '../../../../../config/config.dart' as config;
import '../../../../../helpers/helpers.dart' as helpers;
import '../../../../../utils/utils.dart' as utils;

import '../../../../models/models.dart' as models;
import '../../../../providers/providers.dart' as providers;

class TransactionProvider with ChangeNotifier {
  static const fileName =
      'lib/app/src/screens/main/transaction/provider/transaction_provider.dart';

  final List<models.TransactionType> listTransactionType = [
    models.TransactionType(
        name: 'On Going',
        image: 'assets/icons/on_process.png',
        filterBy: TransactionScreenTab.onGoing),
    models.TransactionType(
        name: 'History',
        image: 'assets/icons/completed.png',
        filterBy: TransactionScreenTab.history)
  ];

  utils.LogUtils _log;

  providers.Payment _paymentProvider;
  providers.Payment get paymentProvider => _paymentProvider;
  providers.StaticData _staticDataProvider;

  List<models.Invoice> _listOnGoing;
  List<models.Invoice> get listOnGoing => _listOnGoing;
  List<models.Invoice> _listHistory;
  List<models.Invoice> get listHistory => _listHistory;

  bool _isBusy;
  bool get isBusy => _isBusy;
  String _namaRek;
  String get namaRek => _namaRek;
  String _noRek;
  String get noRek => _noRek;

  TransactionProvider(
      providers.Payment payment, providers.StaticData staticData) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);

    this._paymentProvider = payment;
    this._staticDataProvider = staticData;
  }

  update(providers.Payment payment, providers.StaticData staticData) {
    this._paymentProvider = payment;
    this._staticDataProvider = staticData;

    notifyListeners();
  }

  Future initResource(TransactionScreenTab tab) async {
    this._listOnGoing = [];
    this._listHistory = [];
    this._namaRek = 'PT Psykay Persona Perkasa';
    this._noRek = '2180977778';

    _isBusy = false;

    await initialLoad();
    onSelectTab(tab);
  }

  setToBusy() {
    _isBusy = true;

    notifyListeners();
  }

  setToIdle() {
    _isBusy = false;

    notifyListeners();
  }

  onSelectTab(TransactionScreenTab tab) {
    switch (tab) {
      case TransactionScreenTab.onGoing:
        listTransactionType[0].isSelected = true;
        listTransactionType[1].isSelected = false;
        break;
      case TransactionScreenTab.history:
        listTransactionType[0].isSelected = false;
        listTransactionType[1].isSelected = true;
        break;
    }

    notifyListeners();
  }

  models.MasterBank searchBank(String code) {
    if (code == null) return null;
    return _staticDataProvider.bankData
        .firstWhere((element) => element.bankCode == code);
  }

  Future initialLoad([RefreshController controller]) async {
    setToBusy();

    final futures = <Future>[
      _paymentProvider.fetchOpenPayment(),
      _paymentProvider.fetchPendingPayment(),
      _paymentProvider.fetchSettledPayment(),
      _paymentProvider.fetchCanceledPayment(),
      _paymentProvider.fetchExpiredPayment(),
    ];

    if (_staticDataProvider.bankData.isEmpty)
      futures.add(_staticDataProvider.fetchBank());

    await Future.wait(futures);

    _generateTransaction();

    if (controller != null) controller.refreshCompleted();

    setToIdle();
  }

  _generateTransaction() {
    _listOnGoing = [];
    _listHistory = [];

    _listOnGoing.addAll(_paymentProvider.open);
    _listOnGoing.addAll(_paymentProvider.pending);

    _paymentProvider.settled.forEach((element) {
      DateTime today = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      DateTime date = DateTime.parse(element.transactionTime.split('T')[0]);

      if (date.isAtSameMomentAs(today)) {
        _listOnGoing.add(element);
      } else {
        _listHistory.add(element);
      }
    });

    _paymentProvider.canceled.forEach((element) {
      DateTime today = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      DateTime date = DateTime.parse(element.transactionTime.split('T')[0]);

      if (date.isAtSameMomentAs(today)) {
        _listOnGoing.add(element);
      } else {
        _listHistory.add(element);
      }
    });

    _paymentProvider.expired.forEach((element) {
      DateTime today = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      DateTime date = DateTime.parse(element.transactionTime.split('T')[0]);

      if (date.isAtSameMomentAs(today)) {
        _listOnGoing.add(element);
      } else {
        _listHistory.add(element);
      }
    });
  }
}

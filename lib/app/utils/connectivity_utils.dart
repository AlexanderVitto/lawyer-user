import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class ConnectivityUtils with ChangeNotifier {
  ConnectivityUtils() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      resultHandler(result);
    });
  }

  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  String _pageText =
      'Currently connected to no network. Pleas connect to a wifi network';

  ConnectivityResult get connectivityResult => _connectivityResult;
  String get pageText => _pageText;

  void resultHandler(ConnectivityResult result) {
    _connectivityResult = result;

    if (result == ConnectivityResult.none) {
      _pageText =
          'Currently connected to no network. Please connect to a wifi network!';
    } else if (result == ConnectivityResult.mobile) {
      _pageText = 'Currently connected to a celular network.';
    } else if (result == ConnectivityResult.wifi) {
      _pageText = 'Connected to a wifi network';
    }

    notifyListeners();
  }

  Future<bool> initialLoad() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());

    resultHandler(connectivityResult);

    return true;
  }
}

class Connection with ChangeNotifier {
  bool _isConnected = false;
  bool get isConnected => _isConnected;

  bool _isBusy = false;
  bool _isInit = false;

  setIsInit() {
    _isInit = true;

    notifyListeners();
  }

  Future<bool> init() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        _isConnected = true;
      }
    } on SocketException catch (_) {
      print('not connected');
      _isConnected = false;
    }

    _isBusy = false;
    notifyListeners();
    return true;
  }

  Future check() async {
    if (!_isBusy) {
      if (!_isInit) {
        _isBusy = true;
        notifyListeners();
      }

      try {
        final result = await InternetAddress.lookup('example.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('connected');
          _isConnected = true;
        }
      } on SocketException catch (_) {
        print('not connected');
        _isConnected = false;
      }

      _isInit = false;
      _isBusy = false;
      notifyListeners();
    }
  }
}

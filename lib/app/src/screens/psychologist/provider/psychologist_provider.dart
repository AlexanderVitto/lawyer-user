import 'package:flutter/material.dart';

import '../../../../config/config.dart' as config;
import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;

import '../../../models/models.dart' as models;
import '../../../providers/providers.dart' as providers;

class PsychologistProvider with ChangeNotifier {
  static const fileName =
      'lib/app/src/screens/psychologist/provider/psychologist_provider.dart';

  ScrollController _scrollController;
  ScrollController get scrollController => _scrollController;

  utils.LogUtils _log;

  providers.Partner _partnerProvider;

  models.Partner _partnerDetail;
  models.Partner get partnerDetail => _partnerDetail;

  List<models.Partner> _listPartner;
  List<models.Partner> get listPartner => _partnerProvider.listPartner;

  bool _isInit;
  bool get isInit => _isInit;
  bool _isBusy;
  bool get isBusy => _isBusy;
  bool _isTop;
  bool get isTop => _isTop;
  bool _isEnd;
  bool get isEnd => _isEnd;

  double _pixelValue;
  double get pixelValue => _pixelValue;
  double _heightLoading = 60;
  double get heightLoading => _heightLoading;

  PsychologistProvider(providers.Partner partner) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);

    this._partnerProvider = partner;

    this._listPartner = [];
    this._isInit = true;
    this._isBusy = false;
  }

  update(providers.Partner partner) {
    this._partnerProvider = partner;

    notifyListeners();
  }

  void _scrollListener() {
    print(_scrollController.position.extentAfter);
    if (_scrollController.position.extentAfter == 0) {
      // load more
      print('test');
    }
  }

  setToBusy() {
    _isBusy = true;

    notifyListeners();
  }

  setToIdle() {
    _isBusy = false;

    notifyListeners();
  }

  Future initialLoad() async {
    Map<String, dynamic> queryParameter =
        _partnerProvider.currentQueryParamListPartner;

    await _partnerProvider.fetchListPartner(queryParameter);

    setToIdle();
  }

  Future onRefresh() async {
    setToBusy();

    Map<String, dynamic> queryParameter =
        _partnerProvider.currentQueryParamListPartner;

    await _partnerProvider.fetchListPartner(queryParameter);

    setToIdle();
  }

  initResource() {
    this._scrollController = ScrollController()..addListener(_scrollListener);
    this._isInit = true;
    this._isTop = true;
    this._isEnd = false;
    this._pixelValue = 0;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initialLoad();
    });
  }

  close() {
    this._scrollController?.removeListener(_scrollListener);
  }
}

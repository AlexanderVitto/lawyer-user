import 'package:flutter/material.dart';

import '../../../../../../enum.dart';

import '../../../../../config/config.dart' as config;
import '../../../../../helpers/helpers.dart' as helpers;
import '../../../../../utils/utils.dart' as utils;

import '../../../../models/models.dart' as models;
import '../../../../providers/providers.dart' as providers;

class HomeProvider with ChangeNotifier {
  static const fileName =
      'lib/app/src/screens/main/home/provider/home_provider.dart';

  ScrollController _scrollController;
  ScrollController get scrollController => _scrollController;

  utils.LogUtils _log;

  providers.Auth _authProvider;

  List<models.Article> _articles = [
    models.Article(
      id: 1,
      title: 'COVID-19 vaccine',
      description: 'Some Description',
      dateTime: DateTime.now(),
      imageUrl: 'assets/images/covid-article.png',
    ),
    models.Article(
      id: 2,
      title: 'Dog with mask',
      description: 'Some Description',
      dateTime: DateTime.now(),
      imageUrl: 'assets/images/anjing-pakai-masker.png',
    ),
  ];

  List<models.Article> get articles => _articles;

  bool _isFlexibled = true;
  bool get isFlexibled => _isFlexibled;
  double _appBarPosition;
  double get appBarPosition => _appBarPosition;

  HomeProvider(providers.Auth auth, double appBarPosition) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    _appBarPosition = appBarPosition;
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    this._authProvider = auth;
  }

  update(providers.Auth auth) {
    this._authProvider = auth;

    notifyListeners();
  }

  setAppBarPosition(double data) {
    _appBarPosition = data;

    notifyListeners();
  }

  setFlexible(bool data) {
    _isFlexibled = data;

    notifyListeners();
  }

  _scrollListener() {
    if (_scrollController.offset < _appBarPosition + 60) {
      setFlexible(true);
    } else {
      setFlexible(false);
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

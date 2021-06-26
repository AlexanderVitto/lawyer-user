import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../enum.dart';

import '../../../../config/config.dart' as config;
import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;

import '../../../models/models.dart' as models;
import '../../../providers/providers.dart' as providers;

import '../../book_appointment/book_appointment_screen.dart';
import '../../psychologist_profile/psychologist_profile_screen.dart';

import '../sorting/sorting_screen.dart';

class PsychologistProvider with ChangeNotifier {
  static const fileName =
      'lib/app/src/screens/psychologist/provider/psychologist_provider.dart';

  final List<models.Sort> sortingData = [
    models.Sort(
      id: 1,
      name: 'Price low to high',
      sortValue: SortBy.priceLoHi,
    ),
    models.Sort(
      id: 2,
      name: 'Price high to low',
      sortValue: SortBy.priceHiLo,
    ),
    models.Sort(
      id: 3,
      name: 'Working experiences low to high',
      sortValue: SortBy.experienceLoHi,
    ),
    models.Sort(
      id: 4,
      name: 'Working experiences high to low',
      sortValue: SortBy.experiencexHiLo,
    ),
    models.Sort(
      id: 5,
      name: 'Younger',
      sortValue: SortBy.age,
    ),
  ];

  ScrollController _scrollController;
  ScrollController get scrollController => _scrollController;
  TextEditingController _searchController;
  TextEditingController get searchController => _searchController;

  SortBy _sortBy;
  SortBy get sortBy => _sortBy;

  utils.LogUtils _log;

  providers.Partner _partnerProvider;

  models.Partner _partnerDetail;
  models.Partner get partnerDetail => _partnerDetail;
  models.StaticData _expertise;
  models.StaticData get expertise => _expertise;

  List<models.Partner> _listPartner;
  List<models.Partner> get listPartner => _listPartner;

  bool _isInit;
  bool get isInit => _isInit;
  bool _isBusy;
  bool get isBusy => _isBusy;
  bool _isTop;
  bool get isTop => _isTop;
  bool _isEnd;
  bool get isEnd => _isEnd;
  bool _isLoadMore;
  bool get isLoadMore => _isLoadMore;
  bool _isLastIndex;

  int _page;
  int get page => _page;

  double _pixelValue;
  double get pixelValue => _pixelValue;
  double _heightLoading = 60;
  double get heightLoading => _heightLoading;

  PsychologistProvider(providers.Partner partner) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);

    this._partnerProvider = partner;
  }

  update(providers.Partner partner) {
    this._partnerProvider = partner;

    notifyListeners();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter == 0) {
      // load more

    }
  }

  setSortBy(SortBy data) {
    _sortBy = data;

    _sortData(data);

    notifyListeners();
  }

  setToBusy() {
    _isBusy = true;

    notifyListeners();
  }

  setToIdle() {
    _isBusy = false;

    notifyListeners();
  }

  // onNotification(ScrollNotification scrollNotification) {
  //   if (scrollNotification is ScrollStartNotification) {
  //     if (scrollNotification.metrics.pixels < 250) {
  //       _isTop = true;
  //     } else {
  //       _isTop = false;
  //     }
  //   } else if (scrollNotification is ScrollUpdateNotification) {
  //     if (scrollNotification.scrollDelta > 0 && _pixelValue > 0 && !_isEnd) {
  //       _pixelValue -= scrollNotification.scrollDelta;
  //     }
  //   } else if (scrollNotification is ScrollEndNotification) {
  //     if (_pixelValue > (_heightLoading * 2 / 3)) {
  //       _isEnd = true;
  //     } else {
  //       _isEnd = false;
  //       _pixelValue = 0;
  //     }
  //   } else if (scrollNotification is OverscrollNotification) {
  //     if (scrollNotification.overscroll < 0 &&
  //         _pixelValue <= _heightLoading &&
  //         _isTop) {
  //       _pixelValue -= scrollNotification.overscroll;
  //     } else {
  //       if (!_isLoadMore) loadMore();
  //     }
  //   }

  //   notifyListeners();

  //   return false;
  // }

  onSearch(String data) {
    _listPartner = _partnerProvider.listPartner
        .where((element) =>
            element.firstName.toLowerCase().contains(data.toLowerCase()) ||
            element.lastName.toLowerCase().contains(data.toLowerCase()))
        .toList();

    _sortData(_sortBy);

    notifyListeners();
  }

  initResource(models.StaticData expertise) {
    this._scrollController = ScrollController()..addListener(_scrollListener);
    this._searchController = TextEditingController();

    this._expertise = expertise;
    this._sortBy = SortBy.priceLoHi;
    this._isInit = true;
    this._isBusy = false;
    this._isTop = true;
    this._isEnd = false;
    this._isLoadMore = false;

    this._page = 1;
    this._pixelValue = 0;
    this._isLastIndex = false;

    this._listPartner = [];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialLoad();
    });
  }

  close() {
    this._scrollController?.removeListener(_scrollListener);
    this._searchController.dispose();
  }

  navigateToSort(BuildContext context) {
    Navigator.of(context).pushNamed(SortingScreen.routeName);
  }

  navigateToBookAppointment(BuildContext context, models.Partner partner) {
    Navigator.of(context).pushNamed(BookAppointmentScreen.routeName,
        arguments: helpers.ScreenArguments(
            partnerData: partner, staticData: _expertise));
  }

  navigateToProfile(BuildContext context, models.Partner partner) {
    Navigator.of(context).pushNamed(PsychologistProfileScreen.routeName,
        arguments: helpers.ScreenArguments(
            partnerData: partner, staticData: _expertise));
  }

  Future initialLoad([RefreshController controller]) async {
    _log.info(method: 'initialLoad', message: 'Masuk');
    Map<String, dynamic> queryParameter =
        _partnerProvider.currentQueryParamListPartner;

    await _partnerProvider.fetchListPartner(queryParameter);
    _listPartner = _partnerProvider.listPartner
        .where((element) =>
            element.firstName
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()) ||
            element.lastName
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
        .toList();

    _sortData(_sortBy);

    if (controller != null) controller.refreshCompleted();
    setToIdle();
  }

  Future loadMore(RefreshController controller) async {
    if (!_isLastIndex) {
      _page++;

      setToBusy();

      Map<String, dynamic> queryParameter = {
        'serviceId': _partnerProvider.currentQueryParamListPartner['serviceId'],
        'currentPage': _page.toString(),
        'pageSize': _partnerProvider.currentQueryParamListPartner['pageSize']
      };

      _isLastIndex =
          await _partnerProvider.fetchMoreListPartner(queryParameter);

      _listPartner = _partnerProvider.listPartner
          .where((element) =>
              element.firstName
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()) ||
              element.lastName
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()))
          .toList();

      _sortData(_sortBy);

      controller.loadComplete();

      setToIdle();
    }
  }

  Future onRefresh() async {
    setToBusy();

    Map<String, dynamic> queryParameter =
        _partnerProvider.currentQueryParamListPartner;

    await _partnerProvider.fetchListPartner(queryParameter);

    _sortData(_sortBy);
    setToIdle();
  }

  _sortData(SortBy data) {
    switch (data) {
      case SortBy.priceHiLo:
        _listPartner.sort((a, b) => a.partnerPrices[0].priceSchema.basePrice
            .compareTo(b.partnerPrices[0].priceSchema.basePrice));

        _listPartner = _listPartner.reversed.toList();
        break;
      case SortBy.priceLoHi:
        _listPartner.sort((a, b) => a.partnerPrices[0].priceSchema.basePrice
            .compareTo(b.partnerPrices[0].priceSchema.basePrice));

        break;
      case SortBy.highRating:
        break;
      case SortBy.experienceLoHi:
        _listPartner.sort((a, b) => a.experiences.compareTo(b.experiences));

        _listPartner = _listPartner.reversed.toList();
        break;
      case SortBy.experiencexHiLo:
        _listPartner.sort((a, b) => a.experiences.compareTo(b.experiences));
        break;

      case SortBy.age:
        _listPartner.sort((a, b) => a.dateOfBirth.compareTo(b.dateOfBirth));

        _listPartner = _listPartner.reversed.toList();
        break;
    }
  }
}

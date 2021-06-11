import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../config/config.dart' as config;
import '../../../../../helpers/helpers.dart' as helpers;
import '../../../../../utils/utils.dart' as utils;

import '../../../../models/models.dart' as models;
import '../../../../providers/providers.dart' as providers;

import '../../../preference/preference_screen.dart';

class HomeProvider with ChangeNotifier {
  static const fileName =
      'lib/app/src/screens/main/home/provider/home_provider.dart';

  ScrollController _scrollController;
  ScrollController get scrollController => _scrollController;
  PageController _pageController;
  PageController get pageController => _pageController;

  utils.LogUtils _log;

  providers.Appointment _appointmentProvider;
  providers.Financial _financialProvider;
  providers.Notification _notificationProvider;
  providers.StaticData _staticDataProvider;

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
  List<models.Appointment> _todayAppointment;
  List<models.Appointment> _rescheduleAppointment;

  Map<int, List<models.StaticData>> _mapPageExpertise;
  Map<int, List<models.StaticData>> get mapPageExpertise => _mapPageExpertise;

  bool _isInit;
  bool get isInit => _isInit;
  bool _isBusy;
  bool get isBusy => _isBusy;
  bool _isFlexibled;
  bool get isFlexibled => _isFlexibled;
  double _appBarPosition;
  double get appBarPosition => _appBarPosition;
  int _pageLength;
  int get pageLength => _pageLength;

  HomeProvider(providers.Appointment appointment, providers.Financial financial,
      providers.Notification notification, providers.StaticData staticData) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);

    this._appBarPosition = 0.0;

    this._appointmentProvider = appointment;
    this._financialProvider = financial;
    this._notificationProvider = notification;
    this._staticDataProvider = staticData;

    this._todayAppointment = [];

    this._isInit = true;
    this._isBusy = false;
    this._isFlexibled = true;
    this._pageLength = 0;
  }

  update(providers.Appointment appointment, providers.Financial financial,
      providers.Notification notification, providers.StaticData staticData) {
    this._appointmentProvider = appointment;
    this._financialProvider = financial;
    this._notificationProvider = notification;
    this._staticDataProvider = staticData;

    notifyListeners();
  }

  List<models.Appointment> get todayAppointment {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    _todayAppointment = _appointmentProvider.confirmed.take(2).toList();

    _log.info(
        method: 'Get todayAppointment', message: jsonEncode(_todayAppointment));

    return _todayAppointment
        .where(
            (value) => DateTime.parse(value.startDate.split('T')[0]) == today)
        .toList();
  }

  List<models.Appointment> get rescheduleAppointment {
    _rescheduleAppointment = _appointmentProvider.reschedule.take(2).toList();

    _log.info(
        method: 'Get rescheduleAppointment',
        message: jsonEncode(_rescheduleAppointment));

    return _rescheduleAppointment;
  }

  List<models.Appointment> get freeAppointment =>
      _appointmentProvider.freeAppointments;

  String get userFullName =>
      '${_appointmentProvider.auth.userData.firstName ?? ''} ${_appointmentProvider.auth.userData.lastName ?? ''}';

  String get balance => _financialProvider.balance;

  int get unReadNotification {
    int infoLength = _notificationProvider.notificationInfos
        .where((element) => element.isRead == false)
        ?.length;
    int promoLength = _notificationProvider.notificationPromos
        .where((element) => element.isRead == false)
        ?.length;
    int transactionLength = _notificationProvider.notificationTransaction
        .where((element) => element.isRead == false)
        ?.length;

    return infoLength + promoLength + transactionLength;
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

  setToBusy() {
    _isBusy = true;

    notifyListeners();
  }

  setToIdle() {
    _isInit = false;
    _isBusy = false;

    notifyListeners();
  }

  navigateToPreference(BuildContext context, models.StaticData data) {
    Navigator.of(context).pushNamed(PreferenceScreen.routeName,
        arguments: helpers.ScreenArguments(staticData: data));
  }

  Future initialLoad() async {
    Map<String, dynamic> queryParamAppointment = {
      'userId': _appointmentProvider.auth.userId,
      'startDate': DateFormat('MM/dd/yyyy').format(DateTime.now()),
      'endDate': DateFormat('MM/dd/yyyy')
          .format(DateTime.now().add(new Duration(days: 90)))
    };

    Map<String, dynamic> queryParamFinancial = {
      "userId": _appointmentProvider.auth.userId
    };

    var futures = <Future>[
      _staticDataProvider.fetchExpertise(),
      _appointmentProvider.fetchAppointment(queryParamAppointment),
      _appointmentProvider.fetchFreeAppointment(),
      _financialProvider.fetchBalance(queryParamFinancial),
      _notificationProvider.fetchNotification()
    ];

    await Future.wait(futures);

    _mapExpertise();
    _appointmentProvider.filterAppointment();

    setToIdle();
  }

  Future onStretch() async {
    print('onStretch');

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setToBusy();
      initialLoad();
    });
  }

  _mapExpertise() {
    if (_staticDataProvider.expertiseData != null) {
      _pageLength = (_staticDataProvider.expertiseData.length / 6).truncate();

      if (_staticDataProvider.expertiseData.length % 6 != 0) {
        _pageLength = _pageLength + 1;
      }

      int key = 0;

      for (int i = 1; i <= _staticDataProvider.expertiseData.length; i++) {
        if (i % 6 == 0) {
          _mapPageExpertise.update(key, (value) {
            value.add(_staticDataProvider.expertiseData[i - 1]);
            return value;
          });

          key++;
        } else {
          if (_mapPageExpertise == null) {
            _mapPageExpertise = {
              key: [_staticDataProvider.expertiseData[i - 1]]
            };
          } else {
            if (_mapPageExpertise.containsKey(key)) {
              _mapPageExpertise.update(key, (value) {
                value.add(_staticDataProvider.expertiseData[i - 1]);
                return value;
              });
            } else {
              _mapPageExpertise.addAll({
                key: [_staticDataProvider.expertiseData[i - 1]]
              });
            }
          }
        }
      }
    }
  }

  initResource() {
    this._scrollController = ScrollController();
    this._scrollController.addListener(_scrollListener);
    this._pageController = PageController();

    this._isInit = true;
  }

  close() {
    this._scrollController?.removeListener(_scrollListener);
    this._pageController?.dispose();
  }
}

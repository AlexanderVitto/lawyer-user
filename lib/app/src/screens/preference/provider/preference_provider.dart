import 'package:flutter/material.dart';

import '../../../../../enum.dart' as localEnum;

import '../../../../config/config.dart' as config;
import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;

import '../../../models/models.dart' as models;
import '../../../providers/providers.dart' as providers;

import '../../psychologist/psychologist_screen.dart';

class PreferenceProvider with ChangeNotifier {
  static const fileName =
      'lib/app/src/screens/preference/provider/preference_provider.dart';

  final List<models.Preference> preferences = [
    models.Preference(
        id: '1',
        name: 'Female',
        queryStringKey: 'sex',
        queryStringValue: '2',
        groupId: 1,
        preferenceType: localEnum.Preference.sex),
    models.Preference(
        id: '2',
        name: 'Male',
        queryStringKey: 'sex',
        queryStringValue: '1',
        groupId: 1,
        preferenceType: localEnum.Preference.sex),
    models.Preference(
        id: '3',
        name: 'English Speaking',
        queryStringKey: 'language',
        queryStringValue: 'en',
        groupId: 1,
        preferenceType: localEnum.Preference.englishSpeaking),
    models.Preference(
        id: '4',
        name: '> 35 Years Old',
        queryStringKey: 'isSenior',
        queryStringValue: 'true',
        groupId: 1,
        preferenceType: localEnum.Preference.age),
    models.Preference(
        id: '5',
        name: '< 35 Years Old',
        queryStringKey: 'isSenior',
        queryStringValue: 'false',
        groupId: 1,
        preferenceType: localEnum.Preference.age),
    models.Preference(
        id: '6',
        name: 'I don’t have any preferences',
        groupId: 2,
        preferenceType: localEnum.Preference.noPreferences),
  ];

  utils.LogUtils _log;

  providers.Partner _partnerProvider;

  bool _isBusy;
  bool get isBusy => _isBusy;

  PreferenceProvider(providers.Partner partner) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);

    this._partnerProvider = partner;

    this._isBusy = false;
  }

  update(providers.Partner partner) {
    this._partnerProvider = partner;

    notifyListeners();
  }

  selectAndReset(models.Preference preference) {
    preferences.forEach((value) {
      if (value.id == preference.id) {
        value.isSelected = !value.isSelected;
      } else if (value.queryStringKey == preference.queryStringKey) {
        value.isSelected = false;
      }

      if (value.groupId != preference.groupId) {
        value.isSelected = false;
      }
    });

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

  Future next(models.StaticData data, BuildContext context) async {
    Map<String, dynamic> queryString = {
      'serviceId': data.id.toString(),
      'currentPage': '1',
      'pageSize': '15'
    };

    preferences.forEach((element) {
      if (element.isSelected && element.queryStringKey != null) {
        queryString[element.queryStringKey] = element.queryStringValue;
      }
    });

    _partnerProvider.setQueryParamListPartner(queryString);

    Navigator.of(context).pushNamed(PsychologistScreen.routeName,
        arguments: helpers.ScreenArguments(staticData: data));
  }
}

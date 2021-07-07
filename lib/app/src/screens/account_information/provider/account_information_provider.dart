import 'package:flutter/material.dart';

import '../../../../config/config.dart' as config;
import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;

import '../../../models/models.dart' as models;
import '../../../providers/providers.dart' as providers;

class AccountInformationProvider with ChangeNotifier {
  static const fileName =
      'lib/app/src/screens/account_information/provider/account_information_provider.dart';

  utils.LogUtils _log;

  providers.Auth _authProvider;
  providers.Auth get auth => _authProvider;
  providers.StaticData _staticDataProvider;

  models.User _userData;
  models.User get userData => _userData;

  models.StaticData get maritalStatus => _staticDataProvider
      .getMaritalStatus(_authProvider.userData.maritalStatusId);

  models.StaticData get genderStatus =>
      _staticDataProvider.getGenderStatus(_authProvider.userData.sexId);

  models.StaticData get cardType =>
      _staticDataProvider.getCardTypeById(_authProvider.userData.idType);

  models.StaticData get religion =>
      _staticDataProvider.getReligionById(_authProvider.userData.religionId);
  models.StaticData get lastEducation => _staticDataProvider
      .getLastEducationById(_authProvider.userData.lastEducation);
  models.StaticData get occupation =>
      _staticDataProvider.getOccupationById(_authProvider.userData.occupation);

  AccountInformationProvider(
      providers.Auth auth, providers.StaticData staticData) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._authProvider = auth;
    this._staticDataProvider = staticData;
  }

  update(providers.Auth auth, providers.StaticData staticData) {
    this._authProvider = auth;
    this._staticDataProvider = staticData;

    notifyListeners();
  }

  initResource() {
    this._userData = _authProvider.userData;
  }
}

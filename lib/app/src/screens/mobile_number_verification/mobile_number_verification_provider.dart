import 'package:flutter/material.dart';

import '../../../config/config.dart' as config;
import '../../../helpers/helpers.dart';
import '../../../utils/utils.dart' as utils;

import '../../models/models.dart' as models;
import '../../providers/providers.dart' as providers;

import '../otp/otp_screen.dart';
import '../shared/shared.dart';

class MobileNumberVerificationProvider with ChangeNotifier {
  static const fileName =
      'lib/app/src/screens/mobile_number_verification/mobile_number_verification_provider.dart';

  utils.LogUtils _log;
  providers.AuthGeneral _authGeneral;

  bool _isBusy;
  bool get isBusy => _isBusy;
  ScreenArguments _arguments;

  String get mobileNumber => _arguments.mobileNumber;

  MobileNumberVerificationProvider(providers.AuthGeneral authGeneral) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._authGeneral = authGeneral;
  }

  update(providers.AuthGeneral authGeneral) {
    this._authGeneral = authGeneral;

    notifyListeners();
  }

  initialize(ScreenArguments arguments) {
    _isBusy = false;

    _arguments = arguments;
  }

  setToBusy() {
    _isBusy = true;

    notifyListeners();
  }

  setToIdle() {
    _isBusy = false;

    notifyListeners();
  }

  Future continueBtn(BuildContext context) async {
    setToBusy();
    await _authGeneral.sendOTP(false);

    setToIdle();

    Navigator.of(context).pushNamed(OTPScreen.routeName, arguments: _arguments);
  }
}

import 'package:flutter/material.dart';

import '../../../../../enum.dart';

import '../../../../config/config.dart' as config;
import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;

import '../../../providers/providers.dart' as providers;

import '../../shared/shared.dart';
import '../../otp/otp_screen.dart';

class MobileNumberVerificationProvider with ChangeNotifier {
  static const fileName =
      'lib/app/src/screens/mobile_number_verification/provider/mobile_number_verification_provider.dart';

  utils.LogUtils _log;

  providers.Auth _authProvider;

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  MobileNumberVerificationProvider(providers.Auth auth) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._authProvider = auth;
  }

  update(providers.Auth auth) {
    this._authProvider = auth;

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

  String get fullMobileNumber =>
      '+${_authProvider.callingCode}${_authProvider.mobileNumber}';

  Future sendOTP(BuildContext context, ScreenSize screenSize) async {
    assert(context != null);
    final method = 'sendOTP';

    setToBusy();

    await _authProvider.sendOTP(false);

    if (_authProvider.authStatus == helpers.AuthResultStatus.phoneVerified) {
      Navigator.of(context).pushNamed(OTPScreen.routeName);
    } else {
      switch (screenSize) {
        case ScreenSize.mini:
          errorDialog(
              context: context,
              iconSize: 45,
              title: 'Send OTP!',
              titleFontSize: 12,
              description:
                  helpers.AuthExceptionHandler.generateExceptionMessage(
                      _authProvider.authStatus),
              descriptionFontSize: 10,
              buttonText: 'Okay',
              buttonFontSize: 10,
              sizedBox1: 12,
              sizedBox2: 5,
              sizedBox3: 10);
          break;
        case ScreenSize.phone:
          errorDialog(
              context: context,
              title: 'Send OTP!',
              description:
                  helpers.AuthExceptionHandler.generateExceptionMessage(
                      _authProvider.authStatus),
              buttonText: 'Okay');
          break;
        case ScreenSize.tablet:
          errorDialog(
              context: context,
              iconSize: 60,
              title: 'Send OTP!',
              titleFontSize: 18,
              description:
                  helpers.AuthExceptionHandler.generateExceptionMessage(
                      _authProvider.authStatus),
              descriptionFontSize: 16,
              buttonText: 'Okay',
              buttonFontSize: 16,
              sizedBox1: 25,
              sizedBox2: 10,
              sizedBox3: 40);
          break;
      }
    }

    setToIdle();
  }
}

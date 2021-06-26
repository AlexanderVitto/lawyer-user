import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../enum.dart';

import '../../../../config/config.dart' as config;
import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;

import '../../../providers/providers.dart' as providers;

import '../../shared/shared.dart';

class OTPProvider with ChangeNotifier {
  static const fileName = 'lib/app/src/screens/otp/provider/otp_provider.dart';

  TextEditingController _codeController;
  TextEditingController get codeController => _codeController;
  Timer _timer;

  utils.LogUtils _log;

  providers.Auth _authProvider;

  bool _isBusy = false;
  bool get isBusy => _isBusy;
  bool _isCodeControllerEmpty;
  bool get isCodeControllerEmpty => _isCodeControllerEmpty;
  int _timeout;
  int get timeout => _timeout;

  OTPProvider(providers.Auth auth) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);

    this._authProvider = auth;
  }

  update(providers.Auth auth) {
    this._authProvider = auth;

    notifyListeners();
  }

  initResource() {
    this._codeController = TextEditingController();
    this._isCodeControllerEmpty = false;
    this._timeout = 60;

    _startTimer();
  }

  close() {
    _timer.cancel();
    _codeController.dispose();
  }

  codeTextOnChange(String text) {
    if (text.length < 1) {
      _isCodeControllerEmpty = true;
    } else {
      _isCodeControllerEmpty = false;
    }

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

  _startTimer() {
    if (_timeout < 1) {
      _timeout = 60;
    }
    _timer = new Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeout < 1) {
        timer.cancel();
      } else {
        _timeout = _timeout - 1;
      }

      notifyListeners();
    });
  }

  Future confirm(BuildContext context, ScreenSize screenSize) async {
    assert(context != null);
    final String method = 'confirm';

    if (_codeController.text.isEmpty) {
      _isCodeControllerEmpty = true;
    } else {
      _isCodeControllerEmpty = false;

      setToBusy();

      await _authProvider.signinWithMobileNumber(_codeController.text);

      switch (screenSize) {
        case ScreenSize.mini:
          if (_authProvider.authStatus == helpers.AuthResultStatus.successful) {
            successDialog(
                context: context,
                barrierDismissible: false,
                iconSize: 72,
                title: 'OTP Confirmation Success!',
                titleFontSize: 12,
                description: 'Click the button to go to our page',
                descriptionFontSize: 10,
                buttonText: 'Okay',
                buttonFontSize: 10,
                sizedBox1: 12,
                sizedBox2: 5,
                sizedBox3: 10);
          } else {
            errorDialog(
                context: context,
                iconSize: 45,
                title: 'OTP Confirmation Error!',
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
          }
          break;
        case ScreenSize.phone:
          if (_authProvider.authStatus == helpers.AuthResultStatus.successful) {
            successDialog(
                context: context,
                barrierDismissible: false,
                title: 'OTP Confirmation Success!',
                description: 'Click the button to go to our page',
                buttonText: 'Okay');
          } else {
            errorDialog(
                context: context,
                title: 'OTP Confirmation Error!',
                description:
                    helpers.AuthExceptionHandler.generateExceptionMessage(
                        _authProvider.authStatus),
                buttonText: 'Okay');
          }
          break;
        case ScreenSize.tablet:
          if (_authProvider.authStatus == helpers.AuthResultStatus.successful) {
            successDialog(
                context: context,
                barrierDismissible: false,
                iconSize: 100,
                title: 'OTP Confirmation Success!',
                titleFontSize: 18,
                description: 'Click the button to go to our page',
                descriptionFontSize: 16,
                buttonText: 'Okay',
                buttonFontSize: 16,
                sizedBox1: 25,
                sizedBox2: 10,
                sizedBox3: 40);
          } else {
            errorDialog(
                context: context,
                iconSize: 60,
                title: 'OTP Confirmation Error!',
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
          }
          break;
      }
    }

    setToIdle();
  }

  Future resend(BuildContext context, ScreenSize screenSize) async {
    assert(context != null);
    final method = 'resend';

    if (_timeout == 0) {
      _startTimer();

      await _authProvider.sendOTP(true);

      if (_authProvider.authStatus == helpers.AuthResultStatus.phoneVerified) {
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
    }
  }
}

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../config/config.dart' as config;
import '../../../helpers/helpers.dart';
import '../../../utils/utils.dart' as utils;

import '../../models/models.dart' as models;
import '../../providers/providers.dart' as providers;

class OTPProvider with ChangeNotifier {
  static const fileName = 'lib/app/src/screens/otp/otp_provider.dart';

  utils.LogUtils _log;
  providers.AuthGeneral _authGeneral;
  ScreenArguments _arguments;
  Timer _timer;

  TextEditingController _codeController;
  TextEditingController get codeController => _codeController;

  bool _isBusy;
  bool get isBusy => _isBusy;
  bool _isCodeEmpty;
  bool get isCodeEmpty => _isCodeEmpty;

  int _timeout;
  int get timeout => _timeout;

  OTPProvider(providers.AuthGeneral authGeneral) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._authGeneral = authGeneral;
  }

  update(providers.AuthGeneral authGeneral) {
    this._authGeneral = authGeneral;

    notifyListeners();
  }

  initialize(ScreenArguments arguments) {
    _codeController = TextEditingController();
    _arguments = arguments;
    _isCodeEmpty = false;
    _timeout = 60;
  }

  close() {
    _codeController.dispose();
    _timer.cancel();
  }

  setToBusy() {
    _isBusy = true;

    notifyListeners();
  }

  setToIdle() {
    _isBusy = false;

    notifyListeners();
  }

  onAccountChanged(String value) {
    if (value.isEmpty) {
      _isCodeEmpty = true;
    } else {
      _isCodeEmpty = false;
    }

    notifyListeners();
  }

  startTimer() {
    if (_timeout == 60) {
      _log.debug(method: 'startTimer', message: 'Start $_timeout');

      _timer = new Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_timeout < 1) {
          timer.cancel();
        } else {
          _timeout = _timeout - 1;
        }

        notifyListeners();
      });
    }
  }

  Future verifyBtn(BuildContext context) async {
    if (!_isCodeEmpty) {
      setToBusy();

      if (_arguments.isRegister) {
        switch (_arguments.accountType) {
          case AccountType.email:
            await _authGeneral.linkEmailAndPhone(_codeController.text);
            break;
          case AccountType.google:
            await _authGeneral.linkGoogleAndPhone(_codeController.text);
            break;
          default:
        }
      } else {
        await _authGeneral.signInWithMobileNumber(_codeController.text);
      }

      setToIdle();
    }
  }

  Future resendBtn() async {
    _log.debug(method: 'resendBtn', message: 'Start $_timeout');
    if (_timeout == 0) {
      _timeout = 60;
      startTimer();

      _authGeneral.sendOTP(true);
    }
  }
}

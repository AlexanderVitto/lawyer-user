import 'package:flutter/material.dart';

import '../../../../../enum.dart';
import '../../../../config/config.dart' as config;
import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;
import '../../../providers/providers.dart' as providers;
import '../../shared/shared.dart';

class ForgotPasswordProvider with ChangeNotifier {
  static const fileName =
      'lib/app/src/screens/forgot_password/provider/forgot_password_provider.dart';

  TextEditingController _emailController;
  TextEditingController get emailController => _emailController;

  utils.LogUtils _log;

  providers.Auth _authProvider;

  bool _isBusy = false;
  bool get isBusy => _isBusy;
  bool _isEmailControllerEmpty = false;
  bool get isEmailControllerEmpty => _isEmailControllerEmpty;

  ForgotPasswordProvider(providers.Auth auth) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._emailController = TextEditingController();
    this._authProvider = auth;
  }

  update(providers.Auth auth) {
    this._authProvider = auth;

    notifyListeners();
  }

  emailTextOnChange(String text) {
    if (text.length < 1) {
      _isEmailControllerEmpty = true;
    } else {
      _isEmailControllerEmpty = false;
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

  Future resetPassword(BuildContext context, ScreenSize screenSize) async {
    assert(context != null);

    if (_emailController.text.isEmpty) {
      _isEmailControllerEmpty = true;
    } else {
      _isEmailControllerEmpty = false;

      setToBusy();
      await _authProvider.resetPassword(_emailController.text);

      switch (screenSize) {
        case ScreenSize.mini:
          if (_authProvider.authStatus == helpers.AuthResultStatus.successful) {
            successDialog(
                context: context,
                barrierDismissible: false,
                iconSize: 72,
                title: 'Reset Password Success!',
                titleFontSize: 12,
                description:
                    'Please check your email. We sent link to reset password.',
                descriptionFontSize: 10,
                buttonText: 'Go To Login',
                buttonFontSize: 10,
                sizedBox1: 12,
                sizedBox2: 5,
                sizedBox3: 10);
          } else {
            errorDialog(
                context: context,
                iconSize: 45,
                title: 'Reset Password Error!',
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
                title: 'Reset Password Success!',
                description:
                    'Please check your email. We sent link to reset password.',
                buttonText: 'Okay');
          } else {
            errorDialog(
                context: context,
                title: 'Reset Password Error!',
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
                title: 'Reset Password Success!',
                titleFontSize: 18,
                description:
                    'Please check your email. We sent link to reset password.',
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
                title: 'Reset Password Error!',
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

  @override
  void dispose() {
    _log.debug(method: 'Dispose', message: 'Done');
    _emailController.dispose();
    super.dispose();
  }
}

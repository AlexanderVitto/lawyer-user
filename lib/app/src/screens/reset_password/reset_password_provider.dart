import 'package:flutter/material.dart';

import '../../../config/config.dart' as config;
import '../../../helpers/helpers.dart';
import '../../../utils/utils.dart' as utils;

import '../../models/models.dart' as models;
import '../../providers/providers.dart' as providers;

import '../shared/shared.dart';

class ResetPasswordProvider with ChangeNotifier {
  static const fileName =
      'lib/app/src/screens/reset_password/reset_password_provider.dart';

  utils.LogUtils _log;
  providers.AuthGeneral _authGeneral;

  TextEditingController _emailController;
  TextEditingController get emailController => _emailController;

  bool _isEmailEmpty;
  bool get isEmailEmpty => _isEmailEmpty;

  ResetPasswordProvider(providers.AuthGeneral authGeneral) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._authGeneral = authGeneral;
  }

  update(providers.AuthGeneral authGeneral) {
    this._authGeneral = authGeneral;

    notifyListeners();
  }

  initialize() {
    _emailController = TextEditingController();

    _isEmailEmpty = false;
  }

  close() {
    _emailController.dispose();
  }

  onEmailChanged(String value) {
    if (value.isEmpty) {
      _isEmailEmpty = true;
    } else {
      _isEmailEmpty = false;
    }

    notifyListeners();
  }

  Future sendToEmailBtn(
      GlobalKey<ScaffoldState> key, BuildContext context) async {
    if (!_isEmailEmpty) {
      await _authGeneral.resetPassword(_emailController.text);

      if (_authGeneral.responseStatus == AuthResultStatus.successful) {
        await successDialog(
            context: context,
            barrierDismissible: false,
            title: 'Reset Password Success!',
            description:
                'Please check your email. We sent link to reset password.',
            buttonText: 'Ok');

        Navigator.of(context).pop();
      } else {
        final localization = AppLocalizations.of(context);
        key.currentState.showSnackBar(SnackBar(
            content: Text(localization
                .translate('Password and confirm password does not match'))));
      }
    }
  }
}

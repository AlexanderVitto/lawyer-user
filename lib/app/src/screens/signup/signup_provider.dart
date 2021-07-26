import 'package:flutter/material.dart';

import '../../../config/config.dart' as config;
import '../../../helpers/helpers.dart';
import '../../../utils/utils.dart' as utils;

import '../../models/models.dart' as models;
import '../../providers/providers.dart' as providers;

import '../mobile_number_verification/mobile_number_verification_scree.dart';

class SignUpProvider with ChangeNotifier {
  static const fileName = 'lib/app/src/screens/signup/signup_provider.dart';

  utils.LogUtils _log;
  providers.AuthGeneral _authGeneral;

  final Pattern _pattern = r'^(?:[+0])?[0-9]+$';
  RegExp _regex;

  TextEditingController _accountController;
  TextEditingController get accountController => _accountController;
  TextEditingController _passwordController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController _confirmPasswordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;
  TextEditingController _nameController;
  TextEditingController get nameController => _nameController;
  TextEditingController _mobileNumberController;
  TextEditingController get mobileNumberController => _mobileNumberController;

  bool _isBusy;
  bool get isBusy => _isBusy;
  bool _isAccountEmpty;
  bool get isAccountEmpty => _isAccountEmpty;
  bool _isPasswordEmpty;
  bool get isPasswordEmpty => _isPasswordEmpty;
  bool _isConfirmPasswordEmpty;
  bool get isConfirmPasswordEmpty => _isConfirmPasswordEmpty;
  bool _isNameEmpty;
  bool get isNameEmpty => _isNameEmpty;
  bool _isMobileNumberEmpty;
  bool get isMobileNumberEmpty => _isMobileNumberEmpty;
  bool _isPasswordObscure;
  bool get isPasswordObscure => _isPasswordObscure;
  bool _isConfirmPasswordObscure;
  bool get isConfirmPasswordObscure => _isConfirmPasswordObscure;

  SignUpProvider(providers.AuthGeneral authGeneral) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._authGeneral = authGeneral;
  }

  update(providers.AuthGeneral authGeneral) {
    this._authGeneral = authGeneral;

    notifyListeners();
  }

  initialize() {
    _regex = RegExp(_pattern);
    _accountController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _nameController = TextEditingController();
    _mobileNumberController = TextEditingController();

    _isAccountEmpty = false;
    _isPasswordEmpty = false;
    _isConfirmPasswordEmpty = false;
    _isNameEmpty = false;
    _isMobileNumberEmpty = false;
    _isPasswordObscure = true;
    _isConfirmPasswordObscure = true;
  }

  close() {
    _accountController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _mobileNumberController.dispose();
  }

  setToBusy() {
    _isBusy = true;

    notifyListeners();
  }

  setToIdle() {
    _isBusy = false;

    notifyListeners();
  }

  togglePasswordObscure() {
    _isPasswordObscure = !_isPasswordObscure;

    notifyListeners();
  }

  toggleConfirmPasswordObscure() {
    _isConfirmPasswordObscure = !_isConfirmPasswordObscure;

    notifyListeners();
  }

  onAccountChanged(String value) {
    if (value.isEmpty) {
      _isAccountEmpty = true;
    } else {
      _isAccountEmpty = false;
    }

    notifyListeners();
  }

  onPasswordChanged(String value) {
    if (value.isEmpty) {
      _isPasswordEmpty = true;
    } else {
      _isPasswordEmpty = false;
    }

    notifyListeners();
  }

  onConfirmPasswordChanged(String value) {
    if (value.isEmpty) {
      _isConfirmPasswordEmpty = true;
    } else {
      _isConfirmPasswordEmpty = false;
    }

    notifyListeners();
  }

  onNameChanged(String value) {
    if (value.isEmpty) {
      _isNameEmpty = true;
    } else {
      _isNameEmpty = false;
    }

    notifyListeners();
  }

  onMobileNumberChanged(String value) {
    if (value.isEmpty) {
      _isMobileNumberEmpty = true;
    } else {
      _isMobileNumberEmpty = false;
    }

    notifyListeners();
  }

  Future createAccountBtn(
      GlobalKey<ScaffoldState> key, BuildContext context) async {
    if (!_isAccountEmpty &&
        !_isPasswordEmpty &&
        !_isConfirmPasswordEmpty &&
        !_isNameEmpty &&
        !_isMobileNumberEmpty) {
      if (_passwordController.text == _confirmPasswordController.text) {
        // Singin with email & mobile number
        // Link credential

        _authGeneral.setSignUpModel(nameController.text, accountController.text,
            mobileNumberController.text, passwordController.text);

        Navigator.of(context).pushNamed(
            MobileNumberVerificationScreen.routeName,
            arguments: ScreenArguments(
                mobileNumber: _mobileNumberController.text,
                isRegister: true,
                accountType: AccountType.email));
      } else {
        final localization = AppLocalizations.of(context);
        key.currentState.showSnackBar(SnackBar(
            content: Text(localization
                .translate('Password and confirm password does not match'))));
      }
    }
  }

  Future createAccountWithGoogleBtn(
      GlobalKey<ScaffoldState> key, BuildContext context) async {
    await _authGeneral.signUpWithGoogle();

    if (_authGeneral.responseStatus == AuthResultStatus.successful) {
      // TODO: get user profile

    } else {
      final localization = AppLocalizations.of(context);
      key.currentState.showSnackBar(SnackBar(
          content: Text(localization.translate(
              AuthExceptionHandler.generateExceptionMessage(
                  _authGeneral.responseStatus)))));
    }
  }
}

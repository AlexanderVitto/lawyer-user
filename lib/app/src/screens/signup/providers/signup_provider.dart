import 'package:flutter/material.dart';

import '../../../../../enum.dart';
import '../../../../config/config.dart' as config;
import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;
import '../../../providers/providers.dart' as providers;
import '../../shared/shared.dart';

class SignupProvider with ChangeNotifier {
  static const fileName =
      'lib/app/src/screens/signup/providers/signup_provider.dart';

  final Pattern _pattern = r'^(?:[+0])?[0-9]+$';
  RegExp _regex;

  TextEditingController _nameController;
  TextEditingController get nameController => _nameController;
  TextEditingController _userController;
  TextEditingController get userController => _userController;
  TextEditingController _passwordController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController _passwordConfirmationController;
  TextEditingController get passwordConfirmationController =>
      _passwordConfirmationController;

  utils.LogUtils _log;

  providers.Auth _authProvider;

  bool _isBusy = false;
  bool get isBusy => _isBusy;
  bool _isLoginWithEmail = false;
  bool get isLogineWithEmail => _isLoginWithEmail;
  bool _isPasswordControllerEmpty = false;
  bool get isPasswordControllerEmpty => _isPasswordControllerEmpty;
  bool _isPasswordConfirmationControllerEmpty = false;
  bool get isPasswordConfirmationControllerEmpty =>
      _isPasswordConfirmationControllerEmpty;
  bool _isUserControllerEmpty = false;
  bool get isUserControllerEmpty => _isUserControllerEmpty;
  bool _passwordIsObsecure = true;
  bool get passwordIsObsecure => _passwordIsObsecure;
  bool _passwordConfirmationIsObsecure = true;
  bool get passwordConfirmationIsObsecure => _passwordConfirmationIsObsecure;

  bool _isNameControllerEmpty = false;
  bool get isNameControllerEmpty => _isNameControllerEmpty;

  SignupProvider() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._regex = RegExp(_pattern);
    this._nameController = TextEditingController();
    this._userController = TextEditingController();
    this._passwordController = TextEditingController();
    this._passwordConfirmationController = TextEditingController();
  }

  update(providers.Auth auth) {
    this._authProvider = auth;

    notifyListeners();
  }

  toggleObsecurePassword() {
    _passwordIsObsecure = !_passwordIsObsecure;

    notifyListeners();
  }

  toggleObsecurePasswordConfirmation() {
    _passwordConfirmationIsObsecure = !_passwordConfirmationIsObsecure;

    notifyListeners();
  }

  nameTextOnChange(String text) {
    if (text.length < 1) {
      _isNameControllerEmpty = true;
    } else {
      _isNameControllerEmpty = false;
    }

    notifyListeners();
  }

  userTextOnChange(String text) {
    if (text.length < 1) {
      _isUserControllerEmpty = true;
    } else {
      _isUserControllerEmpty = false;
    }

    notifyListeners();
  }

  passwordTextOnChange(String text) {
    if (text.length < 1) {
      _isPasswordControllerEmpty = true;
    } else {
      _isPasswordControllerEmpty = false;
    }

    notifyListeners();
  }

  passwordConfirmationTextOnChange(String text) {
    if (text.length < 1) {
      _isPasswordConfirmationControllerEmpty = true;
    } else {
      _isPasswordConfirmationControllerEmpty = false;
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

  Future nextButton() async {
    if (_userController.text.isEmpty) {
      _isUserControllerEmpty = true;
    } else {
      if (_regex.hasMatch(_userController.text)) {
        _isUserControllerEmpty = false;

        _isLoginWithEmail = false;
      } else {
        _isUserControllerEmpty = false;
        _isLoginWithEmail = true;
      }
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _userController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';

import '../../../config/config.dart' as config;
import '../../../helpers/helpers.dart';
import '../../../utils/utils.dart' as utils;

import '../../models/models.dart' as models;
import '../../providers/providers.dart' as providers;

import '../shared/shared.dart';
import '../mobile_number_verification/mobile_number_verification_scree.dart';

enum SignInMode { mobileNumber, email }

class SigninProvider with ChangeNotifier {
  static const fileName = 'lib/app/src/screens/signin/signin_provider.dart';

  utils.LogUtils _log;
  providers.AuthGeneral _authGeneral;

  final Pattern _pattern = r'^(?:[+0])?[0-9]+$';
  RegExp _regex;

  TextEditingController _accountController;
  TextEditingController get accountController => _accountController;
  TextEditingController _passwordController;
  TextEditingController get passwordController => _passwordController;

  SignInMode _signInMode;
  SignInMode get signInMode => _signInMode;

  bool _isAccountEmpty;
  bool get isAccountEmpty => _isAccountEmpty;
  bool _isBusy;
  bool get isBusy => _isBusy;
  bool _isPasswordEmpty;
  bool get isPasswordEmpty => _isPasswordEmpty;
  bool _isPasswordObscure;
  bool get isPasswordObscure => _isPasswordObscure;

  SigninProvider(providers.AuthGeneral authGeneral) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
  }

  update(providers.AuthGeneral authGeneral) {
    this._authGeneral = authGeneral;

    notifyListeners();
  }

  initialize() {
    _regex = RegExp(_pattern);
    _accountController = TextEditingController();
    _passwordController = TextEditingController();
    _signInMode = SignInMode.mobileNumber;

    _isBusy = false;

    _isAccountEmpty = false;
    _isPasswordEmpty = false;
    _isPasswordObscure = true;
  }

  close() {
    _accountController.dispose();
    _passwordController.dispose();
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

  Future signinBtn(GlobalKey<ScaffoldState> key, BuildContext context) async {
    if (_accountController.text.isEmpty) {
      _isAccountEmpty = true;
    } else {
      if (_regex.hasMatch(_accountController.text)) {
        // Mobile number
        _signInMode = SignInMode.mobileNumber;

        Navigator.of(context).pushNamed(
            MobileNumberVerificationScreen.routeName,
            arguments: ScreenArguments(
                mobileNumber: _accountController.text, isRegister: false));
      } else {
        // Email
        _signInMode = SignInMode.email;

        if (_passwordController.text.isEmpty) {
          _isPasswordEmpty = true;
        } else {
          // SignIn with email
          setToBusy();

          await _authGeneral.signInWithEmail(
              accountController.text, passwordController.text);

          setToIdle();

          if (_authGeneral.responseStatus == AuthResultStatus.successful) {
            await successDialog(
                context: context,
                barrierDismissible: false,
                title: 'Sign In Success!',
                description: 'Click the button to go to our page.',
                buttonText: 'Ok');
          } else {
            final localization = AppLocalizations.of(context);
            key.currentState.showSnackBar(SnackBar(
                content: Text(localization.translate(
                    AuthExceptionHandler.generateExceptionMessage(
                        _authGeneral.responseStatus)))));
          }
        }
      }
    }

    notifyListeners();
  }

  Future signInWithGoogleBtn(
      GlobalKey<ScaffoldState> key, BuildContext context) async {
    await _authGeneral.signInWithGoogle();

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

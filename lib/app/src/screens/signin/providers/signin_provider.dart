import 'package:flutter/material.dart';

import '../../../../../enum.dart';
import '../../../../config/config.dart' as config;
import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;
import '../../../providers/providers.dart' as providers;
import '../../shared/shared.dart';

class SigninProvider with ChangeNotifier {
  static const fileName =
      'lib/app/src/screens/signin/providers/signin_provider.dart';

  final Pattern _pattern = r'^(?:[+0])?[0-9]+$';
  RegExp _regex;

  TextEditingController _userController;
  TextEditingController get userController => _userController;
  TextEditingController _passwordController;
  TextEditingController get passwordController => _passwordController;

  utils.LogUtils _log;

  providers.Auth _authProvider;

  bool _isBusy = false;
  bool get isBusy => _isBusy;
  bool _isLoginWithEmail = false;
  bool get isLogineWithEmail => _isLoginWithEmail;
  bool _isPasswordControllerEmpty = false;
  bool get isPasswordControllerEmpty => _isPasswordControllerEmpty;
  bool _isUserControllerEmpty = false;
  bool get isUserControllerEmpty => _isUserControllerEmpty;
  bool _passwordIsObsecure = true;
  bool get passwordIsObsecure => _passwordIsObsecure;

  SigninProvider() {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._regex = RegExp(_pattern);
    this._userController = TextEditingController();
    this._passwordController = TextEditingController();
  }

  update(providers.Auth auth) {
    this._authProvider = auth;

    notifyListeners();
  }

  toggleObsecurePassword() {
    _passwordIsObsecure = !_passwordIsObsecure;

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

  Future loginWithEmail(BuildContext context, ScreenSize screenSize) async {
    assert(context != null);
    _authProvider.setIsRegister(false);

    if (_userController.text.isEmpty) {
      _isUserControllerEmpty = true;
    } else {
      _isUserControllerEmpty = false;
    }

    if (_passwordController.text.isEmpty) {
      _isPasswordControllerEmpty = true;
    } else {
      _isPasswordControllerEmpty = false;
    }

    if (!_isUserControllerEmpty && !_isPasswordControllerEmpty) {
      if (_regex.hasMatch(_userController.text)) {
        _isUserControllerEmpty = false;

        _isLoginWithEmail = false;

        // Redirect to verify otp screen
      } else {
        _isUserControllerEmpty = false;

        setToBusy();

        await _authProvider.emailSignin(
            _userController.text, _passwordController.text);

        switch (screenSize) {
          case ScreenSize.mini:
            if (_authProvider.loginResult ==
                helpers.AuthResultStatus.successful) {
              successDialog(
                  context: context,
                  barrierDismissible: false,
                  iconSize: 72,
                  title: 'Login Success!',
                  titleFontSize: 14,
                  description: 'Click the button to go to our page',
                  descriptionFontSize: 12,
                  buttonText: 'Okay',
                  buttonFontSize: 12,
                  sizedBox1: 15,
                  sizedBox2: 5,
                  sizedBox3: 20);
            } else {
              errorDialog(
                  context: context,
                  iconSize: 45,
                  title: 'Login Error!',
                  titleFontSize: 14,
                  description:
                      helpers.AuthExceptionHandler.generateExceptionMessage(
                          _authProvider.loginResult),
                  descriptionFontSize: 12,
                  buttonText: 'Okay',
                  buttonFontSize: 12,
                  sizedBox1: 15,
                  sizedBox2: 5,
                  sizedBox3: 20);
            }
            break;
          case ScreenSize.phone:
            if (_authProvider.loginResult ==
                helpers.AuthResultStatus.successful) {
              successDialog(
                  context: context,
                  barrierDismissible: false,
                  title: 'Login Success!',
                  description: 'Click the button to go to our page',
                  buttonText: 'Okay');
            } else {
              errorDialog(
                  context: context,
                  title: 'Login Error!',
                  description:
                      helpers.AuthExceptionHandler.generateExceptionMessage(
                          _authProvider.loginResult),
                  buttonText: 'Okay');
            }
            break;
          case ScreenSize.tablet:
            if (_authProvider.loginResult ==
                helpers.AuthResultStatus.successful) {
              successDialog(
                  context: context,
                  barrierDismissible: false,
                  iconSize: 100,
                  title: 'Login Success!',
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
                  title: 'Login Error!',
                  titleFontSize: 18,
                  description:
                      helpers.AuthExceptionHandler.generateExceptionMessage(
                          _authProvider.loginResult),
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
    }

    setToIdle();
  }

  Future loginWithFacebook(BuildContext context, ScreenSize screenSize) async {
    assert(context != null);
    _authProvider.setIsRegister(false);

    setToBusy();

    await _authProvider.facebookSignIn();

    switch (screenSize) {
      case ScreenSize.mini:
        if (_authProvider.loginResult == helpers.AuthResultStatus.successful) {
          successDialog(
              context: context,
              barrierDismissible: false,
              iconSize: 72,
              title: 'Login Success!',
              titleFontSize: 14,
              description: 'Click the button to go to our page',
              descriptionFontSize: 12,
              buttonText: 'Okay',
              buttonFontSize: 12,
              sizedBox1: 15,
              sizedBox2: 5,
              sizedBox3: 20);
        } else {
          errorDialog(
              context: context,
              iconSize: 45,
              title: 'Login Error!',
              titleFontSize: 14,
              description:
                  helpers.AuthExceptionHandler.generateExceptionMessage(
                      _authProvider.loginResult),
              descriptionFontSize: 12,
              buttonText: 'Okay',
              buttonFontSize: 12,
              sizedBox1: 15,
              sizedBox2: 5,
              sizedBox3: 20);
        }
        break;
      case ScreenSize.phone:
        if (_authProvider.loginResult == helpers.AuthResultStatus.successful) {
          successDialog(
              context: context,
              barrierDismissible: false,
              title: 'Login Success!',
              description: 'Click the button to go to our page',
              buttonText: 'Okay');
        } else {
          errorDialog(
              context: context,
              title: 'Login Error!',
              description:
                  helpers.AuthExceptionHandler.generateExceptionMessage(
                      _authProvider.loginResult),
              buttonText: 'Okay');
        }
        break;
      case ScreenSize.tablet:
        if (_authProvider.loginResult == helpers.AuthResultStatus.successful) {
          successDialog(
              context: context,
              barrierDismissible: false,
              iconSize: 100,
              title: 'Login Success!',
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
              title: 'Login Error!',
              titleFontSize: 18,
              description:
                  helpers.AuthExceptionHandler.generateExceptionMessage(
                      _authProvider.loginResult),
              descriptionFontSize: 16,
              buttonText: 'Okay',
              buttonFontSize: 16,
              sizedBox1: 25,
              sizedBox2: 10,
              sizedBox3: 40);
        }
        break;
    }

    setToIdle();
  }

  Future loginWithGoogle(BuildContext context, ScreenSize screenSize) async {
    assert(context != null);
    _authProvider.setIsRegister(false);

    setToBusy();

    await _authProvider.googleSignin();

    switch (screenSize) {
      case ScreenSize.mini:
        if (_authProvider.loginResult == helpers.AuthResultStatus.successful) {
          successDialog(
              context: context,
              barrierDismissible: false,
              iconSize: 72,
              title: 'Login Success!',
              titleFontSize: 14,
              description: 'Click the button to go to our page',
              descriptionFontSize: 12,
              buttonText: 'Okay',
              buttonFontSize: 12,
              sizedBox1: 15,
              sizedBox2: 5,
              sizedBox3: 20);
        } else {
          errorDialog(
              context: context,
              iconSize: 45,
              title: 'Login Error!',
              titleFontSize: 14,
              description:
                  helpers.AuthExceptionHandler.generateExceptionMessage(
                      _authProvider.loginResult),
              descriptionFontSize: 12,
              buttonText: 'Okay',
              buttonFontSize: 12,
              sizedBox1: 15,
              sizedBox2: 5,
              sizedBox3: 20);
        }
        break;
      case ScreenSize.phone:
        if (_authProvider.loginResult == helpers.AuthResultStatus.successful) {
          successDialog(
              context: context,
              barrierDismissible: false,
              title: 'Login Success!',
              description: 'Click the button to go to our page',
              buttonText: 'Okay');
        } else {
          errorDialog(
              context: context,
              title: 'Login Error!',
              description:
                  helpers.AuthExceptionHandler.generateExceptionMessage(
                      _authProvider.loginResult),
              buttonText: 'Okay');
        }
        break;
      case ScreenSize.tablet:
        if (_authProvider.loginResult == helpers.AuthResultStatus.successful) {
          successDialog(
              context: context,
              barrierDismissible: false,
              iconSize: 100,
              title: 'Login Success!',
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
              title: 'Login Error!',
              titleFontSize: 18,
              description:
                  helpers.AuthExceptionHandler.generateExceptionMessage(
                      _authProvider.loginResult),
              descriptionFontSize: 16,
              buttonText: 'Okay',
              buttonFontSize: 16,
              sizedBox1: 25,
              sizedBox2: 10,
              sizedBox3: 40);
        }
        break;
    }

    setToIdle();
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

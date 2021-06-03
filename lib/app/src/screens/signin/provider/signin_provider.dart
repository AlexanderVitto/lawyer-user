import 'package:flutter/material.dart';

import '../../../../../enum.dart';

import '../../../../config/config.dart' as config;
import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;

import '../../../providers/providers.dart' as providers;

import '../../shared/shared.dart';
import '../../signup/signup_screen.dart';
import '../../forgot_password/forgot_password_screen.dart';
import '../../mobile_number_verification/mobile_number_verification_screen.dart';
import '../../main/main_screen.dart';

class SignInProvider with ChangeNotifier {
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

  SignInProvider(providers.Auth auth) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._regex = RegExp(_pattern);
    this._userController = TextEditingController();
    this._passwordController = TextEditingController();
    this._authProvider = auth;
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

  navigateToSignUp(BuildContext context) {
    Navigator.of(context).pushNamed(SignUpScreen.routeName);
  }

  navigateToForgotPassword(BuildContext context) {
    Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName);
  }

  Future nextButton(BuildContext context) async {
    assert(context != null);
    _authProvider.setIsRegister(false);

    if (_userController.text.isEmpty) {
      _isUserControllerEmpty = true;
    } else {
      if (_regex.hasMatch(_userController.text)) {
        _isUserControllerEmpty = false;

        _isLoginWithEmail = false;

        String number = _userController.text.substring(1);

        _authProvider.setCallingCode('62');
        _authProvider.setMobileNumber(number);

        Navigator.of(context).pushNamed(
          MobileNumberVerificationScreen.routeName,
        );
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
            if (_authProvider.authStatus ==
                helpers.AuthResultStatus.successful) {
              await successDialog(
                  context: context,
                  barrierDismissible: false,
                  iconSize: 72,
                  title: 'Login Success!',
                  titleFontSize: 12,
                  description: 'Click the button to go to our page',
                  descriptionFontSize: 10,
                  buttonText: 'Okay',
                  buttonFontSize: 10,
                  sizedBox1: 12,
                  sizedBox2: 5,
                  sizedBox3: 10);

              Navigator.of(context).pushNamedAndRemoveUntil(
                  MainScreen.routeName, (route) => false,
                  arguments: helpers.ScreenArguments(
                      mainScreenTab: MainScreenTab.home));
            } else {
              errorDialog(
                  context: context,
                  iconSize: 45,
                  title: 'Login Error!',
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
            if (_authProvider.authStatus ==
                helpers.AuthResultStatus.successful) {
              await successDialog(
                  context: context,
                  barrierDismissible: false,
                  title: 'Login Success!',
                  description: 'Click the button to go to our page',
                  buttonText: 'Okay');

              Navigator.of(context).pushNamedAndRemoveUntil(
                  MainScreen.routeName, (route) => false,
                  arguments: helpers.ScreenArguments(
                      mainScreenTab: MainScreenTab.home));
            } else {
              errorDialog(
                  context: context,
                  title: 'Login Error!',
                  description:
                      helpers.AuthExceptionHandler.generateExceptionMessage(
                          _authProvider.authStatus),
                  buttonText: 'Okay');
            }
            break;
          case ScreenSize.tablet:
            if (_authProvider.authStatus ==
                helpers.AuthResultStatus.successful) {
              await successDialog(
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

              Navigator.of(context).pushNamedAndRemoveUntil(
                  MainScreen.routeName, (route) => false,
                  arguments: helpers.ScreenArguments(
                      mainScreenTab: MainScreenTab.home));
            } else {
              errorDialog(
                  context: context,
                  iconSize: 60,
                  title: 'Login Error!',
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
        if (_authProvider.authStatus == helpers.AuthResultStatus.successful) {
          await successDialog(
              context: context,
              barrierDismissible: false,
              iconSize: 72,
              title: 'Login Success!',
              titleFontSize: 14,
              description: 'Click the button to go to our page',
              descriptionFontSize: 10,
              buttonText: 'Okay',
              buttonFontSize: 10,
              sizedBox1: 12,
              sizedBox2: 5,
              sizedBox3: 10);

          Navigator.of(context).pushNamedAndRemoveUntil(
              MainScreen.routeName, (route) => false,
              arguments:
                  helpers.ScreenArguments(mainScreenTab: MainScreenTab.home));
        } else {
          errorDialog(
              context: context,
              iconSize: 45,
              title: 'Login Error!',
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
          await successDialog(
              context: context,
              barrierDismissible: false,
              title: 'Login Success!',
              description: 'Click the button to go to our page',
              buttonText: 'Okay');

          Navigator.of(context).pushNamedAndRemoveUntil(
              MainScreen.routeName, (route) => false,
              arguments:
                  helpers.ScreenArguments(mainScreenTab: MainScreenTab.home));
        } else {
          errorDialog(
              context: context,
              title: 'Login Error!',
              description:
                  helpers.AuthExceptionHandler.generateExceptionMessage(
                      _authProvider.authStatus),
              buttonText: 'Okay');
        }
        break;
      case ScreenSize.tablet:
        if (_authProvider.authStatus == helpers.AuthResultStatus.successful) {
          await successDialog(
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

          Navigator.of(context).pushNamedAndRemoveUntil(
              MainScreen.routeName, (route) => false,
              arguments:
                  helpers.ScreenArguments(mainScreenTab: MainScreenTab.home));
        } else {
          errorDialog(
              context: context,
              iconSize: 60,
              title: 'Login Error!',
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

    setToIdle();
  }

  Future loginWithGoogle(BuildContext context, ScreenSize screenSize) async {
    assert(context != null);
    _authProvider.setIsRegister(false);

    setToBusy();

    await _authProvider.googleSignin();

    switch (screenSize) {
      case ScreenSize.mini:
        if (_authProvider.authStatus == helpers.AuthResultStatus.successful) {
          await successDialog(
              context: context,
              barrierDismissible: false,
              iconSize: 72,
              title: 'Login Success!',
              titleFontSize: 14,
              description: 'Click the button to go to our page',
              descriptionFontSize: 10,
              buttonText: 'Okay',
              buttonFontSize: 10,
              sizedBox1: 12,
              sizedBox2: 5,
              sizedBox3: 10);

          Navigator.of(context).pushNamedAndRemoveUntil(
              MainScreen.routeName, (route) => false,
              arguments:
                  helpers.ScreenArguments(mainScreenTab: MainScreenTab.home));
        } else {
          errorDialog(
              context: context,
              iconSize: 45,
              title: 'Login Error!',
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
          await successDialog(
              context: context,
              barrierDismissible: false,
              title: 'Login Success!',
              description: 'Click the button to go to our page',
              buttonText: 'Okay');

          Navigator.of(context).pushNamedAndRemoveUntil(
              MainScreen.routeName, (route) => false,
              arguments:
                  helpers.ScreenArguments(mainScreenTab: MainScreenTab.home));
        } else {
          errorDialog(
              context: context,
              title: 'Login Error!',
              description:
                  helpers.AuthExceptionHandler.generateExceptionMessage(
                      _authProvider.authStatus),
              buttonText: 'Okay');
        }
        break;
      case ScreenSize.tablet:
        if (_authProvider.authStatus == helpers.AuthResultStatus.successful) {
          await successDialog(
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

          Navigator.of(context).pushNamedAndRemoveUntil(
              MainScreen.routeName, (route) => false,
              arguments:
                  helpers.ScreenArguments(mainScreenTab: MainScreenTab.home));
        } else {
          errorDialog(
              context: context,
              iconSize: 60,
              title: 'Login Error!',
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

    setToIdle();
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

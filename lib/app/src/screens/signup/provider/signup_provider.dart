import 'package:flutter/material.dart';

import '../../../../../enum.dart';

import '../../../../config/config.dart' as config;
import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;

import '../../../providers/providers.dart' as providers;

import '../../shared/shared.dart';
import '../../signin/signin_screen.dart';
import '../../forgot_password/forgot_password_screen.dart';
import '../../mobile_number_verification/mobile_number_verification_screen.dart';
import '../../main/main_screen.dart';

class SignUpProvider with ChangeNotifier {
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
  bool _isLoginWithEmail;
  bool get isLogineWithEmail => _isLoginWithEmail;
  bool _isPasswordControllerEmpty;
  bool get isPasswordControllerEmpty => _isPasswordControllerEmpty;
  bool _isPasswordConfirmationControllerEmpty;
  bool get isPasswordConfirmationControllerEmpty =>
      _isPasswordConfirmationControllerEmpty;
  bool _isUserControllerEmpty;
  bool get isUserControllerEmpty => _isUserControllerEmpty;
  bool _isPasswordMatch;
  bool get isPasswordMatch => _isPasswordMatch;
  bool _isNameControllerEmpty;
  bool get isNameControllerEmpty => _isNameControllerEmpty;

  bool _passwordIsObsecure;
  bool get passwordIsObsecure => _passwordIsObsecure;
  bool _passwordConfirmationIsObsecure;
  bool get passwordConfirmationIsObsecure => _passwordConfirmationIsObsecure;

  SignUpProvider(providers.Auth auth) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._authProvider = auth;
  }

  update(providers.Auth auth) {
    this._authProvider = auth;

    notifyListeners();
  }

  initResource() {
    this._regex = RegExp(_pattern);
    this._nameController = TextEditingController();
    this._userController = TextEditingController();
    this._passwordController = TextEditingController();
    this._passwordConfirmationController = TextEditingController();
    this._isLoginWithEmail = false;
    this._isPasswordControllerEmpty = false;
    this._isPasswordConfirmationControllerEmpty = false;
    this._isUserControllerEmpty = false;
    this._isPasswordMatch = true;
    this._isNameControllerEmpty = false;
    this._passwordIsObsecure = true;
    this._passwordConfirmationIsObsecure = true;
  }

  close() {
    _nameController.dispose();
    _userController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
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

  navigateToSignIn(BuildContext context) {
    Navigator.of(context).pushNamed(SignInScreen.routeName);
  }

  navigateToForgotPassword(BuildContext context) {
    Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName);
  }

  Future nextButton(BuildContext context) async {
    assert(context != null);
    _authProvider.setIsRegister(true);

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

  signupWithEmail(BuildContext context, ScreenSize screenSize) async {
    assert(context != null);
    _authProvider.setIsRegister(true);

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

    if (_passwordConfirmationController.text.isEmpty) {
      _isPasswordConfirmationControllerEmpty = true;
    } else {
      _isPasswordConfirmationControllerEmpty = false;
    }

    if (_nameController.text.isEmpty) {
      _isNameControllerEmpty = true;
    } else {
      _isNameControllerEmpty = false;
    }

    if (!_isUserControllerEmpty &&
        !_isPasswordControllerEmpty &&
        !_isPasswordConfirmationControllerEmpty &&
        !_isNameControllerEmpty) {
      if (_regex.hasMatch(_userController.text)) {
        _isUserControllerEmpty = false;

        _isLoginWithEmail = false;

        // Redirect to verify otp screen
      } else {
        _isUserControllerEmpty = false;

        if (_passwordController.text != _passwordConfirmationController.text) {
          _isPasswordMatch = false;
        } else {
          _isPasswordMatch = true;

          setToBusy();

          await _authProvider.emailSignup(_userController.text,
              _nameController.text, _passwordController.text);

          switch (screenSize) {
            case ScreenSize.mini:
              if (_authProvider.authStatus ==
                  helpers.AuthResultStatus.successful) {
                await successDialog(
                    context: context,
                    barrierDismissible: false,
                    iconSize: 72,
                    title: 'Registration Success!',
                    titleFontSize: 12,
                    description:
                        'Please check your email to verify, or you can click the button to go to our page.',
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
                    title: 'Registration Failed!',
                    titleFontSize: 12,
                    description:
                        helpers.AuthExceptionHandler.generateExceptionMessage(
                            _authProvider.authStatus),
                    descriptionFontSize: 10,
                    buttonText: 'Okay',
                    buttonFontSize: 10,
                    sizedBox1: 15,
                    sizedBox2: 5,
                    sizedBox3: 20);
              }
              break;
            case ScreenSize.phone:
              if (_authProvider.authStatus ==
                  helpers.AuthResultStatus.successful) {
                await successDialog(
                    context: context,
                    barrierDismissible: false,
                    title: 'Registration Success!',
                    description:
                        'Please check your email to verify, or you can click the button to go to our page.',
                    buttonText: 'Okay');

                Navigator.of(context).pushNamedAndRemoveUntil(
                    MainScreen.routeName, (route) => false,
                    arguments: helpers.ScreenArguments(
                        mainScreenTab: MainScreenTab.home));
              } else {
                errorDialog(
                    context: context,
                    title: 'Registration Failed!',
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
                    title: 'Registration Success!',
                    titleFontSize: 18,
                    description:
                        'Please check your email to verify, or you can click the button to go to our page.',
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
                    title: 'Registration Failed!',
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
    }

    setToIdle();
  }

  Future signupWithFacebook(BuildContext context, ScreenSize screenSize) async {
    assert(context != null);
    _authProvider.setIsRegister(true);

    await _authProvider.facebookSignIn();

    switch (screenSize) {
      case ScreenSize.mini:
        if (_authProvider.authStatus == helpers.AuthResultStatus.successful) {
          await successDialog(
              context: context,
              barrierDismissible: false,
              iconSize: 72,
              title: 'Registration Success!',
              titleFontSize: 12,
              description:
                  'Please check your email to verify, or you can click the button to go to our page.',
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
              title: 'Registration Failed!',
              titleFontSize: 12,
              description:
                  helpers.AuthExceptionHandler.generateExceptionMessage(
                      _authProvider.authStatus),
              descriptionFontSize: 10,
              buttonText: 'Okay',
              buttonFontSize: 10,
              sizedBox1: 15,
              sizedBox2: 5,
              sizedBox3: 20);
        }
        break;
      case ScreenSize.phone:
        if (_authProvider.authStatus == helpers.AuthResultStatus.successful) {
          await successDialog(
              context: context,
              barrierDismissible: false,
              title: 'Registration Success!',
              description:
                  'Please check your email to verify, or you can click the button to go to our page.',
              buttonText: 'Okay');

          Navigator.of(context).pushNamedAndRemoveUntil(
              MainScreen.routeName, (route) => false,
              arguments:
                  helpers.ScreenArguments(mainScreenTab: MainScreenTab.home));
        } else {
          errorDialog(
              context: context,
              title: 'Registration Failed!',
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
              title: 'Registration Success!',
              titleFontSize: 18,
              description:
                  'Please check your email to verify, or you can click the button to go to our page.',
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
              title: 'Registration Failed!',
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

  Future signupWithGoogle(BuildContext context, ScreenSize screenSize) async {
    assert(context != null);
    _authProvider.setIsRegister(true);

    setToBusy();

    await _authProvider.googleSignin();

    switch (screenSize) {
      case ScreenSize.mini:
        if (_authProvider.authStatus == helpers.AuthResultStatus.successful) {
          await successDialog(
              context: context,
              barrierDismissible: false,
              iconSize: 72,
              title: 'Registration Success!',
              titleFontSize: 12,
              description:
                  'Please check your email to verify, or you can click the button to go to our page.',
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
              title: 'Registration Failed!',
              titleFontSize: 12,
              description:
                  helpers.AuthExceptionHandler.generateExceptionMessage(
                      _authProvider.authStatus),
              descriptionFontSize: 12,
              buttonText: 'Okay',
              buttonFontSize: 12,
              sizedBox1: 15,
              sizedBox2: 5,
              sizedBox3: 20);
        }
        break;
      case ScreenSize.phone:
        if (_authProvider.authStatus == helpers.AuthResultStatus.successful) {
          await successDialog(
              context: context,
              barrierDismissible: false,
              title: 'Registration Success!',
              description:
                  'Please check your email to verify, or you can click the button to go to our page.',
              buttonText: 'Okay');

          Navigator.of(context).pushNamedAndRemoveUntil(
              MainScreen.routeName, (route) => false,
              arguments:
                  helpers.ScreenArguments(mainScreenTab: MainScreenTab.home));
        } else {
          errorDialog(
              context: context,
              title: 'Registration Failed!',
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
              title: 'Registration Success!',
              titleFontSize: 18,
              description:
                  'Please check your email to verify, or you can click the button to go to our page.',
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
              title: 'Registration Failed!',
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
}

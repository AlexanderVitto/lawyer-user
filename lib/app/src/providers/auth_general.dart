import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/config.dart' as config;
import '../../helpers/helpers.dart' as helpers;
import '../../utils/utils.dart' as utils;

class AuthGeneral with ChangeNotifier {
  static const fileName = 'lib/app/src/providers/auth_general.dart';

  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  GoogleSignIn _google;
  GoogleSignInAuthentication _googleSignInAuthentication;
  SharedPreferences _sharedPreferences;
  AuthCredential _googlCredential;
  UserCredential _userCredential;
  PhoneAuthCredential _phoneAuthCredential;

  utils.LogUtils _log;
  helpers.AuthResultStatus _responseStatus;
  helpers.AuthResultStatus get responseStatus => _responseStatus;

  bool _isAuth;
  bool get isAuth => _isAuth;

  int _resendToken;

  String _callingCode;
  String get callingCode => _callingCode;
  String _userId;
  String get userId => _userId;
  String _verificationId;
  String get verificationId => _verificationId;
  String _email;
  String _password;
  String _name;
  String _mobileNumber;

  AuthGeneral(SharedPreferences sharedPreferences) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._google = GoogleSignIn();
    this._sharedPreferences = sharedPreferences;
    this._isAuth = false;
    this._userId = '';
    this._verificationId = '';
    this._callingCode = '62';
  }

  setCallingCode(String data) {
    _callingCode = data;

    notifyListeners();
  }

  setVerificationId(String data) {
    _verificationId = data;

    notifyListeners();
  }

  setSignUpModel(
      String name, String email, String mobileNumber, String password) {
    _name = name;
    _email = email;
    _mobileNumber = mobileNumber;
    _password = password;

    notifyListeners();
  }

  Future signInWithEmail(String email, String password) async {
    final String method = 'signInWithEmail';

    try {
      _userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (_userCredential.user != null) {
        _userId = _userCredential.user.uid;

        _responseStatus = helpers.AuthResultStatus.successful;
      } else {
        _responseStatus = helpers.AuthResultStatus.firebaseUserNull;
      }
    } catch (error) {
      _log.error(method: method, message: error.toString());

      _responseStatus = helpers.AuthExceptionHandler.handleException(error);
    }
  }

  Future signInWithMobileNumber(String smsCode) async {
    final method = 'signInWithMobileNumber';
    _log.info(method: method, message: smsCode);

    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: smsCode);

      _userCredential = await _firebaseAuth.signInWithCredential(credential);

      if (_userCredential.user != null) {
        _userId = _userCredential.user.uid;

        _responseStatus = helpers.AuthResultStatus.successful;
      } else {
        _responseStatus = helpers.AuthResultStatus.firebaseUserNull;
      }
    } catch (error) {
      _log.error(method: method, message: error.toString());

      _responseStatus = helpers.AuthExceptionHandler.handleException(error);
    }
  }

  Future signInWithCredential() async {
    final String method = 'signInWithCredential';
    try {
      _userCredential =
          await _firebaseAuth.signInWithCredential(_googlCredential);

      if (_userCredential.user != null) {
        _userId = _userCredential.user.uid;

        _responseStatus = helpers.AuthResultStatus.successful;
      } else {
        _responseStatus = helpers.AuthResultStatus.firebaseUserNull;
      }
    } catch (error) {
      _log.error(method: method, message: error.toString());

      _responseStatus = helpers.AuthExceptionHandler.handleException(error);
    }
    _log.info(method: method, message: _responseStatus.toString());
  }

  Future signInWithGoogle() async {
    final String method = 'signInWithGoogle';

    try {
      final GoogleSignInAccount googleSignin = await _google.signIn();

      if (googleSignin == null) {
        _responseStatus = helpers.AuthResultStatus.kSignInCanceledError;
      } else {
        // TODO: check email sudah ada apa belum di DB

        _googleSignInAuthentication = await googleSignin.authentication;

        _googlCredential = GoogleAuthProvider.credential(
            idToken: _googleSignInAuthentication.idToken,
            accessToken: _googleSignInAuthentication.accessToken);

        _responseStatus = helpers.AuthResultStatus.successful;
      }
    } catch (error) {
      _log.error(method: method, message: error.toString());

      if (error.code != null) {
        _responseStatus = helpers.AuthExceptionHandler.handleException(error);
      } else {
        await _google.signOut();
        _responseStatus = helpers.AuthExceptionHandler.googleException(error);
      }
    }
    _log.info(method: method, message: _responseStatus.toString());
  }

  Future signUpWithGoogle() async {
    final String method = 'signUpWithGoogle';

    try {
      final GoogleSignInAccount googleSignin = await _google.signIn();

      if (googleSignin == null) {
        _responseStatus = helpers.AuthResultStatus.kSignInCanceledError;
      } else {
        await _firebaseAuth.createUserWithEmailAndPassword(
            email: googleSignin.email, password: '123456');

        _googleSignInAuthentication = await googleSignin.authentication;

        _googlCredential = GoogleAuthProvider.credential(
            idToken: _googleSignInAuthentication.idToken,
            accessToken: _googleSignInAuthentication.accessToken);

        _responseStatus = helpers.AuthResultStatus.successful;
      }
    } catch (error) {
      _log.error(method: method, message: error.toString());

      if (error.code != null) {
        _responseStatus = helpers.AuthExceptionHandler.handleException(error);
      } else {
        await _google.signOut();
        _responseStatus = helpers.AuthExceptionHandler.googleException(error);
      }
    }
    _log.info(method: method, message: _responseStatus.toString());
  }

  Future linkEmailAndPhone(String smsCode) async {
    final String method = 'linkEmailAndPhone';
    _log.info(method: method, message: smsCode);

    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: smsCode);

      _userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: _email, password: _password);

      if (_userCredential.user != null) {
        _userCredential =
            await _userCredential.user.linkWithCredential(credential);

        _userId = _userCredential.user.uid;

        _responseStatus = helpers.AuthResultStatus.successful;
      } else {
        _responseStatus = helpers.AuthResultStatus.firebaseUserNull;
      }
    } catch (error) {
      _log.error(method: method, message: error.toString());

      _responseStatus = helpers.AuthExceptionHandler.handleException(error);
    }
  }

  Future linkGoogleAndPhone(String smsCode) async {
    final String method = 'linkGoogleAndPhone';
    _log.info(method: method, message: smsCode);

    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: smsCode);

      _userCredential =
          await _firebaseAuth.signInWithCredential(_googlCredential);

      if (_userCredential.user != null) {
        _userCredential =
            await _userCredential.user.linkWithCredential(credential);

        _userId = _userCredential.user.uid;

        _responseStatus = helpers.AuthResultStatus.successful;
      } else {
        _responseStatus = helpers.AuthResultStatus.firebaseUserNull;
      }
    } catch (error) {
      _log.error(method: method, message: error.toString());

      _responseStatus = helpers.AuthExceptionHandler.handleException(error);
    }
  }

  Future resetPassword(String email) async {
    final String method = 'resetPassword';

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      _responseStatus = helpers.AuthResultStatus.successful;
    } catch (error) {
      _log.error(method: method, message: error.toString());

      _responseStatus = helpers.AuthExceptionHandler.handleException(error);
    }
  }

  Future sendOTP([bool resend]) async {
    final String method = 'sendOTP';

    String mobileNumberWithCallingCode =
        '+$_callingCode${_mobileNumber.substring(1)}';

    // Callback
    final PhoneVerificationCompleted verified =
        (PhoneAuthCredential authResult) async {
      _log.debug(
          method: method,
          message: 'Verified ${jsonEncode(authResult.asMap())}');

      _phoneAuthCredential = authResult;

      _responseStatus = helpers.AuthResultStatus.phoneVerified;

      notifyListeners();
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      _log.error(
          method: method,
          message: 'Verification Failed ${authException.message}');

      _responseStatus =
          helpers.AuthExceptionHandler.handleException(authException);
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      _log.debug(
          method: method,
          message: 'Sms sent verification id $verId forceResend $forceResend');

      _verificationId = verId;
      _resendToken = forceResend;

      _responseStatus = helpers.AuthResultStatus.smsSent;
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      _log.debug(method: method, message: 'Timeout verification id $verId');

      _verificationId = verId;
      print(_verificationId);
    };

    try {
      if (resend) {
        await _firebaseAuth.verifyPhoneNumber(
            phoneNumber: mobileNumberWithCallingCode,
            timeout: const Duration(seconds: 60),
            verificationCompleted: verified,
            verificationFailed: verificationFailed,
            forceResendingToken: _resendToken,
            codeSent: smsSent,
            codeAutoRetrievalTimeout: autoTimeout);
      } else {
        await _firebaseAuth.verifyPhoneNumber(
            phoneNumber: mobileNumberWithCallingCode,
            timeout: const Duration(seconds: 60),
            verificationCompleted: verified,
            verificationFailed: verificationFailed,
            codeSent: smsSent,
            codeAutoRetrievalTimeout: autoTimeout);
      }
    } catch (error) {
      _log.error(method: method, message: error.toString());

      _responseStatus = helpers.AuthExceptionHandler.handleException(error);
    }

    notifyListeners();
  }
}

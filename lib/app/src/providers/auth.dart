import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/config.dart' as config;
import '../../helpers/helpers.dart' as helpers;
import '../../utils/utils.dart' as utils;
import '../../services/application.dart' as application;
import '../../services/identity.dart' as identity;
import '../../services/user_profile.dart' as userProfile;
import '../models/models.dart' as models;

class LoginMethod {
  static const String EMAIL = 'EMAIL';
  static const String FACEBOOK = 'FACEBOOK';
  static const String GOOGLE = 'GOOGLE';
  static const String MOBILENUMBER = 'MOBILENUMBER';
}

class Auth with ChangeNotifier {
  static const fileName = 'lib/app/src/providers/auth.dart';

  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /*
  user signin_with_apple for ios
  facebook login only provide in android platform for now
  */
  FacebookLogin _facebook;
  GoogleSignIn _google;
  SharedPreferences _sharedPreferences;
  User _firebaseUser;

  utils.Connection _connection;
  utils.LogUtils _log;

  application.ApplicationAPI _applicationAPI;
  identity.IdentityAPI _identityAPI;
  userProfile.UserProfileAPI _userProfileAPI;

  helpers.AuthResultStatus _authStatus;
  helpers.AuthResultStatus get authStatus => _authStatus;

  models.User _userData;
  models.User get userData => _userData;

  bool _isRegister;
  bool get isRegister => _isRegister;
  String _deviceToken;
  String get deviceToken => _deviceToken;
  String _firstName;
  String get firstName => _firstName;
  String _lastName;
  String get lastName => _lastName;
  String _loginMethod;
  String get loginMethod => _loginMethod;

  String _callingCode;
  String get callingCode => _callingCode;
  String _mobileNumber;
  String get mobileNumber => _mobileNumber;
  String _token;
  String get token => _token;
  String _userId;
  String get userId => _userId;
  String _verificationId;
  String get verificationId => _verificationId;
  int _resendToken;

  setFirstName(String data) {
    this._firstName = data;

    notifyListeners();
  }

  setIsRegister(bool data) {
    this._isRegister = data;

    notifyListeners();
  }

  setLastName(String data) {
    this._lastName = data;

    notifyListeners();
  }

  setCallingCode(String data) {
    this._callingCode = data;

    notifyListeners();
  }

  setMobileNumber(String data) {
    this._mobileNumber = data;

    notifyListeners();
  }

  setVerificationId(String data) {
    this._verificationId = data;

    notifyListeners();
  }

  Auth(utils.Connection connection) {
    this._facebook = FacebookLogin();
    this._google = GoogleSignIn();
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._applicationAPI = config.locator<application.ApplicationAPI>();
    this._identityAPI = config.locator<identity.IdentityAPI>();
    this._userProfileAPI = config.locator<userProfile.UserProfileAPI>();

    this._connection = connection;
  }

  update(utils.Connection connection) {
    this._connection = connection;

    notifyListeners();
  }

  Future emailSignin(String email, String password) async {
    assert(email != null && password != null);
    final String method = 'emailSignin';
    _loginMethod = LoginMethod.EMAIL;

    await _connection.check();

    if (_connection.isConnected) {
      try {
        _firebaseUser = (await _firebaseAuth.signInWithEmailAndPassword(
                email: email, password: password))
            .user;

        _userId = _firebaseUser.uid;

        if (_firebaseUser != null) {
          await _authentication();
        } else {
          _authStatus = helpers.AuthResultStatus.firebaseUserNull;
        }
      } catch (error) {
        _log.error(method: method, message: error.toString());

        _authStatus = helpers.AuthExceptionHandler.handleException(error);
      }

      notifyListeners();
    }
  }

  Future emailSignup(String email, String name, password) async {
    assert(email != null && name != null && password != null);
    final String method = 'emailSignup';
    _loginMethod = LoginMethod.EMAIL;

    await _connection.check();

    if (_connection.isConnected) {
      utils.ApiReturn<models.StringResponse> apiRequest =
          await _userProfileAPI.checkEmail(email, _token);

      if (!apiRequest.status) {
        // Problem with connection to API

        if (apiRequest.value.code == '401') {
          // Force logout

        }

        _authStatus = helpers.AuthResultStatus.apiConnectionError;
      } else {
        if (apiRequest.value.status) {
          _authStatus = helpers.AuthResultStatus.emailAlreadyExists;
        } else {
          try {
            _firebaseUser = (await _firebaseAuth.createUserWithEmailAndPassword(
                    email: email, password: password))
                .user;

            _userId = _firebaseUser.uid;

            if (_firebaseUser != null) {
              final futures = <Future>[
                _firebaseUser.sendEmailVerification(),
                _firebaseUser.getIdToken().then((token) => _token = token)
              ];

              await Future.wait(futures);

              models.User userModel =
                  models.User(id: userId, email: email, firstName: name);
              await _createUserData(userModel);
            } else {
              _authStatus = helpers.AuthResultStatus.firebaseUserNull;
            }
          } catch (error) {
            _log.error(method: method, message: error.toString());

            _authStatus = helpers.AuthExceptionHandler.handleException(error);
          }
        }
      }
    }
  }

  Future signinWithMobileNumber(String smsCode) async {
    assert(_verificationId != null &&
        smsCode != null &&
        _callingCode != null &&
        _mobileNumber != null &&
        _isRegister != null);

    final method = 'signinWithMobileNumber';
    _loginMethod = LoginMethod.MOBILENUMBER;

    await _connection.check();

    if (_connection.isConnected) {
      try {
        final AuthCredential credential = PhoneAuthProvider.credential(
            verificationId: _verificationId, smsCode: smsCode);

        _firebaseUser =
            (await _firebaseAuth.signInWithCredential(credential)).user;

        if (_firebaseUser != null) {
          await _authentication();
        } else {
          _authStatus = helpers.AuthResultStatus.firebaseUserNull;
        }
      } catch (error) {
        _log.error(method: method, message: error.toString());

        _authStatus =
            helpers.AuthExceptionHandler.generateExceptionMessage(error);
      }

      notifyListeners();
    }
  }

  Future facebookSignIn() async {
    assert(_isRegister != null);
    final String method = 'facebookSignIn';
    _loginMethod = LoginMethod.FACEBOOK;

    await _connection.check();

    if (_connection.isConnected) {
      try {
        _log.info(method: method, message: 'start');

        final facebookSignin = await _facebook.logIn(['email']);

        _log.debug(
            method: method, message: 'result status ${facebookSignin.status}');

        switch (facebookSignin.status) {
          case FacebookLoginStatus.loggedIn:
            final token = facebookSignin.accessToken.token;
            AuthCredential authCredential =
                FacebookAuthProvider.credential(token);
            _firebaseUser =
                (await _firebaseAuth.signInWithCredential(authCredential)).user;

            _userId = _firebaseUser.uid;

            if (_firebaseUser != null) {
              await _authentication();
            } else {
              _authStatus = helpers.AuthResultStatus.firebaseUserNull;
            }

            break;
          case FacebookLoginStatus.cancelledByUser:
            await _facebook.logOut();
            _authStatus = helpers.AuthResultStatus.cancelledByUser;
            break;
          case FacebookLoginStatus.error:
            _authStatus = helpers.AuthResultStatus.facebookConnectionError;
            await _facebook.logOut();
            break;
        }
      } catch (error) {
        _log.error(method: method, message: error.toString());

        await _facebook.logOut();
        _authStatus = helpers.AuthExceptionHandler.handleException(error);
      }

      _log.info(method: method, message: 'Login success');

      notifyListeners();
    }
  }

  Future googleSignin() async {
    assert(_isRegister != null);
    final String method = 'googleSignin';
    _loginMethod = LoginMethod.GOOGLE;

    await _connection.check();

    if (_connection.isConnected) {
      try {
        _log.info(method: method, message: 'start');

        final GoogleSignInAccount googleSignin = await _google.signIn();

        if (googleSignin == null) {
          _authStatus = helpers.AuthResultStatus.kSignInCanceledError;
        } else {
          final GoogleSignInAuthentication googleAuth =
              await googleSignin.authentication;

          _log.debug(
              method: method,
              message: 'googleAuth idToken  ${googleAuth.idToken}');
          _log.debug(
              method: method,
              message: 'googleAuth accessToken ${googleAuth.accessToken}');

          final AuthCredential authCredential = GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

          _firebaseUser =
              (await _firebaseAuth.signInWithCredential(authCredential)).user;

          _userId = _firebaseUser.uid;

          if (_firebaseUser != null) {
            await _authentication();
          } else {
            _authStatus = helpers.AuthResultStatus.firebaseUserNull;
          }
        }
      } catch (error) {
        _log.error(method: method, message: error.toString());

        await _google.signOut();
        _authStatus = helpers.AuthExceptionHandler.googleException(error);
      }

      _log.info(method: method, message: 'Login success');

      notifyListeners();
    }
  }

  Future mobilePhoneSignin(
      String verificationId, String smsCode, String mobileNumber) async {
    assert(verificationId != null &&
        smsCode != null &&
        mobileNumber != null &&
        _isRegister != null);
    final String method = 'mobilePhoneSignin';
    _loginMethod = LoginMethod.MOBILENUMBER;

    await _connection.check();

    if (_connection.isConnected) {
      try {
        final AuthCredential authCredential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        _firebaseUser =
            (await _firebaseAuth.signInWithCredential(authCredential)).user;

        _userId = _firebaseUser.uid;

        if (_firebaseUser != null) {
          await _authentication();
        } else {
          _authStatus = helpers.AuthResultStatus.firebaseUserNull;
        }
      } catch (error) {
        _log.error(method: method, message: error.toString());

        _authStatus = helpers.AuthExceptionHandler.handleException(error);
      }

      notifyListeners();
    }
  }

  Future resetPassword(String email) async {
    final String method = 'resetPassword';

    await _connection.check();

    if (_connection.isConnected) {
      try {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
        _authStatus = helpers.AuthResultStatus.successful;
      } catch (error) {
        _log.error(method: method, message: error.toString());

        _authStatus = helpers.AuthExceptionHandler.handleException(error);
      }

      notifyListeners();
    }
  }

  Future checkMobileNumber(String number) async {
    final String method = 'checkMobileNumber';

    await _connection.check();

    if (_connection.isConnected) {
      try {
        utils.ApiReturn<models.StringResponse> apiRequest =
            await _userProfileAPI.checkMobileNumber(number, _token);

        if (!apiRequest.status) {
          // Problem with connection to API

          if (apiRequest.value.code == '401') {
            // Force logout

          }

          _authStatus = helpers.AuthResultStatus.apiConnectionError;
        } else {
          if (apiRequest.value.status) {
            _authStatus = helpers.AuthResultStatus.mobileNumberAlreadyExists;
          } else {
            _authStatus = helpers.AuthResultStatus.mobileNumberNotRegistered;
          }
        }
      } catch (error) {
        _log.error(method: method, message: error.toString());

        _authStatus = helpers.AuthExceptionHandler.handleException(error);
      }

      notifyListeners();
    }
  }

  Future sendOTP(bool resend) async {
    assert(_callingCode != null && _mobileNumber != null && resend != null);
    final String method = 'sendOTP';

    String phoneNumber = '+$_callingCode$_mobileNumber';

    // Callback
    final PhoneVerificationCompleted verified =
        (PhoneAuthCredential authResult) async {
      _log.debug(
          method: method,
          message: 'Verified ${jsonEncode(authResult.asMap())}');

      _authStatus = helpers.AuthResultStatus.phoneVerified;
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      _log.error(
          method: method,
          message: 'Verification Failed ${authException.message}');

      _authStatus =
          helpers.AuthExceptionHandler.generateExceptionMessage(authException);
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      _log.debug(
          method: method,
          message: 'Sms sent verification id $verId forceResend $forceResend');

      _verificationId = verId;
      _resendToken = forceResend;
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      _log.debug(method: method, message: 'Timeout verification id $verId');

      _verificationId = verId;
      print(_verificationId);
    };

    try {
      if (resend) {
        await _firebaseAuth.verifyPhoneNumber(
            phoneNumber: phoneNumber,
            timeout: const Duration(seconds: 60),
            verificationCompleted: verified,
            verificationFailed: verificationFailed,
            forceResendingToken: _resendToken,
            codeSent: smsSent,
            codeAutoRetrievalTimeout: autoTimeout);
      } else {
        await _firebaseAuth.verifyPhoneNumber(
            phoneNumber: phoneNumber,
            timeout: const Duration(seconds: 60),
            verificationCompleted: verified,
            verificationFailed: verificationFailed,
            codeSent: smsSent,
            codeAutoRetrievalTimeout: autoTimeout);
      }
    } catch (error) {
      _log.error(method: method, message: error.toString());

      _authStatus = helpers.AuthExceptionHandler.handleException(error);
    }

    notifyListeners();
  }

  Future _authentication() async {
    final String method = '_authentication';

    Map<String, dynamic> deviceData;
    models.ApplicationBody applicationBody;

    final futures = <Future>[
      _firebaseUser.getIdToken().then((token) => _token = token),
      FirebaseMessaging.instance
          .getToken()
          .then((deviceToken) => _deviceToken = deviceToken)
    ];

    await Future.wait(futures);

    // Only for signin/singup
    if (_loginMethod == LoginMethod.GOOGLE ||
        _loginMethod == LoginMethod.FACEBOOK) {
      await _generateUserData();
    } else if (_isRegister && _loginMethod == LoginMethod.MOBILENUMBER) {
      await _generateUserDataFromMobileNumber();
    }

    final userSession = jsonEncode({
      'token': _token,
      'userId': _userId,
      'method': _loginMethod,
    });

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await _deviceInfoPlugin.androidInfo);
        applicationBody = models.ApplicationBody(
            firebaseId: _userId,
            deviceToken: _deviceToken,
            deviceOs: 'Android',
            deviceModel: deviceData['build.model'],
            osVersion: deviceData['version.release'],
            deviceManufacturer: deviceData['manufacturer'],
            deviceType: deviceData['type'],
            isPhysicalDevice: deviceData['isPhysicalDevice']);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await _deviceInfoPlugin.iosInfo);
        // Create applicationBody for ios

      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    final future2 = <Future>[
      _applicationAPI.registerDevice(applicationBody, _token),
      _getUserData()
      // Get general token twilio [later]
    ];

    await Future.wait(future2);

    if (_authStatus == helpers.AuthResultStatus.successful) {
      // Login success, and then store user session to shared preferences
      _sharedPreferences.setString('userSession', userSession);

      /*
      Create chatBloc object [later]

      Create channel object [later]

      updateUser
      */

    }
  }

  Future _getUserData() async {
    final String method = '_fetchUserData';

    if (_sharedPreferences == null)
      _sharedPreferences = await SharedPreferences.getInstance();

    utils.ApiReturn<models.UserResponse> apiRequest =
        await _userProfileAPI.getUserProfile(_userId, _token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Force logout

      }

      _authStatus = helpers.AuthResultStatus.apiConnectionError;
    } else {
      if (apiRequest.value.status) {
        _userData = apiRequest.value.result;
        _authStatus = helpers.AuthResultStatus.successful;

        // Store userData to shared preferences
        _sharedPreferences.setString('userData', jsonEncode(_userData));
      } else {
        _authStatus = helpers.AuthResultStatus.userNotFound;
      }
    }
  }

  Future _generateUserData() async {
    final String method = '_generateUserData';
    try {
      final response = await http.post(
          config.FlavorConfig.instance.values.googleApiUrl,
          body: jsonEncode({'idToken': _token}));

      final responseData = jsonDecode(response.body);
      if (responseData['error'] != null) {
        throw helpers.HttpException(responseData['error']['message']);
      }

      final email = responseData['users'][0]['email'];
      final name = responseData['users'][0]['displayName'];
      final photoUrl = responseData['users'][0]['photoUrl'];

      // Check email in database
      utils.ApiReturn<models.StringResponse> apiRequest =
          await _userProfileAPI.checkEmail(email, _token);

      if (!apiRequest.status) {
        // Problem with connection to API

        if (apiRequest.value.code == '401') {
          // Force logout

        }

        _authStatus = helpers.AuthResultStatus.apiConnectionError;
      } else {
        if (apiRequest.value.status) {
          _authStatus = helpers.AuthResultStatus.emailAlreadyExists;
        } else {
          models.User userModel = models.User(
              id: userId, email: email, firstName: name, pictureUrl: photoUrl);

          await _createUserData(userModel);
        }
      }
    } catch (error) {
      _log.error(method: method, message: error.toString());

      _authStatus = helpers.AuthExceptionHandler.handleException(error);
    }
  }

  Future _generateUserDataFromMobileNumber() async {
    final String method = '_generateUserDataFromMobileNumber';

    models.User userModel = models.User(
        id: _userId,
        mobileNumber: mobileNumber,
        firstName: _firstName ?? 'New User',
        lastName: _lastName);

    await _createUserData(userModel);
  }

  Future _createUserData(models.User data) async {
    final String method = '_createUserData';

    utils.ApiReturn<models.UserResponse> apiRequest =
        await _userProfileAPI.create2(data, _token);

    if (!apiRequest.status) {
      // Problem with connection to API

      if (apiRequest.value.code == '401') {
        // Force logout

      }

      _authStatus = helpers.AuthResultStatus.apiConnectionError;
    } else {
      _authStatus = helpers.AuthResultStatus.successful;
    }
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}

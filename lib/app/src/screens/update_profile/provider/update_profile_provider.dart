import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../config/config.dart' as config;
import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;

import '../../../models/models.dart' as models;
import '../../../providers/providers.dart' as providers;

import '../../shared/shared.dart';

class UpdateProfileProvider with ChangeNotifier {
  static const fileName =
      'lib/app/src/screens/update_profile/provider/update_profile_provider.dart';

  TextEditingController _firstNameController;
  TextEditingController get firstNameController => _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController _salutationController;
  TextEditingController get salutationController => _salutationController;
  TextEditingController _idCardNumberController;
  TextEditingController get idCardNumberController => _idCardNumberController;
  TextEditingController _phoneNumberController;
  TextEditingController get phoneNumberController => _phoneNumberController;
  TextEditingController _mobileNumberController;
  TextEditingController get mobileNumberController => _mobileNumberController;
  TextEditingController _addressController;
  TextEditingController get addressController => _addressController;
  TextEditingController _zipCodeController;
  TextEditingController get zipCodeController => _zipCodeController;
  TextEditingController _countryController;
  TextEditingController get countryController => _countryController;
  TextEditingController _region1Controller;
  TextEditingController get region1Controller => _region1Controller;
  TextEditingController _region2Controller;
  TextEditingController get region2Controller => _region2Controller;
  TextEditingController _region3Controller;
  TextEditingController get region3Controller => _region3Controller;
  TextEditingController _region4Controller;
  TextEditingController get region4Controller => _region4Controller;
  TextEditingController _ethnicController;
  TextEditingController get ethnicController => _ethnicController;

  utils.LogUtils _log;

  providers.Auth _authProvider;
  providers.Auth get auth => _authProvider;
  providers.StaticData _staticDataProvider;
  providers.StaticData get staticData => _staticDataProvider;

  models.User _userData;
  models.User get userData => _userData;

  models.StaticData _maritalStatus;
  models.StaticData get maritalStatus => _maritalStatus;
  models.StaticData _genderStatus;
  models.StaticData get genderStatus => _genderStatus;
  models.StaticData _idCardType;
  models.StaticData get idCardType => _idCardType;
  models.StaticData _religion;
  models.StaticData get religion => _religion;
  models.StaticData _occupation;
  models.StaticData get occupation => _occupation;
  models.StaticData _lastEducation;
  models.StaticData get lastEducation => _lastEducation;

  bool _isBusy;
  bool get isBusy => _isBusy;

  bool _isFirstNameControllerEmpty;
  bool get isFirstNameControllerEmpty => _isFirstNameControllerEmpty;
  bool _isLastNameControllerEmpty;
  bool get isLastNameControllerEmpty => _isLastNameControllerEmpty;
  bool _isSalutationControllerEmpty;
  bool get isSalutationControllerEmpty => _isSalutationControllerEmpty;
  bool _isIdCardNumberControllerEmpty;
  bool get isIdCardNumberControllerEmpty => _isIdCardNumberControllerEmpty;
  bool _isPhoneNumberControllerEmpty;
  bool get isPhoneNumberControllerEmpty => _isPhoneNumberControllerEmpty;
  bool _isMobileNumberControllerEmpty;
  bool get isMobileNumberControllerEmpty => _isMobileNumberControllerEmpty;
  bool _isAddressControllerEmpty;
  bool get isAddressControllerEmpty => _isAddressControllerEmpty;
  bool _isZipCodeControllerEmpty;
  bool get isZipCodeControllerEmpty => _isZipCodeControllerEmpty;
  bool _isCountryControllerEmpty;
  bool get isCountryControllerEmpty => _isCountryControllerEmpty;
  bool _isRegion1ControllerEmpty;
  bool get isRegion1ControllerEmpty => _isRegion1ControllerEmpty;
  bool _isRegion2ControllerEmpty;
  bool get isRegion2ControllerEmpty => _isRegion2ControllerEmpty;
  bool _isRegion3ControllerEmpty;
  bool get isRegion3ControllerEmpty => _isRegion3ControllerEmpty;
  bool _isRegion4ControllerEmpty;
  bool get isRegion4ControllerEmpty => _isRegion4ControllerEmpty;
  bool _isEthnicControllerEmpty;
  bool get isEthnicControllerEmpty => _isEthnicControllerEmpty;

  String _dateOfBirth;
  String get dateOfBirth => _dateOfBirth;

  UpdateProfileProvider(providers.Auth auth, providers.StaticData staticData) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);
    this._authProvider = auth;
    this._staticDataProvider = staticData;
  }

  update(providers.Auth auth, providers.StaticData staticData) {
    this._authProvider = auth;
    this._staticDataProvider = staticData;

    notifyListeners();
  }

  initResource() {
    this._isBusy = false;
    this._maritalStatus = _staticDataProvider
        .getMaritalStatus(_authProvider.userData.maritalStatusId);
    this._genderStatus =
        _staticDataProvider.getGenderStatus(_authProvider.userData.sexId);
    this._idCardType =
        _staticDataProvider.getCardTypeById(_authProvider.userData.idType);
    this._religion =
        _staticDataProvider.getReligionById(_authProvider.userData.religionId);
    this._occupation = _staticDataProvider
        .getOccupationById(_authProvider.userData.occupation);
    this._lastEducation = _staticDataProvider
        .getLastEducationById(_authProvider.userData.lastEducation);

    this._dateOfBirth = _authProvider.userData.dateOfBirth;

    this._userData = _authProvider.userData;
    this._firstNameController =
        TextEditingController(text: _userData.firstName);
    this._lastNameController = TextEditingController(text: _userData.lastName);
    this._salutationController =
        TextEditingController(text: _userData.salutation);
    this._idCardNumberController =
        TextEditingController(text: _userData.idNumber);
    this._phoneNumberController =
        TextEditingController(text: _userData.phoneNumber);
    this._mobileNumberController =
        TextEditingController(text: _userData.mobileNumber);
    this._addressController = TextEditingController(text: _userData.address);
    this._zipCodeController = TextEditingController(text: _userData.zipCode);
    this._countryController = TextEditingController(text: _userData.country);
    this._region1Controller = TextEditingController(text: _userData.region1);
    this._region2Controller = TextEditingController(text: _userData.region2);
    this._region3Controller = TextEditingController(text: _userData.region3);
    this._region4Controller = TextEditingController(text: _userData.region4);
    this._ethnicController = TextEditingController(text: _userData.ethnic);

    this._isFirstNameControllerEmpty = _userData.firstName == null;
    this._isLastNameControllerEmpty = _userData.lastName == null;
    this._isSalutationControllerEmpty = _userData.salutation == null;
    this._isIdCardNumberControllerEmpty = _userData.idNumber == null;
    this._isPhoneNumberControllerEmpty = _userData.phoneNumber == null;
    this._isMobileNumberControllerEmpty = _userData.mobileNumber == null;
    this._isAddressControllerEmpty = _userData.address == null;
    this._isZipCodeControllerEmpty = _userData.zipCode == null;
    this._isCountryControllerEmpty = _userData.country == null;
    this._isRegion1ControllerEmpty = _userData.region1 == null;
    this._isRegion2ControllerEmpty = _userData.region2 == null;
    this._isRegion3ControllerEmpty = _userData.region3 == null;
    this._isRegion4ControllerEmpty = _userData.region4 == null;
    this._isEthnicControllerEmpty = _userData.ethnic == null;
  }

  setToBusy() {
    _isBusy = true;

    notifyListeners();
  }

  setToIdle() {
    _isBusy = false;

    notifyListeners();
  }

  selectMaritalStatus(models.StaticData data) {
    if (_maritalStatus != null) {
      _maritalStatus.isSelected = false;
    }

    data.isSelected = true;

    _maritalStatus = data;

    notifyListeners();
  }

  selectGenderStatus(models.StaticData data) {
    if (_genderStatus != null) {
      _genderStatus.isSelected = false;
    }

    data.isSelected = true;

    _genderStatus = data;

    notifyListeners();
  }

  selectIdCardType(models.StaticData data) {
    if (_genderStatus != null) {
      _idCardType.isSelected = false;
    }

    data.isSelected = true;

    _idCardType = data;

    notifyListeners();
  }

  selectReligion(models.StaticData data) {
    if (_genderStatus != null) {
      _religion.isSelected = false;
    }

    data.isSelected = true;

    _religion = data;

    notifyListeners();
  }

  selectOccupation(models.StaticData data) {
    if (_genderStatus != null) {
      _occupation.isSelected = false;
    }

    data.isSelected = true;

    _occupation = data;

    notifyListeners();
  }

  selectLastEducation(models.StaticData data) {
    if (_genderStatus != null) {
      _lastEducation.isSelected = false;
    }

    data.isSelected = true;

    _lastEducation = data;

    notifyListeners();
  }

  firstNameOnChange(String text) {
    if (text.length < 1) {
      _isFirstNameControllerEmpty = true;
    } else {
      _isFirstNameControllerEmpty = false;
    }

    notifyListeners();
  }

  lastNameOnChange(String text) {
    if (text.length < 1) {
      _isLastNameControllerEmpty = true;
    } else {
      _isLastNameControllerEmpty = false;
    }

    notifyListeners();
  }

  salutationOnChange(String text) {
    if (text.length < 1) {
      _isSalutationControllerEmpty = true;
    } else {
      _isSalutationControllerEmpty = false;
    }

    notifyListeners();
  }

  idCardNumberOnChange(String text) {
    if (text.length < 1) {
      _isIdCardNumberControllerEmpty = true;
    } else {
      _isIdCardNumberControllerEmpty = false;
    }

    notifyListeners();
  }

  phoneNumberOnChange(String text) {
    if (text.length < 1) {
      _isPhoneNumberControllerEmpty = true;
    } else {
      _isPhoneNumberControllerEmpty = false;
    }

    notifyListeners();
  }

  mobileNumberOnChange(String text) {
    if (text.length < 1) {
      _isMobileNumberControllerEmpty = true;
    } else {
      _isMobileNumberControllerEmpty = false;
    }

    notifyListeners();
  }

  addressOnChange(String text) {
    if (text.length < 1) {
      _isAddressControllerEmpty = true;
    } else {
      _isAddressControllerEmpty = false;
    }

    notifyListeners();
  }

  zipCodeOnChange(String text) {
    if (text.length < 1) {
      _isZipCodeControllerEmpty = true;
    } else {
      _isZipCodeControllerEmpty = false;
    }

    notifyListeners();
  }

  countryOnChange(String text) {
    if (text.length < 1) {
      _isCountryControllerEmpty = true;
    } else {
      _isCountryControllerEmpty = false;
    }

    notifyListeners();
  }

  region1OnChange(String text) {
    if (text.length < 1) {
      _isRegion1ControllerEmpty = true;
    } else {
      _isRegion1ControllerEmpty = false;
    }

    notifyListeners();
  }

  region2OnChange(String text) {
    if (text.length < 1) {
      _isRegion2ControllerEmpty = true;
    } else {
      _isRegion2ControllerEmpty = false;
    }

    notifyListeners();
  }

  region3OnChange(String text) {
    if (text.length < 1) {
      _isRegion3ControllerEmpty = true;
    } else {
      _isRegion3ControllerEmpty = false;
    }

    notifyListeners();
  }

  region4OnChange(String text) {
    if (text.length < 1) {
      _isRegion4ControllerEmpty = true;
    } else {
      _isRegion4ControllerEmpty = false;
    }

    notifyListeners();
  }

  ethnicOnChange(String text) {
    if (text.length < 1) {
      _isEthnicControllerEmpty = true;
    } else {
      _isEthnicControllerEmpty = false;
    }

    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime initDate = _dateOfBirth == null
        ? DateTime.now()
        : DateTime.parse(_dateOfBirth.split('T')[0]);

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: initDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.teal,
                primaryColorDark: Colors.teal,
                accentColor: Colors.teal,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        });
    if (picked != null && picked != initDate) {
      _dateOfBirth = DateFormat('yyyy-MM-dd').format(picked);

      notifyListeners();
    }
  }

  Future searchLocation(BuildContext context) async {
    if (!_isZipCodeControllerEmpty) {
      setToBusy();
      Map<String, dynamic> queryParam = {'query': _zipCodeController.text};

      await _staticDataProvider.searchLocation(queryParam);

      if (_staticDataProvider.geoLocationResult ==
          helpers.AuthResultStatus.successful) {
        _countryController.text = _staticDataProvider.location[0].country;
        _region1Controller.text = _staticDataProvider.location[0].region1;
        _region2Controller.text = _staticDataProvider.location[0].region2;
        _region3Controller.text = _staticDataProvider.location[0].region3;
        _region4Controller.text = _staticDataProvider.location[0].region4;

        setToIdle();
      } else {
        setToIdle();
        errorDialog(
            context: context,
            iconSize: 45,
            title: 'Search Location!',
            titleFontSize: 12,
            description: helpers.AuthExceptionHandler.generateExceptionMessage(
                _staticDataProvider.geoLocationResult),
            descriptionFontSize: 10,
            buttonText: 'Okay',
            buttonFontSize: 10,
            sizedBox1: 15,
            sizedBox2: 5,
            sizedBox3: 20);
      }
    }
  }

  Future save(BuildContext context) async {
    if (_isFirstNameControllerEmpty ||
        _isLastNameControllerEmpty ||
        _isSalutationControllerEmpty ||
        _isIdCardNumberControllerEmpty ||
        _isPhoneNumberControllerEmpty ||
        _isMobileNumberControllerEmpty ||
        _isAddressControllerEmpty ||
        _isZipCodeControllerEmpty ||
        _isEthnicControllerEmpty) {
    } else {
      setToBusy();
      _authProvider.userData.firstName = _firstNameController.text;
      _authProvider.userData.lastName = _lastNameController.text;
      _authProvider.userData.salutation = _salutationController.text;
      _authProvider.userData.idNumber = _idCardNumberController.text;
      _authProvider.userData.phoneNumber = _phoneNumberController.text;
      _authProvider.userData.mobileNumber = _mobileNumberController.text;
      _authProvider.userData.address = _addressController.text;
      _authProvider.userData.zipCode = _zipCodeController.text;
      _authProvider.userData.country = _countryController.text;
      _authProvider.userData.region1 = _region1Controller.text;
      _authProvider.userData.region2 = _region2Controller.text;
      _authProvider.userData.region3 = _region3Controller.text;
      _authProvider.userData.region4 = _region4Controller.text;
      _authProvider.userData.ethnic = _ethnicController.text;

      _authProvider.userData.sexId = _genderStatus.id;
      _authProvider.userData.maritalStatusId = _maritalStatus.id;
      _authProvider.userData.religionId = _religion.id;
      _authProvider.userData.idType = _idCardType.id;
      _authProvider.userData.occupation = _occupation.id;
      _authProvider.userData.lastEducation = _lastEducation.id;

      _authProvider.userData.dateOfBirth = _dateOfBirth;

      _log.info(method: 'save', message: jsonEncode(_authProvider.userData));

      await _authProvider.updateProfile();

      setToIdle();
      if (_authProvider.authStatus ==
          helpers.AuthResultStatus.updateProfileSuccess) {
        await successDialog(
            context: context,
            barrierDismissible: false,
            iconSize: 72,
            title: 'Update Profile',
            titleFontSize: 14,
            description: '',
            descriptionFontSize: 12,
            buttonText: 'Okay',
            buttonFontSize: 12,
            sizedBox1: 12,
            sizedBox2: 5,
            sizedBox3: 10);
      } else {
        await errorDialog(
            context: context,
            iconSize: 45,
            title: 'Update Profile Failed!',
            titleFontSize: 12,
            description: helpers.AuthExceptionHandler.generateExceptionMessage(
                _authProvider.authStatus),
            descriptionFontSize: 10,
            buttonText: 'Okay',
            buttonFontSize: 10,
            sizedBox1: 15,
            sizedBox2: 5,
            sizedBox3: 20);
      }
    }
  }

  close() {
    this._firstNameController.dispose();
    this._lastNameController.dispose();
    this._salutationController.dispose();
    this._idCardNumberController.dispose();
    this._phoneNumberController.dispose();
    this._mobileNumberController.dispose();
    this._addressController.dispose();
    this._zipCodeController.dispose();
    this._countryController.dispose();
    this._region1Controller.dispose();
    this._region2Controller.dispose();
    this._region3Controller.dispose();
    this._region4Controller.dispose();
    this._ethnicController.dispose();
  }
}

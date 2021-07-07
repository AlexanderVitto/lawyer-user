import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../config/config.dart' as config;
import '../../../../../helpers/helpers.dart' as helpers;
import '../../../../../utils/utils.dart' as utils;

import '../../../../models/models.dart' as models;
import '../../../../providers/providers.dart' as providers;

import '../../../shared/shared.dart';

class ProfileProvider with ChangeNotifier {
  static const fileName =
      'lib/app/src/screens/main/profile/provider/profile_provider.dart';

  ImagePicker _imagePicker;

  PickedFile _pickedFile;

  helpers.MinioStorage _minioStorage;
  utils.LogUtils _log;

  providers.Auth _authProvider;
  providers.Auth get auth => _authProvider;

  models.User _userData;
  models.User get userData => _userData;

  bool _isInit;
  bool get isInit => _isInit;
  bool _isBusy;
  bool get isBusy => _isBusy;
  String _imageUrl;
  String get imageUrl => _imageUrl;

  ProfileProvider(providers.Auth auth) {
    this._minioStorage = config.locator<helpers.MinioStorage>();
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);

    this._authProvider = auth;
    this._imagePicker = ImagePicker();
  }

  update(providers.Auth auth) {
    this._authProvider = auth;

    notifyListeners();
  }

  setToBusy() {
    _isBusy = true;

    notifyListeners();
  }

  setToIdle() {
    _isInit = false;
    _isBusy = false;

    notifyListeners();
  }

  Future initResource() async {
    this._imagePicker = null;

    this._isInit = false;
    this._isBusy = false;
    this._imageUrl = '';
    this._userData = _authProvider.userData;
  }

  Future pickImageFromGalery(BuildContext context) async {
    _pickedFile = await _imagePicker.getImage(
        source: ImageSource.gallery, maxHeight: 720, maxWidth: 560);

    if (_pickedFile != null) {
      await _imageUpload(context);
    }
  }

  Future pickImageFromCamera(BuildContext context) async {
    _pickedFile = await _imagePicker.getImage(
        source: ImageSource.camera, maxHeight: 720, maxWidth: 560);

    if (_pickedFile != null) {
      await _imageUpload(context);
    }
  }

  Future logout(
      {BuildContext context,
      providers.Appointment appointment,
      providers.Cart cart,
      providers.Financial financial,
      providers.Notification notification,
      providers.Partner partner,
      providers.Payment payment}) async {
    bool dialogValue = await questionDialog(
        context: context,
        icon: 'assets/icons/logout.png',
        iconSize: 186,
        description: 'Are you sure you want to log-out?',
        descriptionFontSize: 14,
        buttonYesText: 'Ok',
        buttonNoText: 'No',
        buttonFontSize: 12,
        sizedBox2: 5,
        sizedBox3: 10);

    if (dialogValue) {
      // setToBusy();

      appointment.clear();
      cart.clear();
      financial.clear();
      notification.clear();
      partner.clear();
      payment.clear();

      await _authProvider.logout();

      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    }
  }

  Future _imageUpload(BuildContext context) async {
    _imageUrl = await _minioStorage.uploadImage(
        _authProvider.userId, File(_pickedFile.path));

    if (_imageUrl != 'error') {
      await _evictImage(_imageUrl);

      _authProvider.userData.pictureUrl = _imageUrl;

      await _authProvider.updateProfile();

      if (_authProvider.authStatus ==
          helpers.AuthResultStatus.updateProfileSuccess) {
        await _authProvider.getUserData();

        _userData = _authProvider.userData;

        successDialog(
            context: context,
            barrierDismissible: true,
            iconSize: 72,
            title: helpers.AuthExceptionHandler.generateExceptionMessage(
                _authProvider.authStatus),
            titleFontSize: 14,
            description: '',
            descriptionFontSize: 10,
            buttonText: 'Okay',
            buttonFontSize: 12,
            sizedBox1: 12,
            sizedBox2: 5,
            sizedBox3: 10);
      } else {
        await errorDialog(
            context: context,
            barrierDismissible: true,
            iconSize: 45,
            title: helpers.AuthExceptionHandler.generateExceptionMessage(
                _authProvider.authStatus),
            titleFontSize: 14,
            description: '',
            descriptionFontSize: 12,
            buttonText: 'Okay',
            buttonFontSize: 12,
            sizedBox1: 12,
            sizedBox2: 5,
            sizedBox3: 10);
      }
    } else {
      await errorDialog(
          context: context,
          barrierDismissible: true,
          iconSize: 45,
          title: 'Error in minio!',
          titleFontSize: 14,
          description: '',
          descriptionFontSize: 12,
          buttonText: 'Okay',
          buttonFontSize: 12,
          sizedBox1: 12,
          sizedBox2: 5,
          sizedBox3: 10);
    }
  }

  Future _evictImage(String url) async {
    final result = await NetworkImage(url).evict();

    if (result) {
      _log.info(method: '_evictImage', message: 'Removed image');
    } else {
      _log.info(method: '_evictImage', message: 'Image failed to remove');
    }
  }
}

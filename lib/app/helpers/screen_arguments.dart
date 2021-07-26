import 'package:flutter/foundation.dart';

import 'enum.dart';

import '../src/models/models.dart';

class ScreenArguments {
  Key key;
  String mobileNumber;
  String smsCode;
  bool isRegister;
  AccountType accountType;
  MainScreenTab mainScreenTab;

  ScreenArguments({
    this.key,
    this.mobileNumber,
    this.smsCode,
    this.isRegister,
    this.accountType,
    this.mainScreenTab = MainScreenTab.home,
  });
}

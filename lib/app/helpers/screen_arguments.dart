import 'package:flutter/foundation.dart';

import '../../enum.dart';

import '../src/models/models.dart';

class ScreenArguments {
  final Key key;
  final MainScreenTab mainScreenTab;
  final TransactionScreenTab transactionScreenTab;
  final StaticData staticData;
  final Partner partnerData;
  final User userData;
  final String prevRoute;
  final DateTime initialDate;

  ScreenArguments(
      {this.key,
      this.mainScreenTab = MainScreenTab.home,
      this.transactionScreenTab = TransactionScreenTab.onGoing,
      this.staticData,
      this.partnerData,
      this.userData,
      this.prevRoute,
      this.initialDate});
}

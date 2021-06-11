import 'package:flutter/foundation.dart';

import '../../enum.dart';

import '../src/models/models.dart';

class ScreenArguments {
  final Key key;
  final MainScreenTab mainScreenTab;
  final TransactionScreenTab transactionScreenTab;
  final StaticData staticData;

  ScreenArguments(
      {this.key,
      this.mainScreenTab = MainScreenTab.home,
      this.transactionScreenTab = TransactionScreenTab.paymentStatus,
      this.staticData});
}

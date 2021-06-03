import 'package:flutter/foundation.dart';

import '../../enum.dart';

class ScreenArguments {
  final Key key;
  final MainScreenTab mainScreenTab;
  final TransactionScreenTab transactionScreenTab;

  ScreenArguments(
      {this.key,
      this.mainScreenTab = MainScreenTab.home,
      this.transactionScreenTab = TransactionScreenTab.paymentStatus});
}

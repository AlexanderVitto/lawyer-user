import 'package:flutter/material.dart';

import '../../../../../constraint.dart';
import '../../../../../enum.dart';

import '../../../../config/config.dart' as config;
import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;

import '../../../models/models.dart' as models;
import '../../../providers/providers.dart' as providers;

import '../../shared/shared.dart';
import '../../book_appointment/book_appointment_screen.dart';
import '../../main/main_screen.dart';
import '../../checkout/checkout_screen.dart';

class CartProvider with ChangeNotifier {
  static const fileName =
      'lib/app/src/screens/cart/provider/cart_provider.dart';

  utils.LogUtils _log;

  providers.Cart _cartProvider;
  providers.Cart get cartProvider => _cartProvider;

  List<models.Cart> _carts;
  List<models.Cart> get carts => _carts;

  List<models.Cart> get selectedItems =>
      _cartProvider.carts.where((element) => element.isSelected).toList();

  bool _isInit;
  bool get isInit => _isInit;
  bool _isExpanded;
  bool get isExpanded => _isExpanded;

  double _total;
  double get total => _total;

  CartProvider(providers.Cart cart) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);

    this._cartProvider = cart;
  }

  update(providers.Cart cart) {
    this._cartProvider = cart;

    notifyListeners();
  }

  initResource() {
    this._isInit = true;
    this._isExpanded = false;

    this._carts = [];
    this._total = 0.0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialLoad();
    });
  }

  selectItem(models.Cart item) {
    item.toggleButtons();
    getTotal();
  }

  getTotal() {
    double result = 0.0;
    _cartProvider.carts.forEach((element) {
      if (element.isSelected) result += element.price;
    });

    _total = result;

    notifyListeners();
  }

  toggleExpanded() {
    _isExpanded = !_isExpanded;

    notifyListeners();
  }

  Future initialLoad() async {
    final futures = <Future>[_cartProvider.fetchCart()];

    await Future.wait(futures);

    _carts = _cartProvider.carts;

    _isInit = false;

    notifyListeners();
  }

  Future<bool> onWillPop(BuildContext context, String previousRoute) async {
    bool dialogValue = await popDialog(
        context: context,
        description: 'Continue to pay?',
        descriptionFontSize: 14,
        buttonYesText: 'Yes, continue to pay',
        buttonNoText: 'No, go back to main page',
        buttonFontSize: 12,
        sizedBox2: 5,
        sizedBox3: 10);

    if (!dialogValue) {
      switch (previousRoute) {
        case BookAppointmentScreen.routeName:
          Navigator.of(context).pushNamedAndRemoveUntil(
              MainScreen.routeName, (route) => false,
              arguments:
                  helpers.ScreenArguments(mainScreenTab: MainScreenTab.home));
          break;
        default:
      }

      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  onSelectPayment(BuildContext context) {
    if (selectedItems.isNotEmpty)
      Navigator.of(context).pushNamed(CheckoutScreen.routeName);
  }
}

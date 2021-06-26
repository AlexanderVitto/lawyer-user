import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../../enum.dart';

import '../../../../config/config.dart' as config;
import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;
import '../../../../native/payment_gateway.dart';

import '../../../models/models.dart' as models;
import '../../../providers/providers.dart' as providers;

import '../../manual_payment/manual_payment_screen.dart';

class CheckoutProvider with ChangeNotifier {
  static const fileName =
      'lib/app/src/screens/checkout/provider/checkout_provider.dart';

  final List<String> listPaymentMethod = [
    'Select Payment',
    'Automatic Transfer',
    'Manual Transfer'
  ];

  utils.LogUtils _log;

  providers.Cart _cartProvider;
  providers.Cart get cartProvider => _cartProvider;
  providers.Payment _paymentProvider;
  providers.Payment get paymentProvider => _paymentProvider;

  PaymentMethod _paymentMethod;
  PaymentMethod get paymentMethod => _paymentMethod;

  List<models.Cart> _selectedItems;
  List<models.Cart> get selectedItems => _selectedItems;

  bool _isBusy;
  bool get isBusy => _isBusy;
  double _subTotal;
  double get subTotal => _subTotal;
  double _promo;
  double get promo => _promo;
  double _tax;
  double get tax => _tax;
  double _total;
  double get total => _total;
  String _paymentMethodText;
  String get paymentMethodText => _paymentMethodText;

  CheckoutProvider(providers.Cart cart, providers.Payment payment) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);

    this._cartProvider = cart;
    this._paymentProvider = payment;
  }

  update(providers.Cart cart, providers.Payment payment) {
    this._cartProvider = cart;
    this._paymentProvider = payment;

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

  initResource() {
    this._paymentMethod = null;
    this._isBusy = false;

    this._subTotal = 0.0;
    this._promo = 0.0;
    this._tax = 0.0;
    this._paymentMethodText = listPaymentMethod[0];

    _selectedItems =
        _cartProvider.carts.where((element) => element.isSelected).toList();

    double result = 0.0;
    _cartProvider.carts.forEach((element) {
      if (element.isSelected) result += element.price;
    });

    _subTotal = result;

    _total = _subTotal - _promo + _tax;
  }

  selectPaymentMethod(PaymentMethod method) {
    _paymentMethod = method;
    _paymentMethodText = listPaymentMethod[method.index + 1];

    notifyListeners();
  }

  Future pay(BuildContext context) async {
    if (_paymentMethod != null) {
      if (_paymentMethod == PaymentMethod.manual) {
        Navigator.of(context).pushNamed(ManualPaymentScreen.routeName);
      } else {
        setToBusy();

        final orderId = Uuid().v4();

        final List<Map<String, dynamic>> items = _selectedItems
            .map((element) => {
                  'id': element.appointmentId.toString(),
                  'booking_code': element.bookingCode,
                  'user_id': element.userId,
                  'partner_id': element.partnerId,
                  'start_date': element.startDate,
                  'end_date': element.endDate,
                  'price': element.price
                })
            .toList();

        models.User userData = _cartProvider.auth.userData;

        PaymentGateway.payment({
          "orderId": orderId,
          "items": items,
          "total": _total,
          "email": userData.email ?? '',
          "firstName": userData.firstName ?? '',
          "lastName": userData.lastName ?? '',
          "phone": userData.mobileNumber ?? '',
          "address": userData.address ?? '',
          "city": userData.region1 ?? '',
          "postalCode": userData.zipCode ?? ''
        });
      }
    }
  }

  Future initPaymentMidtrans(dynamic data) async {
    setToBusy();

    models.MidtransResponse midtransResponse =
        models.MidtransResponse.fromJson(jsonDecode(jsonEncode(data)));

    final listOfId =
        _selectedItems.map((element) => element.appointmentId).toList();

    String vaNumber = '';
    String bank = '';

    if (midtransResponse.bcaVaNumber != null) {
      vaNumber = midtransResponse.bcaVaNumber;
      bank = '014';
    }

    if (midtransResponse.bniVaNumber != null) {
      vaNumber = midtransResponse.bniVaNumber;
      bank = '009';
    }

    if (midtransResponse.briVaNumber != null) {
      vaNumber = midtransResponse.briVaNumber;
      bank = '002';
    }

    if (midtransResponse.permataVaNumber != null) {
      vaNumber = midtransResponse.permataVaNumber;
      bank = '013';
    }

    models.InitPaymentMidtransBody body = models.InitPaymentMidtransBody(
        invoices: listOfId,
        grossAmount: _total,
        paymentMethod: 1,
        userId: _cartProvider.auth.userId,
        orderId: midtransResponse.orderId,
        paymentType: midtransResponse.paymentType,
        virtualAccountNumber: vaNumber,
        bankCode: bank);

    await _paymentProvider.initMidtransPayment(body);

    setToIdle();
  }
}

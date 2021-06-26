import 'package:flutter/material.dart';

import '../../../../../constraint.dart';
import '../../../../../enum.dart';

import '../../../../config/config.dart' as config;
import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;

import '../../../models/models.dart' as models;
import '../../../providers/providers.dart' as providers;

import '../../main/main_screen.dart';
import '../../shared/shared.dart';

class ManualPaymentProvider with ChangeNotifier {
  static const fileName =
      'lib/app/src/screens/manual_payment/provider/manual_payment_provider.dart';

  final List<Map<int, String>> atmGuide = [
    {
      1: 'Insert the BCA ATM card into the ATM machine then enter the PIN.',
    },
    {
      2: 'Select the Other Transaction menu.',
    },
    {
      3: 'Select the Transfer menu.',
    },
    {
      4: 'Then select To BCA Account.',
    },
    {
      5: 'Enter the amount to be sent and select YES.',
    },
    {
      6: 'Enter the 10 digit BCA account number to which you want to transfer then Correct.',
    },
    {
      7: 'Check again whether the account number, owner name and transfer amount then select Correct.'
    },
  ];
  final List<Map<int, String>> mGuide = [
    {
      1: 'Open the BCA Mobile application then select M-BCA then enter the access code to login.',
    },
    {
      2: 'Select the m-Transfer menu.',
    },
    {
      3: 'Then select Between Accounts.',
    },
    {
      4: "Then tap on the To Account column then select the BCA account number to which you want to transfer. If there isn't, then you have to add the transfer list first.",
    },
    {
      5: "Tap on the column Rp. Then enter the amount of money. The news column can be filled in, it can be left blank. If you have tap the Send button.",
    },
    {
      6: "A destination BCA account number, name of the BCA account owner and nominal will appear. If everything is correct tap OK.",
    },
    {
      7: 'The next step is to enter the m-BCA pin then OK.',
    },
    {
      8: 'If the transaction is successful, a notification will appear and the money will go to the destination account.'
    },
  ];
  final List<Map<int, String>> klikGuide = [
    {
      1: 'Login to klikBCA page.',
    },
    {
      2: 'Then select the Funds Transfer menu.',
    },
    {
      3: 'Select Transfer to BCA account.',
    },
    {
      4: 'Select the destination account, then enter the amount of money, while news can be left blank.',
    },
    {
      5: 'Activate keyBCA then press number 2 then input the 8 numbers that appear on the screen klik BCA to keyBCA.',
    },
    {
      6: 'Next, enter the number that appears on the keyBCA tool into the APPLI 2 Response Code column.',
    },
    {
      7: 'Scroll down and then on the type of transfer select Transfer Now then click Continue.',
    },
    {
      8: 'Double check that the account number, name of recipient and amount of money are correct.',
    },
    {
      9: 'Activate keyBCA again then press number 1, enter the number that appears on keyBCA into the APPLI 1 keybca response column then click Send.',
    },
    {
      10: 'If the transaction is successful, a notification will appear.',
    },
  ];

  utils.LogUtils _log;

  DateTime _dueTime;
  DateTime get dueTime => _dueTime;

  providers.Cart _cartProvider;
  providers.Cart get cartProvider => _cartProvider;
  providers.Payment _paymentProvider;
  providers.Payment get paymentProvider => _paymentProvider;

  models.Invoice _invoice;
  models.Invoice get invoice => _invoice;

  bool _isBusy;
  bool get isBusy => _isBusy;
  bool _isATMExpanded;
  bool get isATMExpanded => _isATMExpanded;
  bool _isMExpanded;
  bool get isMExpanded => _isMExpanded;
  bool _isKlikExpanded;
  bool get isKlikExpanded => _isKlikExpanded;
  double _amount;
  double get amount => _amount;
  String _namaRek;
  String get namaRek => _namaRek;
  String _noRek;
  String get noRek => _noRek;

  ManualPaymentProvider(providers.Cart cart, providers.Payment payment) {
    this._log = config.locator<utils.LogUtils>(param1: fileName, param2: true);

    this._cartProvider = cart;
    this._paymentProvider = payment;
  }

  update(providers.Cart cart, providers.Payment payment) {
    this._cartProvider = cart;
    this._paymentProvider = payment;

    notifyListeners();
  }

  initResource() {
    this._dueTime = DateTime.now().add(Duration(
        minutes: config.FlavorConfig.instance.values.paymentExpiredTime));
    this._invoice = _paymentProvider.initPaymentResult;

    this._isBusy = false;
    this._isATMExpanded = false;
    this._isMExpanded = false;
    this._isKlikExpanded = false;
    this._namaRek = 'PT Psykay Persona Perkasa';
    this._noRek = '2180977778';

    double result = 0.0;
    _cartProvider.carts.forEach((element) {
      if (element.isSelected) result += element.price;
    });

    _amount = result;
  }

  toggleATM() {
    _isATMExpanded = !_isATMExpanded;

    notifyListeners();
  }

  toggleM() {
    _isMExpanded = !_isMExpanded;

    notifyListeners();
  }

  toggleKlik() {
    _isKlikExpanded = !_isKlikExpanded;

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

  Future pay(BuildContext context) async {
    setToBusy();

    final listOfId = _cartProvider.carts
        .where((e) => e.isSelected)
        .map((i) => i.appointmentId)
        .toList();

    models.InitPaymentBody body = models.InitPaymentBody(
        invoices: listOfId,
        grossAmount: _amount,
        userId: _cartProvider.auth.userId,
        paymentMethod: 2);

    await _paymentProvider.initPayment(body);

    setToIdle();

    if (_paymentProvider.paymentStatus ==
        helpers.AuthResultStatus.initPaymentSuccess) {
      await successDialog(
          context: context,
          barrierDismissible: false,
          iconSize: 72,
          title: 'Payment Success!',
          titleFontSize: 14,
          description: 'Click the button to go to transactions page',
          descriptionFontSize: 12,
          buttonText: 'Okay',
          buttonFontSize: 12,
          sizedBox1: 12,
          sizedBox2: 5,
          sizedBox3: 10);

      Navigator.of(context).pushNamedAndRemoveUntil(
          MainScreen.routeName, (route) => false,
          arguments:
              helpers.ScreenArguments(mainScreenTab: MainScreenTab.home));
    } else {
      await errorDialog(
          context: context,
          iconSize: 45,
          title: 'Login Error!',
          titleFontSize: 14,
          description: helpers.AuthExceptionHandler.generateExceptionMessage(
              _paymentProvider.paymentStatus),
          descriptionFontSize: 12,
          buttonText: 'Okay',
          buttonFontSize: 12,
          sizedBox1: 12,
          sizedBox2: 5,
          sizedBox3: 10);
    }
  }
}

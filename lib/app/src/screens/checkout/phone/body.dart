import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../constraint.dart';
import '../../../../../enum.dart';

import '../../../../helpers/helpers.dart' as helpers;

import '../../../models/models.dart' as models;

import '../../shared/shared.dart';

import '../provider/checkout_provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    final currencyFormatter = NumberFormat('#,##0.00', 'ID');
    final size = MediaQuery.of(context).size;

    return Consumer<CheckoutProvider>(
      builder: (_, provider, __) => Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(15),
            children: [
              _appointmentsBuilder(
                  provider.selectedItems, currencyFormatter, localization),
              const SizedBox(
                height: 10,
              ),
              _summaryBuilder(provider, currencyFormatter, localization),
              SizedBox(
                height: size.height * 0.2,
              )
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _BottomContainer(
              provider: provider,
            ),
          ),
          if (provider.isBusy) helpers.LoadingPouringHourGlass()
        ],
      ),
    );
  }

  // Builders

  Widget _appointmentsBuilder(List<models.Cart> items,
      NumberFormat currencyFormatter, helpers.AppLocalizations localizations) {
    List<Widget> widgets = [];

    for (int i = 0; i < items.length; i++) {
      widgets.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    items[i].productServiceDescription,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    items[i].partnerName,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Flexible(
              child: Text(
                '${localizations.translate('Rp')} ${currencyFormatter.format(items[i].price)}',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ));

      if (i < items.length - 1) {
        widgets.add(const _Separator(
          width: 2.0,
          color: PsykayOrangeColor,
        ));
      }
    }

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(9)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 9,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    '${localizations.translate('Appointments')} ',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Flexible(
                  child: Text(
                    '${localizations.translate('Total')} ${items.length}',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.black54,
          ),
          ...widgets
        ],
      ),
    );
  }

  Widget _summaryBuilder(CheckoutProvider provider,
      NumberFormat currencyFormatter, helpers.AppLocalizations localizations) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SummaryContainer(
            name: localizations.translate('Subtotal'),
            price:
                '${localizations.translate('Rp')} ${currencyFormatter.format(provider.subTotal)}',
            color: Colors.black54,
            fontWeight: FontWeight.w400,
          ),
          Divider(
            color: Colors.black54,
          ),
          _SummaryContainer(
            name: localizations.translate('Promo'),
            price:
                '${localizations.translate('Rp')} ${currencyFormatter.format(provider.promo)}',
            color: PsykayGreenColor,
            fontWeight: FontWeight.w400,
          ),
          Divider(
            color: Colors.black54,
          ),
          _SummaryContainer(
            name: localizations.translate('Tax'),
            price:
                '${localizations.translate('Rp')} ${currencyFormatter.format(provider.tax)}',
            color: Colors.red[600],
            fontWeight: FontWeight.w400,
          ),
          Divider(
            color: Colors.black54,
          ),
          _SummaryContainer(
            name: localizations.translate('Total Payment'),
            price:
                '${localizations.translate('Rp')} ${currencyFormatter.format(provider.total)}',
            color: Colors.black54,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}

class _BottomContainer extends StatelessWidget {
  final CheckoutProvider provider;

  const _BottomContainer({Key key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    final currencyFormatter = NumberFormat('#,##0.00', 'ID');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      constraints: BoxConstraints(minHeight: 120),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(30)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 2,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    localization.translate('Payment Method'),
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Flexible(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (_) => _PaymentMethodContainer()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(localization
                              .translate(provider.paymentMethodText)),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.black54,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          CustomElevatedButton(
            onPresses: () => provider.pay(context),
            localization: localization,
            backgroundColor: provider.paymentMethod == null
                ? PsykayGreyLightColor
                : PsykayOrangeColor,
            fontSize: 14,
            text:
                '${localization.translate('Pay')} - ${localization.translate('Rp')} ${currencyFormatter.format(provider.total)}',
          )
        ],
      ),
    );
  }
}

class _PaymentMethodContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    return Consumer<CheckoutProvider>(
      builder: (_, provider, __) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  onTap: () =>
                      provider.selectPaymentMethod(PaymentMethod.automatic),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          localization.translate(provider.listPaymentMethod[1]),
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Icon(
                        provider.paymentMethod == PaymentMethod.automatic
                            ? Icons.radio_button_checked_rounded
                            : Icons.radio_button_off_rounded,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              color: PsykayGreyLightColor,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  onTap: () =>
                      provider.selectPaymentMethod(PaymentMethod.manual),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          localization.translate(provider.listPaymentMethod[2]),
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Icon(
                        provider.paymentMethod == PaymentMethod.manual
                            ? Icons.radio_button_checked_rounded
                            : Icons.radio_button_off_rounded,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomElevatedButton(
              onPresses: () => Navigator.of(context).pop(),
              localization: localization,
              fontSize: 12,
              text: 'Select',
            )
          ],
        ),
      ),
    );
  }
}

class _SummaryContainer extends StatelessWidget {
  final String name;
  final String price;
  final Color color;
  final FontWeight fontWeight;

  const _SummaryContainer(
      {Key key, this.name, this.price, this.color, this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              name,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Flexible(
            child: Text(
              price,
              style:
                  TextStyle(fontSize: 12, color: color, fontWeight: fontWeight),
            ),
          ),
        ],
      ),
    );
  }
}

class _Separator extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const _Separator(
      {this.height = 1, this.width = 9.0, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = width;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

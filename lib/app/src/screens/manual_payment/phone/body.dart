import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../constraint.dart';
import '../../../../../enum.dart';

import '../../../../helpers/helpers.dart' as helpers;

import '../../../models/models.dart' as models;

import '../../shared/shared.dart';

import '../provider/manual_payment_provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    final currencyFormatter = NumberFormat('#,##0.00', 'ID');

    return Consumer<ManualPaymentProvider>(
      builder: (_, provider, __) => Stack(
        fit: StackFit.expand,
        children: [
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localization.translate('Payment Due'),
                      style: TextStyle(
                          fontSize: 14,
                          color: PsykayGreenColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      '${DateFormat.yMMMMd(provider.cartProvider.auth.language).format(provider.dueTime)} ${localization.translate('at')} ${DateFormat('HH:mm').format(provider.dueTime)}',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              const Divider(
                height: 2,
                color: PsykayGreenColor,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localization.translate('BCA Virtual Account'),
                      style: TextStyle(
                          fontSize: 14,
                          color: PsykayGreenColor,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/bank-bca.png',
                          height: 60,
                          width: 100,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                provider.namaRek,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      provider.noRek,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  InkWell(
                                    onTap: () =>
                                        FlutterClipboard.copy(provider.noRek)
                                            .then((result) {
                                      final snackBar = SnackBar(
                                        content: Text(localization
                                            .translate('Copied to clipboard')),
                                      );

                                      Scaffold.of(context)
                                          .showSnackBar(snackBar);
                                    }),
                                    child: Icon(
                                      Icons.content_copy,
                                      color: PsykayOrangeColor,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Divider(
                height: 2,
                color: PsykayGreenColor,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localization.translate('Total Payment'),
                      style: TextStyle(
                          fontSize: 14,
                          color: PsykayGreenColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      '${localization.translate('Amount')}',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black26,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${localization.translate('Rp')} ${currencyFormatter.format(provider.amount)}',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 2,
                color: PsykayGreenColor,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: PsykayOrangeColor),
                    color: PsykayOrangeColor.withOpacity(0.5)),
                child: Text(
                  localization.translate(
                      'Please confirm your transaction details after payment is completed.'),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(
                height: 2,
                color: PsykayGreenColor,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localization.translate('Payment Guide'),
                      style: TextStyle(
                          fontSize: 14,
                          color: PsykayGreenColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            localization.translate('ATM BCA'),
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: provider.toggleATM,
                          child: Icon(
                            provider.isATMExpanded
                                ? Icons.expand_less
                                : Icons.expand_more,
                            color: PsykayGreyColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    _ExpandedSection(
                      expand: provider.isATMExpanded,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: provider.atmGuide
                            .map((element) => Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    '${element.keys.first}. ${element.values.first}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                height: 2,
                color: PsykayGreenColor,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            localization.translate('m-BCA'),
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: provider.toggleM,
                          child: Icon(
                            provider.isMExpanded
                                ? Icons.expand_less
                                : Icons.expand_more,
                            color: PsykayGreyColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    _ExpandedSection(
                      expand: provider.isMExpanded,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: provider.mGuide
                            .map((element) => Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    '${element.keys.first}. ${element.values.first}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                height: 2,
                color: PsykayGreenColor,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            localization.translate('Klik BCA'),
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: provider.toggleKlik,
                          child: Icon(
                            provider.isKlikExpanded
                                ? Icons.expand_less
                                : Icons.expand_more,
                            color: PsykayGreyColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    _ExpandedSection(
                      expand: provider.isKlikExpanded,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: provider.klikGuide
                            .map((element) => Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    '${element.keys.first}. ${element.values.first}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomElevatedButton(
                  onPresses: () => provider.pay(context),
                  localization: localization,
                  text: 'Pay',
                ),
              )
            ],
          ),
          if (provider.isBusy) helpers.LoadingPouringHourGlass()
        ],
      ),
    );
  }
}

class _ExpandedSection extends StatefulWidget {
  final Widget child;
  final bool expand;
  _ExpandedSection({this.expand = false, this.child});

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<_ExpandedSection>
    with SingleTickerProviderStateMixin {
  AnimationController expandController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    Animation curve = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void didUpdateWidget(_ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 1.0, sizeFactor: animation, child: widget.child);
  }
}

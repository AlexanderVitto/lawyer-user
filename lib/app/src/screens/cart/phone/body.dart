import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../constraint.dart';

import '../../../../helpers/helpers.dart' as helpers;

import '../../../models/models.dart' as models;

import '../../shared/shared.dart';

import '../provider/cart_provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    final currencyFormatter = NumberFormat('#,##0.00', 'ID');

    return Consumer<CartProvider>(
      builder: (_, provider, __) => provider.isInit
          ? helpers.LoadingPouringHourGlass()
          : ListView(
              padding: const EdgeInsets.all(15),
              children: [
                ...provider.carts
                    .map((element) => ChangeNotifierProvider.value(
                          value: element,
                          child: _ItemContainer(
                            cartProvider: provider,
                            currencyFormatter: currencyFormatter,
                            localization: localization,
                          ),
                        ))
                    .toList(),
                const SizedBox(
                  height: 30,
                ),
                _SummaryContainer(
                  provider: provider,
                  currencyFormatter: currencyFormatter,
                  localization: localization,
                ),
                const _Separator(
                  color: Colors.grey,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(9),
                          bottomRight: Radius.circular(9)),
                      color: Colors.white),
                  child: Center(
                    child: CustomElevatedButton(
                      onPresses: () => provider.onSelectPayment(context),
                      padding: const EdgeInsets.all(8),
                      localization: localization,
                      fontSize: 12,
                      backgroundColor: provider.selectedItems.isEmpty
                          ? PsykayGreyLightColor
                          : PsykayOrangeColor,
                      text: 'Select payment',
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

class _SummaryContainer extends StatelessWidget {
  final NumberFormat currencyFormatter;
  final CartProvider provider;
  final helpers.AppLocalizations localization;

  const _SummaryContainer(
      {Key key, this.currencyFormatter, this.provider, this.localization})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9), topRight: Radius.circular(9)),
              color: Colors.white),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                localization.translate('Total Price'),
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: Text(
                  '${localization.translate('Rp')} ${currencyFormatter.format(provider.total)} ',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              if (provider.selectedItems.isNotEmpty)
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: provider.toggleExpanded,
                  child: Icon(
                    provider.isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: PsykayGreenColor,
                  ),
                ),
            ],
          ),
        ),
        _ExpandedSection(
          expand: provider.isExpanded,
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: provider.selectedItems
                  .map((element) => Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              element.productServiceDescription,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w600),
                            ),
                            Expanded(
                              child: Text(
                                '${localization.translate('Rp')} ${currencyFormatter.format(provider.total)} ',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        )
      ],
    );
  }
}

class _ItemContainer extends StatelessWidget {
  final NumberFormat currencyFormatter;
  final CartProvider cartProvider;
  final helpers.AppLocalizations localization;

  const _ItemContainer(
      {Key key, this.currencyFormatter, this.cartProvider, this.localization})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<models.Cart>(
      builder: (_, provider, __) {
        final startDate = DateTime.parse(
            '${provider.startDate.split('T')[0]} ${provider.startTime}');
        final endDate = DateTime.parse(
            '${provider.endDate.split('T')[0]} ${provider.endTime}');

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(9),
                      topRight: Radius.circular(9)),
                  color: Colors.white),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => cartProvider.selectItem(provider),
                    child: Container(
                        height: 30,
                        width: 30,
                        child: provider.isSelected
                            ? Icon(
                                Icons.check_box,
                                color: PsykayBlueLightColor,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                color: PsykayGreyLightColor,
                              )),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.productServiceDescription,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          provider.partnerName,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black38,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${DateFormat.yMMMMd(cartProvider.cartProvider.auth.language).format(startDate)} * ${DateFormat('HH:mm', cartProvider.cartProvider.auth.language).format(startDate)} - ${DateFormat('HH:mm', cartProvider.cartProvider.auth.language).format(endDate)}',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black38,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15, top: 7, bottom: 7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(9),
                      bottomRight: Radius.circular(9)),
                  color: PsykayGreenColor),
              child: Text(
                '${localization.translate('Rp')} ${currencyFormatter.format(provider.price)}',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(
              height: 12,
            )
          ],
        );
      },
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

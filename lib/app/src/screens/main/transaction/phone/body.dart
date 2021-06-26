import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../../constraint.dart';
import '../../../../../../enum.dart';

import '../../../../../helpers/helpers.dart' as helpers;

import '../../../../models/models.dart' as models;

import '../provider/transaction_provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  TabController _tabController;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    return Consumer<TransactionProvider>(
      builder: (_, provider, __) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            _TabBarContainer(
                provider: provider,
                tabController: _tabController,
                localization: localization),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: TabBarView(children: [
                SmartRefresher(
                  enablePullDown: true,
                  header: ClassicHeader(),
                  controller: _refreshController,
                  onRefresh: () => provider.initialLoad(_refreshController),
                  child: ListView.builder(
                    addAutomaticKeepAlives: true,
                    itemCount: provider.listOnGoing.length,
                    itemBuilder: (_, index) => _ItemContainer(
                      provider: provider,
                      data: provider.listOnGoing[index],
                    ),
                  ),
                ),
                SmartRefresher(
                  enablePullDown: true,
                  header: ClassicHeader(),
                  controller: _refreshController,
                  onRefresh: () => provider.initialLoad(_refreshController),
                  child: ListView.builder(
                    addAutomaticKeepAlives: true,
                    itemCount: provider.listHistory.length,
                    itemBuilder: (_, index) => _ItemContainer(
                      provider: provider,
                      data: provider.listHistory[index],
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class _ItemContainer extends StatefulWidget {
  const _ItemContainer({Key key, this.provider, this.data}) : super(key: key);

  final TransactionProvider provider;
  final models.Invoice data;

  @override
  __ItemContainerState createState() => __ItemContainerState();
}

class __ItemContainerState extends State<_ItemContainer>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final localization = helpers.AppLocalizations.of(context);
    final currencyFormatter = NumberFormat('#,##0.00', 'ID');

    models.MasterBank bank = widget.provider.searchBank(widget.data.toBankCode);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          boxShadow: [
            BoxShadow(
              color: PsykayGreyLightColor.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 2,
              offset: Offset(0, 0),
            )
          ],
          color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localization.translate('Invoice Number'.pascalCase()),
                      style: TextStyle(
                          fontSize: 12,
                          color: PsykayGreyColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      widget.data.invoiceNumber,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: PsykayOrangeColor),
                      color: Colors.white),
                  child: Text(
                    localization.translate(widget.data.paymentMethodId == 1
                        ? 'Automatic Payment'.pascalCase()
                        : 'Manual Payment'.pascalCase()),
                    style: TextStyle(
                        fontSize: 12,
                        color: PsykayOrangeColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localization.translate('Payment to'.pascalCase()),
                      style: TextStyle(
                          fontSize: 12,
                          color: PsykayGreyColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    widget.data.paymentMethodId == 1
                        ? Text(
                            widget.data.toAccountNumber,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.provider.noRek,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                widget.provider.namaRek,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localization.translate('Bank Name'.pascalCase()),
                      style: TextStyle(
                          fontSize: 12,
                          color: PsykayGreyColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      widget.data.paymentMethodId == 1
                          ? bank.bankName
                          : 'BANK BCA',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            localization.translate('Total Payment'.pascalCase()),
            style: TextStyle(
                fontSize: 12,
                color: PsykayGreyColor,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            "${localization.translate('Rp'.pascalCase())} ${currencyFormatter.format(widget.data.grossAmount)}",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localization.translate('Status'.pascalCase()),
                style: TextStyle(
                    fontSize: 12,
                    color: PsykayGreyColor,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 3,
              ),
              if (widget.data.transactionStatus == 1)
                Text(
                  localization.translate('Open payment'.pascalCase()),
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600),
                ),
              if (widget.data.transactionStatus == 2)
                Text(
                  localization.translate('Pending payment'.pascalCase()),
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600),
                ),
              if (widget.data.transactionStatus == 3)
                Text(
                  localization.translate('Settled payment'.pascalCase()),
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600),
                ),
            ],
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _TabBarContainer extends StatelessWidget {
  const _TabBarContainer({
    Key key,
    this.provider,
    @required this.tabController,
    @required this.localization,
  }) : super(key: key);

  final TransactionProvider provider;
  final TabController tabController;
  final helpers.AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: PsykayGreyLightColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 1,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0), color: PsykayGreenColor),
        labelColor: Colors.white,
        labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelColor: Colors.black54,
        unselectedLabelStyle:
            TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        tabs: [
          Tab(
            text: localization
                .translate(provider.listTransactionType[0].name.pascalCase()),
          ),
          Tab(
            text: localization
                .translate(provider.listTransactionType[1].name.pascalCase()),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../../constraint.dart';

import '../../../../helpers/helpers.dart' as helpers;

import '../../../models/models.dart' as models;

import '../../shared/custom_elevated_button.dart';

import '../provider/book_appointment_provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final localization = helpers.AppLocalizations.of(context);
    final currencyFormatter = NumberFormat('#,##0.00', 'ID');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Consumer<BookAppointmentProvider>(
          builder: (_, provider, __) => _ProgressIndicator(
              size: size, provider: provider, localization: localization),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              _TimeTabView(
                  tabController: _tabController, localization: localization),
              _DetailTabView(
                tabController: _tabController,
                localization: localization,
                currencyFormatter: currencyFormatter,
              ),
              _SubmitTabView(
                tabController: _tabController,
                localization: localization,
                currencyFormatter: currencyFormatter,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _SubmitTabView extends StatelessWidget {
  const _SubmitTabView({
    Key key,
    @required this.tabController,
    this.currencyFormatter,
    @required this.localization,
  }) : super(key: key);

  final TabController tabController;
  final NumberFormat currencyFormatter;
  final helpers.AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<BookAppointmentProvider>(
      builder: (_, provider, __) => provider.isInit
          ? helpers.LoadingPouringHourGlass()
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localization.translate('Psychologist'),
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black45,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            '${provider.partnerDetail.firstName} ${provider.partnerDetail.lastName}',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.person_outline,
                      color: Colors.black45,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
                const Divider(
                  height: 25,
                  color: Colors.black45,
                  indent: 10,
                  endIndent: 10,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localization.translate('Expertise'),
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black45,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      '${provider.expertise.name}',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const Divider(
                  height: 25,
                  color: Colors.black45,
                  indent: 10,
                  endIndent: 10,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localization.translate('Package'),
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black45,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      '${provider.partnerPrice.priceName}',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const Divider(
                  height: 25,
                  color: Colors.black45,
                  indent: 10,
                  endIndent: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localization.translate('Date'),
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black45,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            '${DateFormat.yMMMEd(provider.partnerProvider.auth.language).format(provider.selectedWorkingHour.dateTime)}',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.date_range_outlined,
                      color: Colors.black45,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
                const Divider(
                  height: 25,
                  color: Colors.black45,
                  indent: 10,
                  endIndent: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localization.translate('Time'),
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black45,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            '${provider.selectedWorkingHour.startTime} - ${provider.selectedWorkingHour.endTime}',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.alarm,
                      color: Colors.black45,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    border: Border.all(color: PsykayGreenColor),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${localization.translate('Rp')} ${currencyFormatter.format(provider.partnerPrice.price)}',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: PsykayGreenColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${localization.translate('For consultation')}',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: PsykayOrangeColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.credit_card,
                        color: PsykayGreenColor,
                        size: 30,
                      )
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.19,
                  constraints: BoxConstraints(minHeight: 70),
                ),
                CustomElevatedButton(
                  onPresses: () => provider.onSubmit(context),
                  localization: localization,
                  fontSize: 14,
                  text: 'Proceed to payment',
                )
              ],
            ),
    );
  }
}

class _DetailTabView extends StatelessWidget {
  const _DetailTabView({
    Key key,
    this.currencyFormatter,
    @required this.tabController,
    @required this.localization,
  }) : super(key: key);

  final TabController tabController;
  final NumberFormat currencyFormatter;
  final helpers.AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    return Consumer<BookAppointmentProvider>(
        builder: (_, provider, __) => provider.isInit
            ? helpers.LoadingPouringHourGlass()
            : Column(
                children: [
                  _TopDetail(provider: provider, localization: localization),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    height: 20,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Center(
                      child: Text(
                        localization.translate('Select Your Package'),
                        style: TextStyle(
                            fontSize: 14,
                            color: PsykayGreenColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 20,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.listPartnerPrice.length,
                      itemBuilder: (_, index) => InkWell(
                        onTap: () =>
                            provider.onSubmitPackage(index, tabController, 2),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border: Border.all(color: PsykayGreenColor),
                              boxShadow: [
                                BoxShadow(
                                  color: PsykayGreenColor.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                )
                              ]),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      localization.translate(provider
                                          .listPartnerPrice[index].priceName),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: PsykayGreenColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${localization.translate('Rp')} ${currencyFormatter.format(provider.listPartnerPrice[index].price)}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: PsykayOrangeColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: PsykayGreenColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ));
  }
}

class _TopDetail extends StatelessWidget {
  const _TopDetail({
    Key key,
    this.provider,
    @required this.localization,
  }) : super(key: key);

  final BookAppointmentProvider provider;
  final helpers.AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  color: PsykayGreyLightColor,
                  image: provider.partnerDetail.pictureUrl == null
                      ? null
                      : DecorationImage(
                          image:
                              NetworkImage(provider.partnerDetail.pictureUrl),
                          fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
              child: provider.partnerDetail.pictureUrl != null
                  ? null
                  : Icon(
                      Icons.person,
                      size: 90,
                      color: Colors.grey,
                    )),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${provider.partnerDetail.firstName} ${provider.partnerDetail.lastName}',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 9,
                ),
                Text(
                  '${localization.translate('Expertise')}: ${provider.expertise.name}',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black45,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  '${localization.translate('Counseling date')}: ${DateFormat.yMMMd(provider.partnerProvider.auth.language).format(provider.selectedWorkingHour.dateTime)}',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black45,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  '${localization.translate('Counseling time')}: ${provider.selectedWorkingHour.startTime}',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black45,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _TimeTabView extends StatefulWidget {
  const _TimeTabView({
    Key key,
    @required this.tabController,
    @required this.localization,
  }) : super(key: key);

  final TabController tabController;
  final helpers.AppLocalizations localization;

  @override
  __TimeTabViewState createState() => __TimeTabViewState();
}

class __TimeTabViewState extends State<_TimeTabView>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();

    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookAppointmentProvider>(
        builder: (_, provider, __) => provider.isInit
            ? helpers.LoadingPouringHourGlass()
            : CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      _calendarBuilder(provider),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        height: 20,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Center(
                          child: Text(
                            widget.localization.translate('Select Your Time'),
                            style: TextStyle(
                                fontSize: 14,
                                color: PsykayGreenColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const Divider(
                        height: 20,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ]),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 100.0,
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 2.0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          models.WorkingHour data =
                              provider.selectedEvents[index];
                          return InkWell(
                            onTap: () => provider.onSubmitTime(
                                data, widget.tabController, 1),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: data.isBooked
                                      ? PsykayGreyColor.withOpacity(0.5)
                                      : Colors.white,
                                  boxShadow: [
                                    if (!data.isBooked)
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 3,
                                        blurRadius: 3,
                                        offset: Offset(
                                            0, 0), // changes position of shadow
                                      )
                                  ]),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${provider.selectedEvents[index].startTime}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: data.isBooked
                                              ? PsykayGreyLightColor
                                              : Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        childCount: provider.selectedEvents?.length,
                      ),
                    ),
                  ),
                ],
              ));
  }

  TableCalendar _calendarBuilder(BookAppointmentProvider provider) {
    return TableCalendar(
      locale: 'en_Us',
      calendarController: _calendarController,
      events: provider.workingHour,
      holidays: provider.holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.horizontalSwipe,
      availableCalendarFormats: const {CalendarFormat.month: 'Month'},
      calendarStyle: CalendarStyle(
        outsideDaysVisible: true,
        weekendStyle: TextStyle().copyWith(color: Colors.red),
        holidayStyle: TextStyle().copyWith(color: Colors.red),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.red),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1.5,
                  color: PsykayGreenColor,
                )),
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events, holidays) {
        provider.onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: provider.onVisibleDaysChanged,
      onCalendarCreated: provider.onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List<models.WorkingHour> events) {
    final eventLength =
        events.where((value) => !value.isBooked).toList().length;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : PsykayOrangeColor,
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '$eventLength',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({
    Key key,
    @required this.size,
    this.provider,
    @required this.localization,
  }) : super(key: key);

  final Size size;
  final BookAppointmentProvider provider;
  final helpers.AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70,
            child: TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.manual,
              isFirst: true,
              lineXY: 0.4,
              endChild: Container(
                width: size.width * 0.2,
                constraints: const BoxConstraints(
                  minWidth: 100,
                ),
                color: Colors.transparent,
                child: Center(
                  child: Text(
                    localization.translate('Time'),
                    style: TextStyle(
                        fontSize: 14,
                        color: provider.text1Color,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              startChild: Container(
                width: size.width * 0.2,
                constraints: const BoxConstraints(
                  minWidth: 100,
                ),
                color: Colors.transparent,
              ),
              afterLineStyle: LineStyle(
                color: provider.progressLine1Color,
                thickness: 6,
              ),
              indicatorStyle: IndicatorStyle(
                height: 20,
                color: provider.indicator1Color,
              ),
            ),
          ),
          Container(
            height: 70,
            child: TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.manual,
              lineXY: 0.4,
              endChild: Container(
                width: size.width * 0.2,
                constraints: const BoxConstraints(
                  minWidth: 100,
                ),
                color: Colors.transparent,
                child: Center(
                  child: Text(
                    localization.translate('Details'),
                    style: TextStyle(
                        fontSize: 14,
                        color: provider.text2Color,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              startChild: Container(
                width: size.width * 0.2,
                constraints: const BoxConstraints(
                  minWidth: 100,
                ),
                color: Colors.transparent,
              ),
              beforeLineStyle: LineStyle(
                color: provider.progressLine1Color,
                thickness: 6,
              ),
              afterLineStyle: LineStyle(
                color: provider.progressLine2Color,
                thickness: 6,
              ),
              indicatorStyle: IndicatorStyle(
                height: 20,
                color: provider.indicator2Color,
              ),
            ),
          ),
          Container(
            height: 70,
            child: TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.manual,
              isLast: true,
              lineXY: 0.4,
              endChild: Container(
                width: size.width * 0.2,
                constraints: const BoxConstraints(
                  minWidth: 100,
                ),
                color: Colors.transparent,
                child: Center(
                  child: Text(
                    localization.translate('Submit'),
                    style: TextStyle(
                        fontSize: 14,
                        color: provider.text3Color,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              startChild: Container(
                width: size.width * 0.2,
                constraints: const BoxConstraints(
                  minWidth: 100,
                ),
                color: Colors.transparent,
              ),
              beforeLineStyle: LineStyle(
                color: provider.progressLine2Color,
                thickness: 6,
              ),
              indicatorStyle: IndicatorStyle(
                height: 20,
                color: provider.indicator3Color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

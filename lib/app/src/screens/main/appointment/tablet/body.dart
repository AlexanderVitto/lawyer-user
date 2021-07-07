import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../constraint.dart';
import '../../../../../helpers/helpers.dart' as helpers;

import '../../../../models/models.dart' as models;

import '../provider/appointment_provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
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
    final localization = helpers.AppLocalizations.of(context);
    return Consumer<AppointmentProvider>(
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
                          localization
                              .translate('Your appointment'.pascalCase()),
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
                      height: 5,
                    ),
                  ]),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext contex, int index) {
                      return InkWell(
                        onTap: () {
                          print(jsonEncode(provider.selectedEvents[index]));
                        },
                        child: _ItemContainer(
                          provider: provider,
                          data: provider.selectedEvents[index],
                        ),
                      );
                    }, childCount: provider.selectedEvents?.length),
                  ),
                )
              ],
            ),
    );
  }

  // Builders

  TableCalendar _calendarBuilder(AppointmentProvider provider) {
    return TableCalendar(
      locale: 'en_Us',
      calendarController: _calendarController,
      events: provider.mapAppointment,
      holidays: provider.holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.horizontalSwipe,
      availableCalendarFormats: const {CalendarFormat.month: 'Month'},
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
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

  Widget _buildEventsMarker(DateTime date, List<models.Appointment> events) {
    final eventLength = events.length;
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

class _ItemContainer extends StatefulWidget {
  const _ItemContainer({Key key, this.provider, this.data}) : super(key: key);

  final AppointmentProvider provider;
  final models.Appointment data;

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
    final startTime = DateTime.parse(
        '${widget.data.startDate.split('T')[0]} ${widget.data.startTime}');
    final endTime = DateTime.parse(
        '${widget.data.endDate.split('T')[0]} ${widget.data.endTime}');

    return Container(
      margin: const EdgeInsets.only(top: 15),
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
                      localization.translate('Psychologist name'.pascalCase()),
                      style: TextStyle(
                          fontSize: 12,
                          color: PsykayGreyColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      '${widget.data.partnerFirstName ?? ''} ${widget.data.partnerLastName ?? ''}',
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
                      border: Border.all(
                          color: widget.data.appointmentStatusId <= 5
                              ? PsykayGreenColor
                              : PsykayOrangeColor),
                      color: Colors.white),
                  child: Text(
                    localization
                        .translate(widget.data.appointmentStatusDescription),
                    style: TextStyle(
                        fontSize: 12,
                        color: widget.data.appointmentStatusId <= 5
                            ? PsykayGreenColor
                            : PsykayOrangeColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            localization.translate('Consultation'.pascalCase()),
            style: TextStyle(
                fontSize: 12,
                color: PsykayGreyColor,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            widget.data.productServiceDescription,
            style: TextStyle(
                fontSize: 12,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
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
                      localization.translate('Start from'.pascalCase()),
                      style: TextStyle(
                          fontSize: 12,
                          color: PsykayGreyColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      DateFormat.jm(
                              widget.provider.appointmentProvider.auth.language)
                          .format(startTime),
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localization.translate('to'.pascalCase()),
                      style: TextStyle(
                          fontSize: 12,
                          color: PsykayGreyColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      DateFormat.jm(
                              widget.provider.appointmentProvider.auth.language)
                          .format(endTime),
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
            localization.translate('Price'.pascalCase()),
            style: TextStyle(
                fontSize: 12,
                color: PsykayGreyColor,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            "${localization.translate('Rp'.pascalCase())} ${currencyFormatter.format(widget.data.price)}",
            style: TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          if (widget.data.appointmentStatusId == 1)
            Text(
              localization.translate(
                  'Awaiting PsyKay team to accept your payment request'
                      .capitalize()),
              style: TextStyle(
                  fontSize: 12,
                  color: PsykayGreenColor,
                  fontWeight: FontWeight.w600),
            ),
          if (widget.data.appointmentStatusId == 2 &&
              !widget.data.isRescheduled)
            Text(
              localization.translate(
                  'Awaiting psychologist to accept your appointment request'
                      .capitalize()),
              style: TextStyle(
                  fontSize: 12,
                  color: PsykayGreenColor,
                  fontWeight: FontWeight.w600),
            ),
          if (widget.data.appointmentStatusId == 2 && widget.data.isRescheduled)
            Text(
              localization.translate(widget.data.notes.capitalize()),
              style: TextStyle(
                  fontSize: 12,
                  color: PsykayOrangeColor,
                  fontWeight: FontWeight.w600),
            ),
          if (widget.data.appointmentStatusId == 6)
            Text(
              localization.translate(widget.data.notes.capitalize()),
              style: TextStyle(
                  fontSize: 12,
                  color: PsykayOrangeColor,
                  fontWeight: FontWeight.w600),
            ),
          if (widget.data.appointmentStatusId == 7)
            Text(
              localization.translate(widget.data.notes.capitalize()),
              style: TextStyle(
                  fontSize: 12,
                  color: PsykayOrangeColor,
                  fontWeight: FontWeight.w600),
            ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

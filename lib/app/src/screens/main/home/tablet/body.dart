import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../../constraint.dart';
import '../../../../../../enum.dart';

import '../../../../../helpers/helpers.dart' as helpers;

import '../../../../models/models.dart' as models;

import '../../../shared/shared.dart';

import '../provider/home_provider.dart';

class Body extends StatelessWidget {
  final ScreenSize screenSize = ScreenSize.tablet;
  final Animation<Offset> animation;

  const Body({Key key, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    final padding = MediaQuery.of(context).padding;
    final size = MediaQuery.of(context).size;
    return Consumer<HomeProvider>(
      builder: (_, provider, __) => provider.isInit
          ? helpers.LoadingPouringHourGlass()
          : Stack(
              fit: StackFit.expand,
              children: [
                CustomScrollView(
                  controller: provider.scrollController,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    _AppBar(
                      animation: animation,
                      provider: provider,
                      localization: localization,
                      padding: padding,
                      size: size,
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      if (provider.todayAppointment.isNotEmpty)
                        _TodayAppointmentContainer(
                            provider: provider, localization: localization),
                      if (provider.rescheduleAppointment.isNotEmpty)
                        _RescheduleAppointmentContainer(
                            provider: provider, localization: localization),
                      if (provider.pageLength != 0)
                        _ExpertiseContainer(
                          provider: provider,
                          localization: localization,
                          size: size,
                        ),
                      _TodayArticleContainer(
                          provider: provider,
                          localization: localization,
                          size: size)
                    ])),
                  ],
                ),
                if (provider.isBusy) CustomCircularLoading(padding: padding)
              ],
            ),
    );
  }
}

class _ExpertiseContainer extends StatelessWidget {
  const _ExpertiseContainer(
      {Key key, this.provider, this.localization, this.size})
      : super(key: key);

  final HomeProvider provider;
  final helpers.AppLocalizations localization;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            color: PsykayGreenColor.withOpacity(0.8),
            child: Text(
              localization.translate('Expertise'),
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            height: size.height * 0.5,
            width: size.width,
            constraints: BoxConstraints(minHeight: 430),
            child: PageView.builder(
              controller: provider.pageController,
              itemCount: provider.pageLength,
              itemBuilder: (_, index) => GridView.builder(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                physics: NeverScrollableScrollPhysics(),
                itemCount: provider.mapPageExpertise[index].length,
                itemBuilder: (_, i) => _ItemContainer(
                  provider: provider,
                  expertise: provider.mapPageExpertise[index][i],
                  size: size,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: SmoothPageIndicator(
              controller: provider.pageController,
              count: provider.pageLength,
              effect: ScrollingDotsEffect(
                  strokeWidth: 0.5,
                  activeDotScale: 1.2,
                  radius: 6,
                  spacing: 10,
                  dotHeight: 5.0,
                  dotWidth: 25.0,
                  activeDotColor: PsykayOrangeColor,
                  dotColor: PsykayOrangeLightColor),
            ),
          )
        ],
      ),
    );
  }
}

class _TodayArticleContainer extends StatelessWidget {
  const _TodayArticleContainer({
    Key key,
    this.provider,
    @required this.localization,
    @required this.size,
  }) : super(key: key);

  final HomeProvider provider;
  final helpers.AppLocalizations localization;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            color: PsykayGreenColor.withOpacity(0.8),
            child: Text(
              localization.translate("Today's Article"),
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            height: size.height * 0.18,
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 120),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: provider.articles.length,
              itemBuilder: (_, index) => Container(
                margin: const EdgeInsets.only(left: 20),
                width: size.width * 0.6,
                constraints: BoxConstraints(minWidth: 250),
                color: Colors.blue,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      provider.articles[index].imageUrl,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      top: 3,
                      left: 7,
                      child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.05,
                        constraints: BoxConstraints(minWidth: 200),
                        child: Text(
                          intl.DateFormat.yMMMEd()
                              .format(provider.articles[index].dateTime),
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 3,
                      left: 7,
                      child: Container(
                        width: size.width * 0.55,
                        height: size.height * 0.05,
                        constraints: BoxConstraints(minWidth: 200),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              provider.articles[index].title,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              provider.articles[index].description,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RescheduleAppointmentContainer extends StatelessWidget {
  const _RescheduleAppointmentContainer(
      {Key key, @required this.localization, this.provider})
      : super(key: key);

  final HomeProvider provider;
  final helpers.AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            color: PsykayOrangeColor.withOpacity(0.8),
            child: Text(
              localization.translate('Reschedule Appointment'),
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: provider.rescheduleAppointment.map((value) {
                final startTime = DateTime.parse(
                    '${value.startDate.split('T')[0]} ${value.startTime}');
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                    image:
                                        NetworkImage(value.partnerPictureUrl),
                                    fit: BoxFit.cover),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                '${value.partnerFirstName} ${value.partnerLastName}',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                "${localization.translate('Case')}: ${value.productServiceDescription}",
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${intl.DateFormat.yMMMEd().format(startTime)} ${localization.translate('At')} ${intl.DateFormat('HH:mm').format(startTime)}",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  size: 15,
                                  color: Colors.black54,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "30 ${localization.translate('Minutes')}",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomElevatedButton(
                            onPresses: () => null,
                            localization: localization,
                            text: 'Accept',
                            fontSize: 9,
                            backgroundColor: PsykayGreenColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 7, horizontal: 12),
                          ),
                          const SizedBox(
                            width: 9,
                          ),
                          CustomElevatedButton(
                            onPresses: () => null,
                            localization: localization,
                            text: 'Reject',
                            fontSize: 9,
                            backgroundColor: Colors.red[700],
                            padding: const EdgeInsets.symmetric(
                                vertical: 7, horizontal: 12),
                          ),
                          const SizedBox(
                            width: 9,
                          ),
                          CustomElevatedButton(
                            onPresses: () => null,
                            localization: localization,
                            text: 'Reschedule',
                            fontSize: 9,
                            padding: const EdgeInsets.symmetric(
                                vertical: 7, horizontal: 12),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }).toList())
        ],
      ),
    );
  }
}

class _TodayAppointmentContainer extends StatelessWidget {
  const _TodayAppointmentContainer({
    Key key,
    @required this.localization,
    this.provider,
  }) : super(key: key);

  final HomeProvider provider;
  final helpers.AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            color: PsykayOrangeColor.withOpacity(0.8),
            child: Text(
              localization.translate('Today Appointment'),
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: provider.todayAppointment.map((value) {
                final startTime = DateTime.parse(
                    '${value.startDate.split('T')[0]} ${value.startTime}');
                return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: PsykayGreenLightColor.withOpacity(0.8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 70,
                          color: Colors.transparent,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Image.asset(
                                  'assets/images/home-today-appointment.png',
                                  height: 60,
                                ),
                              ),
                              Positioned(
                                left: 10,
                                bottom: 7,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      localization.translate('Session with'),
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '${value.partnerFirstName} ${value.partnerLastName}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                intl.DateFormat.yMMMEd().format(startTime),
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "${localization.translate('Start at')} ${intl.DateFormat('HH:mm').format(startTime)}",
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        )
                      ],
                    ));
              }).toList())
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  final Animation<Offset> animation;
  final HomeProvider provider;
  final EdgeInsets padding;
  final Size size;
  final helpers.AppLocalizations localization;
  const _AppBar(
      {Key key,
      this.animation,
      this.provider,
      this.padding,
      this.size,
      this.localization})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        title: provider.isFlexibled
            ? null
            : Text(
                provider.userFullName,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
              ),
        actions: provider.isFlexibled
            ? null
            : [
                Center(
                  child: Stack(
                    children: [
                      Image.asset('assets/icons/Icon-bell-normal.png',
                          scale: 0.75),
                      if (provider.unReadNotification > 0)
                        Positioned(
                          top: 0,
                          right: 2,
                          child: Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                color: PsykayOrangeColor,
                                shape: BoxShape.circle),
                            child: Center(
                              child: Text(
                                provider.unReadNotification.toString(),
                                style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
        stretch: true,
        onStretchTrigger: provider.onStretch,
        backgroundColor: Colors.white,
        pinned: true,
        expandedHeight: padding.top + 140,
        stretchTriggerOffset: 30,
        toolbarHeight: 60,
        flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          var top = constraints.biggest.height;
          final appBarHeight = MediaQuery.of(context).padding.top + 60;

          print(MediaQuery.of(context).padding.top);

          return FlexibleSpaceBar(
            centerTitle: true,
            title: AnimatedOpacity(
              opacity: top <= appBarHeight + 30 ? 0.0 : 1.0,
              duration: Duration(milliseconds: 500),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: PsykayGreenLightColor.withOpacity(0.8)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: 110),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                localization.translate('Welcome'),
                                style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                provider.userFullName,
                                style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: PsykayGreenColor,
                          ),
                          child: Text(
                            "${provider.freeAppointment.length ?? 0} ${localization.translate('Kredit')}",
                            style: TextStyle(
                                fontSize: 8, fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      localization.translate('Balance'),
                      style: TextStyle(
                          fontSize: 8,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "${localization.translate('Rp')} ${provider.balance}",
                      style: TextStyle(
                          fontSize: 9,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 3,
                    )
                  ],
                ),
              ),
            ),
            stretchModes: [
              StretchMode.zoomBackground,
              StretchMode.blurBackground
            ],
            background: Stack(
              alignment: Alignment.bottomCenter,
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/home-appbar.png',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter,
                ),
                Positioned(
                  top: padding.top + 20,
                  child: Builder(
                    builder: (_) => SlideTransition(
                      position: animation,
                      transformHitTests: true,
                      textDirection: TextDirection.ltr,
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 46,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: padding.top + 17,
                  right: 15,
                  child: Stack(
                    children: [
                      Image.asset('assets/icons/Icon-bell-normal.png',
                          scale: 0.75),
                      if (provider.unReadNotification > 0)
                        Positioned(
                          top: 0,
                          right: 2,
                          child: Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                color: PsykayOrangeColor,
                                shape: BoxShape.circle),
                            child: Center(
                              child: Text(
                                provider.unReadNotification.toString(),
                                style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
          );
        }));
  }
}

class _ItemContainer extends StatelessWidget {
  const _ItemContainer({Key key, this.provider, this.expertise, this.size})
      : super(key: key);

  final HomeProvider provider;
  final models.StaticData expertise;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => provider.navigateToPreference(context, expertise),
      child: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: size.height * 0.06,
              width: size.width * 0.1,
              constraints: BoxConstraints(minHeight: 80, minWidth: 120),
              child: Image(
                image: NetworkImage(expertise.icon),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Center(
              child: Text(
                expertise.name,
                style: TextStyle(
                    fontSize: 11,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constraint.dart';
import '../../../../../enum.dart';

import '../../../../helpers/helpers.dart' as helpers;

import '../../../models/models.dart';

import '../../shared/shared.dart';

import '../provider/psychologist_provider.dart';

class Body extends StatefulWidget {
  final ScreenSize screenSize = ScreenSize.tablet;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);

    return Consumer<PsychologistProvider>(
      builder: (_, provider, __) => Stack(
        fit: StackFit.expand,
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) =>
                provider.onNotification(scrollNotification),
            child: Column(
              children: [
                _SearchBar(provider: provider, localization: localization),
                ExpandedSection(
                  child: Container(
                    height: provider.heightLoading,
                    color: Colors.transparent,
                  ),
                  value: provider.pixelValue / provider.heightLoading,
                ),
                const SizedBox(
                  height: 10,
                ),
                if (provider.listPartner.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      addAutomaticKeepAlives: true,
                      controller: provider.scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (_, index) => _PsychologistContainer(
                          provider: provider,
                          data: provider.listPartner[index],
                          localization: localization),
                      itemCount: provider.listPartner.length,
                    ),
                  ),
                if (provider.isLoadMore)
                  ExpandedSection(
                    child: Container(
                      height: 60,
                      color: Colors.transparent,
                    ),
                    value: 1,
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    Key key,
    this.provider,
    @required this.localization,
  }) : super(key: key);

  final PsychologistProvider provider;
  final helpers.AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              height: 40,
              child: Theme(
                data: new ThemeData(
                  primaryColor: PsykayGreenColor,
                  primaryColorDark: Colors.blue,
                ),
                child: TextField(
                  controller: provider.searchController,
                  onChanged: provider.onSearch,
                  scrollPadding: const EdgeInsets.all(0),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: localization.translate('Search Psychologist'),
                      hintStyle: TextStyle(
                          color: PsykayGreyLightColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(width: 1.5, color: PsykayGreenColor),
                      ),
                      suffixIcon: Icon(
                        Icons.search,
                        color: PsykayGreenColor,
                      )),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 9,
          ),
          Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PsykayGreenColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: ImageIcon(
              AssetImage('assets/icons/icon-sort.png'),
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

class _PsychologistContainer extends StatefulWidget {
  const _PsychologistContainer({
    Key key,
    this.provider,
    this.data,
    @required this.localization,
  }) : super(key: key);

  final PsychologistProvider provider;
  final Partner data;
  final helpers.AppLocalizations localization;

  @override
  __PsychologistContainerState createState() => __PsychologistContainerState();
}

class __PsychologistContainerState extends State<_PsychologistContainer>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 1,
            offset: Offset(0, 0), // changes position of shadow
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
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: widget.data.pictureUrl == null
                          ? null
                          : DecorationImage(
                              image: NetworkImage(widget.data.pictureUrl),
                              fit: BoxFit.cover),
                      shape: BoxShape.circle),
                  child: widget.data.pictureUrl != null
                      ? null
                      : Icon(
                          Icons.person,
                          size: 60,
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
                      '${widget.data.firstName} ${widget.data.lastName}',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${widget.data.level}",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "${widget.localization.translate('Start from')}  ${widget.localization.translate('Rp')} ${widget.data.level} / ${widget.localization.translate('Session')}",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 23,
                child: CustomElevatedButton(
                  onPresses: () => null,
                  localization: widget.localization,
                  text: 'Appointments',
                  fontSize: 10,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.thumb_up_alt_rounded,
                    color: PsykayGreenColor,
                    size: 17,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "150",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ExpandedSection extends StatefulWidget {
  final Widget child;
  final double value;
  ExpandedSection({this.value, this.child});

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection>
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
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
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
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    expandController.animateTo(widget.value);
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

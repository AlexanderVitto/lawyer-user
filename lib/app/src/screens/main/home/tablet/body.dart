import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../constraint.dart';

import '../../../../../helpers/helpers.dart' as helpers;
import '../../../../../utils/utils.dart' as utils;

import '../../../shared/shared.dart';

import '../provider/home_provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    final padding = MediaQuery.of(context).padding;
    return Consumer<HomeProvider>(
      builder: (_, provider, __) => CustomScrollView(
        controller: provider.scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
              title: provider.isFlexibled
                  ? null
                  : Text(
                      'Alexander Vitto',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
                    ),
              actions: provider.isFlexibled
                  ? null
                  : [
                      Icon(
                        Icons.notifications,
                        color: PsykayGreenColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
              stretch: true,
              onStretchTrigger: onStretch,
              backgroundColor: Colors.white,
              pinned: true,
              expandedHeight: padding.top + 250,
              stretchTriggerOffset: 150,
              toolbarHeight: 60,
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                top = constraints.biggest.height;
                final appBarHeight = MediaQuery.of(context).padding.top + 60;

                print(MediaQuery.of(context).padding.top);

                return FlexibleSpaceBar(
                  centerTitle: true,
                  title: AnimatedOpacity(
                    opacity: top <= appBarHeight + 100 ? 0.0 : 1.0,
                    duration: Duration(milliseconds: 500),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
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
                                      'Alexander',
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
                                  localization.translate('12 Kredit'),
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
                            'Rp 0',
                            style: TextStyle(
                                fontSize: 9,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            localization
                                .translate('How can we assist you today?'),
                            style: TextStyle(
                                fontSize: 9,
                                color: Colors.black54,
                                fontWeight: FontWeight.w400),
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
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 46,
                        ),
                      ),
                    ],
                  ),
                );
              })),
          SliverList(
              delegate: SliverChildListDelegate(
                  List.generate(10, (index) => CustomWidget(index)).toList())),
        ],
      ),
    );
  }

  Future onStretch() async {
    print('onStretch');

    return;
  }
}

class CustomWidget extends StatelessWidget {
  CustomWidget(this._index) {
    debugPrint('initialize: $_index');
  }

  final int _index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: (_index % 2 != 0) ? Colors.white : Colors.grey,
      child:
          Center(child: Text('index: $_index', style: TextStyle(fontSize: 40))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../constraint.dart';
import '../../../../../enum.dart';
import '../../../../helpers/helpers.dart' as helpers;

import '../splash_screen.dart';

class SplashBody extends StatelessWidget {
  final List<Item> items;
  final int page;
  final PageController pageController;
  final Function onPageViewChange;

  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  const SplashBody(
      {Key key,
      this.items,
      this.page,
      this.pageController,
      this.onPageViewChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    print('Rebuild $page ');
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 50),
              height: 480,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: items.length,
                  onPageChanged: onPageViewChange,
                  itemBuilder: (_, __) => _ItemContainer(
                      imageAsset: items[page].imageAsset,
                      title: localization.translate(items[page].title),
                      description:
                          localization.translate(items[page].description))),
            ),
            Center(
                child: SmoothPageIndicator(
                    controller: pageController,
                    count: items.length,
                    effect: ScrollingDotsEffect(
                        strokeWidth: 0.5,
                        activeDotScale: 1.2,
                        radius: 6,
                        spacing: 10,
                        dotHeight: 5.0,
                        dotWidth: 25.0,
                        activeDotColor: PsykayOrangeColor,
                        dotColor: PsykayGreyLightColor))),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedContainer(
                        height: page == 0 ? 0 : 35,
                        width: page == 0 ? 0 : 100,
                        duration: Duration(milliseconds: 400),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border:
                                Border.all(color: PsykayOrangeColor, width: 3)),
                        curve: Curves.linearToEaseOut,
                        child: page == 0
                            ? Container()
                            : Center(
                                child: FlatButton(
                                    child: Text(localization.translate('Prev'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: PsykayOrangeColor)),
                                    onPressed: () {
                                      pageController.previousPage(
                                          duration: SplashBody._kDuration,
                                          curve: SplashBody._kCurve);
                                    }))),
                    page == 0 ? Container() : SizedBox(width: 15.0),
                    AnimatedContainer(
                        height: 35,
                        width: page >= items.length - 1 ? 90 : 100,
                        duration: Duration(milliseconds: 400),
                        decoration: BoxDecoration(
                            color: page >= items.length - 1
                                ? PsykayGreenColor
                                : Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border:
                                Border.all(color: PsykayGreenColor, width: 3)),
                        curve: Curves.linearToEaseOut,
                        child: page >= items.length - 1
                            ? Center(
                                child: FlatButton(
                                    child: Text(localization.translate('Login'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: page >= items.length - 1
                                                ? Colors.white
                                                : PsykayGreenColor)),
                                    onPressed: () {
                                      // Navigator.of(context)
                                      //     .pushNamed(SignInScreen.routeName);
                                    }))
                            : Center(
                                child: FlatButton(
                                    child: Text(localization.translate('Next'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: PsykayGreenColor)),
                                    onPressed: () {
                                      pageController.nextPage(
                                          duration: SplashBody._kDuration,
                                          curve: SplashBody._kCurve);
                                    })))
                  ]),
            )
          ]),
    );
  }
}

class _ItemContainer extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String description;

  const _ItemContainer({Key key, this.imageAsset, this.title, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset(
            imageAsset,
            height: 300,
          ),
          const SizedBox(height: 25),
          Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Text(title,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 15.0),
            Text(description,
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 14,
                    fontWeight: FontWeight.w400))
          ])
        ],
      ),
    );
  }
}

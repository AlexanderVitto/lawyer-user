import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../constraint.dart';
import '../../../../../enum.dart';
import '../../../../helpers/helpers.dart' as helpers;

import '../splash_screen.dart';

class Body extends StatelessWidget {
  final List<Item> items;
  final int page;
  final PageController pageController;
  final Function onPageViewChange;

  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  const Body(
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
              height: 500,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: items.length,
                  onPageChanged: onPageViewChange,
                  itemBuilder: (_, index) => _ItemContainer(
                      imageAsset: items[index].imageAsset,
                      title: localization.translate(items[index].title),
                      description:
                          localization.translate(items[index].description))),
            ),
            Center(
                child: SmoothPageIndicator(
                    controller: pageController,
                    count: items.length,
                    effect: ScrollingDotsEffect(
                        strokeWidth: 0.3,
                        activeDotScale: 1.4,
                        radius: 7,
                        spacing: 11,
                        dotHeight: 6.0,
                        dotWidth: 27.0,
                        activeDotColor: PsykayOrangeColor,
                        dotColor: PsykayGreyLightColor))),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedContainer(
                        height: page == 0 ? 0 : 45,
                        width: page == 0 ? 0 : 110,
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(9)),
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
                                            fontSize: 14,
                                            color: PsykayOrangeColor)),
                                    onPressed: () {
                                      pageController.previousPage(
                                          duration: Body._kDuration,
                                          curve: Body._kCurve);
                                    }))),
                    page == 0 ? Container() : SizedBox(width: 20.0),
                    AnimatedContainer(
                        height: 45,
                        width: page >= items.length - 1 ? 100 : 110,
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                            color: page >= items.length - 1
                                ? PsykayGreenColor
                                : Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(9)),
                            border:
                                Border.all(color: PsykayGreenColor, width: 3)),
                        curve: Curves.linearToEaseOut,
                        child: page >= items.length - 1
                            ? Center(
                                child: FlatButton(
                                    child: Text(localization.translate('Login'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
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
                                            fontSize: 14,
                                            color: PsykayGreenColor)),
                                    onPressed: () {
                                      pageController.nextPage(
                                          duration: Body._kDuration,
                                          curve: Body._kCurve);
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
            height: 350,
          ),
          const SizedBox(height: 35),
          Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Text(title,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 20.0),
            Text(description,
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 16,
                    fontWeight: FontWeight.w400))
          ])
        ],
      ),
    );
  }
}

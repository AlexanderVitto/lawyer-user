import 'package:flutter/material.dart';

import '../../../../constraint.dart';

import 'tablet/body.dart' as tablet;
import 'phone/body.dart' as phone;
import 'mini/body.dart' as mini;

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash-screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController _controller;

  int _page = 0;

  final List<Item> _items = [
    Item(
        imageAsset: 'assets/images/splash-1.png',
        title: 'Psychologist for your every need',
        description:
            'Hassle-free, accessible and consult at your own convenience.'),
    Item(
        imageAsset: 'assets/images/splash-2.png',
        title: 'Affordable Online Consultation',
        description:
            'Experience professionalism and high-quality counselling you would expect from an in-office counsellor at an affordable price.'),
    Item(
        imageAsset: 'assets/images/splash-3.png',
        title: 'Stay Connected, Stay Positive',
        description:
            'Keep your mind positive, get in touch with professional psychologists and overcome your problems.'),
    Item(
        imageAsset: 'assets/images/splash-4.png',
        title: 'Confidential and Secured',
        description:
            'We keep your information and conversation strictly confidential and secured.')
  ];

  @override
  void initState() {
    super.initState();

    _controller = new PageController(initialPage: _page);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        print('Width ${constraints.maxWidth}');
        print('Height ${constraints.maxHeight}');

        if (constraints.maxWidth > TabletThreshold) {
          return tablet.Body(
            items: _items,
            page: _page,
            pageController: _controller,
            onPageViewChange: _onPageViewChange,
          );
        } else if (constraints.maxWidth > PhoneThreshold &&
            constraints.maxWidth <= TabletThreshold) {
          return phone.Body(
            items: _items,
            page: _page,
            pageController: _controller,
            onPageViewChange: _onPageViewChange,
          );
        } else {
          return mini.Body(
            items: _items,
            page: _page,
            pageController: _controller,
            onPageViewChange: _onPageViewChange,
          );
        }
      }),
    );
  }

  void _onPageViewChange(int page) {
    print("Current Page: " + _page.toString());

    setState(() {
      _page = page;
    });
  }
}

class Item {
  final String imageAsset;
  final String title;
  final String description;

  Item({this.imageAsset, this.title, this.description});
}

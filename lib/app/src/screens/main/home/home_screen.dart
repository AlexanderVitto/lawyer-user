import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constraint.dart';

import 'provider/home_provider.dart';
import 'tablet/body.dart' as tablet;
import 'phone/body.dart' as phone;
import 'mini/body.dart' as mini;

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  final Animation<Offset> animation;

  const HomeScreen({Key key, this.animation}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<HomeProvider>(context, listen: false).initResource();
  }

  @override
  void dispose() {
    Provider.of<HomeProvider>(context, listen: false).close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          print('Width ${constraints.maxWidth}');
          print('Height ${constraints.maxHeight}');

          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Provider.of<HomeProvider>(context, listen: false)
                .setAppBarPosition(padding.top);
          });

          if (constraints.maxWidth > TabletThreshold) {
            return tablet.Body(
              animation: widget.animation,
            );
          } else if (constraints.maxWidth > PhoneThreshold &&
              constraints.maxWidth <= TabletThreshold) {
            return phone.Body(
              animation: widget.animation,
            );
          } else {
            return mini.Body(
              animation: widget.animation,
            );
          }
        },
      ),
    );
  }
}

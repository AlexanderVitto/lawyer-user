import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constraint.dart';

import '../../../../helpers/helpers.dart' as helpers;

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
  HomeProvider provider;
  @override
  void initState() {
    super.initState();

    provider = Provider.of<HomeProvider>(context, listen: false);
    provider.initResource();
  }

  @override
  void dispose() {
    provider.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    final padding = MediaQuery.of(context).padding;
    provider = Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          print('Width ${constraints.maxWidth}');
          print('Height ${constraints.maxHeight}');

          WidgetsBinding.instance.addPostFrameCallback((_) {
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
      floatingActionButton: Consumer<HomeProvider>(
        builder: (_, cProvider, __) => cProvider.carts.isEmpty
            ? Container()
            : FloatingActionButton(
                onPressed: () =>
                    cProvider.navigateToCart(context, HomeScreen.routeName),
                tooltip: localization.translate('Appointment cart'),
                backgroundColor: PsykayOrangeColor,
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}

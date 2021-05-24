import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart' as utils;
import '../../config/config.dart' as config;
import '../../helpers/helpers.dart' as helpers;
import '../../native/payment_gateway.dart';
import '../../splash_animation.dart';

class TestingScreen extends StatelessWidget {
  static const routeName = '/testing-screen';
  static const parentKey = 'testing_screen';

  final utils.AnalyticUtils _analytics = config.locator<utils.AnalyticUtils>();

  @override
  Widget build(BuildContext context) {
    final connectivity =
        Provider.of<utils.ConnectivityUtils>(context, listen: false);
    return SafeArea(
      child: config.FlavorBanner(
        child: Scaffold(
            appBar: AppBar(
              title:
                  Text(helpers.AppLocalizations.of(context).translate('name')),
            ),
            backgroundColor: Colors.white,
            // body:
            //   Center(
            //     child: Text(FlavorConfig.instance.name),
            //   ),
            // )
            body: FutureBuilder(
              future: connectivity.initialLoad(),
              builder: (_, connectivitySnapshot) =>
                  connectivitySnapshot.connectionState ==
                          ConnectionState.waiting
                      ? SplashAnimation()
                      : Consumer<utils.ConnectivityUtils>(
                          builder: (_, connectivityBuilder, __) => Column(
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                child: Center(
                                  child: StreamBuilder(
                                    stream: PaymentGateway.paymentStatus,
                                    builder: (ctx, snapshot) {
                                      if (snapshot.hasData) {
                                        return Column(
                                          children: [
                                            Text(
                                                'test ${connectivityBuilder.pageText}'),
                                            Text(
                                                'status : ${snapshot.data['status']}'),
                                            Text(
                                                'transaction id : ${snapshot.data['transaction_id']}'),
                                          ],
                                        );
                                      }
                                      return Text(
                                          'test ${connectivityBuilder.pageText}');
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Center(
                                      child: FlatButton(
                                          onPressed: () async {
                                            // await PaymentGateway.payment(Item.toMap);
                                            config
                                                .locator<utils.LogUtils>(
                                                    param1: '/home',
                                                    param2: true)
                                                .debug(
                                                    method: 'FlatButton',
                                                    message: 'Coba Ajaaaaaaa');

                                            _analytics.setUserProperties(
                                                name: 'user_name',
                                                value: 'Joko');
                                            print('selesai');
                                          },
                                          child: Text('Pay')))),
                            ],
                          ),
                        ),
            )),
      ),
    );
  }
}

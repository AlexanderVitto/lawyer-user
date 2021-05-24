import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constraint.dart';
import '../../../utils/utils.dart' as utils;

class SignUpScreen extends StatelessWidget {
  static const routeName = '/signup-screen';

  @override
  Widget build(BuildContext context) {
    final connectivity =
        Provider.of<utils.ConnectivityUtils>(context, listen: false);
    return Scaffold(
      backgroundColor: PsykayGreenColor,
      // body: (_, __)=>Container(),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../constraint.dart';
import '../../../helpers/helpers.dart' as helpers;

class TopImage extends StatelessWidget {
  const TopImage({
    Key key,
    @required this.name,
    this.containerHeight = 300,
    this.logoHeight = 35,
    this.withLogo = true,
    @required this.localization,
  }) : super(key: key);

  final String name;
  final double containerHeight;
  final double logoHeight;
  final bool withLogo;
  final helpers.AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: containerHeight,
          width: double.infinity,
          color: Colors.white,
          child: Image.asset(
            name,
            alignment: Alignment.bottomCenter,
          ),
        ),
        if (withLogo)
          Positioned(
            top: 45,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: logoHeight,
                ),
                Text(
                    localization
                        .translate('Trusted Verified Online Counselling'),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: PsykayGreenColor))
              ],
            ),
          )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../constraint.dart';

class LoadingPouringHourGlass extends StatelessWidget {
  final double iconSize;

  const LoadingPouringHourGlass({Key key, this.iconSize = 60})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedContainer(
        height: size.height,
        width: size.width,
        color: Colors.grey[200].withOpacity(0.35),
        duration: const Duration(milliseconds: 1000),
        child: Center(
            child: SpinKitPouringHourglass(
                size: iconSize,
                color: PsykayOrangeColor,
                duration: const Duration(milliseconds: 1200))));
  }
}

class LoadingPumpingHeart extends StatelessWidget {
  final double iconSize;

  const LoadingPumpingHeart({Key key, this.iconSize = 60}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedContainer(
        height: size.height,
        width: size.width,
        color: Colors.grey[200].withOpacity(0.35),
        duration: const Duration(milliseconds: 1000),
        child: Center(
            child: SpinKitPumpingHeart(
                size: iconSize,
                color: PsykayOrangeColor,
                duration: const Duration(milliseconds: 1200))));
  }
}

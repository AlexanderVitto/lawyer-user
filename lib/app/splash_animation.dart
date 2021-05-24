import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Lottie.asset('assets/logoJSON.json'));
  }
}

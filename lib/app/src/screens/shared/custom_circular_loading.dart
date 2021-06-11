import 'package:flutter/material.dart';

class CustomCircularLoading extends StatelessWidget {
  const CustomCircularLoading({
    Key key,
    @required this.padding,
  }) : super(key: key);

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: padding.top + 30,
        left: 0,
        right: 0,
        child: Align(
          alignment: Alignment.center,
          child: Container(
              padding: const EdgeInsets.all(3),
              height: 27,
              width: 27,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(50)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: CircularProgressIndicator()),
        ));
  }
}

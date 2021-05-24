import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart' as helpers;

class CustomeElevatedButton extends StatelessWidget {
  final Function onPresses;
  final String text;
  final Color foregroundColor;
  final Color backgroundColor;
  final Color borderSideColor;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomeElevatedButton(
      {Key key,
      @required this.onPresses,
      @required this.localization,
      this.text = '',
      this.foregroundColor = Colors.white,
      this.backgroundColor,
      this.borderSideColor,
      this.fontSize = 18,
      this.fontWeight = FontWeight.w800})
      : super(key: key);

  final helpers.AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPresses,
      child: Text(
        localization.translate(text).toUpperCase(),
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      ),
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(foregroundColor),
          backgroundColor: MaterialStateProperty.all<Color>(
              backgroundColor ?? Theme.of(context).buttonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                      color:
                          borderSideColor ?? Theme.of(context).buttonColor)))),
    );
  }
}

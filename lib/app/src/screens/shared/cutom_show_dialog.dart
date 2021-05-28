import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart' as helpers;
import 'custome_elevated_button.dart';

Future<T> successDialog<T>(
    {@required BuildContext context,
    bool barrierDismissible = false,
    double iconSize = 96,
    @required String title,
    double titleFontSize = 16,
    String description = '',
    double descriptionFontSize = 12,
    @required buttonText,
    double buttonFontSize = 14,
    double sizedBox1 = 20,
    double sizedBox2 = 5,
    double sizedBox3 = 30}) {
  final localization = helpers.AppLocalizations.of(context);

  return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 1,
            backgroundColor: Colors.white,
            child: Container(
              constraints: BoxConstraints(maxHeight: 500),
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/success.png',
                    height: iconSize,
                    width: iconSize,
                  ),
                  SizedBox(
                    height: sizedBox1,
                  ),
                  Text(
                    localization.translate(title),
                    style: TextStyle(
                        fontSize: titleFontSize, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: sizedBox2,
                  ),
                  Text(
                    localization.translate(description),
                    style: TextStyle(
                        fontSize: descriptionFontSize,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: sizedBox3,
                  ),
                  CustomeElevatedButton(
                    text: buttonText,
                    localization: localization,
                    fontSize: buttonFontSize,
                    fontWeight: FontWeight.w400,
                    onPresses: () => Navigator.of(context).pop(),
                  )
                ],
              ),
            ),
          ));
}

Future<T> errorDialog<T>(
    {@required BuildContext context,
    bool barrierDismissible = false,
    double iconSize = 50,
    @required String title,
    double titleFontSize = 16,
    String description = '',
    double descriptionFontSize = 14,
    @required buttonText,
    double buttonFontSize = 14,
    double sizedBox1 = 20,
    double sizedBox2 = 5,
    double sizedBox3 = 30}) {
  final localization = helpers.AppLocalizations.of(context);

  return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 1,
            backgroundColor: Colors.white,
            child: Container(
              constraints: BoxConstraints(maxHeight: 500),
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                    size: iconSize,
                  ),
                  SizedBox(
                    height: sizedBox1,
                  ),
                  Text(
                    localization.translate(title),
                    style: TextStyle(
                        fontSize: titleFontSize, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: sizedBox2,
                  ),
                  Text(
                    localization.translate(description),
                    style: TextStyle(
                        fontSize: descriptionFontSize,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: sizedBox3,
                  ),
                  CustomeElevatedButton(
                    text: buttonText,
                    localization: localization,
                    fontSize: buttonFontSize,
                    fontWeight: FontWeight.w400,
                    onPresses: () => Navigator.of(context).pop(),
                  )
                ],
              ),
            ),
          ));
}

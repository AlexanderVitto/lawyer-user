import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'connectivity_utils.dart';
import '../helpers/helpers.dart' as helpers;

class ConnectionInfo extends StatelessWidget {
  final double topMargin;
  final double iconSize;
  final double fontSize;
  final Color textColor;

  const ConnectionInfo(
      {Key key,
      this.topMargin = 20,
      this.iconSize = 15,
      this.fontSize = 14,
      this.textColor = Colors.black87})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);

    return Consumer<Connection>(
        builder: (_, connectionProvider, __) => !connectionProvider.isConnected
            ? Container()
            : Positioned(
                top: topMargin,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  constraints: BoxConstraints(minWidth: 100),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(width: 2.0, color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                          color: Colors.red, size: iconSize),
                      const SizedBox(width: 5.0),
                      Text(
                        localization.translate('No internet!'),
                        style: TextStyle(
                            fontSize: fontSize,
                            color: textColor,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ));
  }
}

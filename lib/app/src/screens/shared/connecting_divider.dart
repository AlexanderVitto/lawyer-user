import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart' as helpers;

class ConnectingDivider extends StatelessWidget {
  const ConnectingDivider({
    Key key,
    @required this.localization,
  }) : super(key: key);

  final helpers.AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              color: Colors.white,
              height: 1.5,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            localization.translate('Or connect using').toUpperCase(),
            style: TextStyle(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Divider(
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

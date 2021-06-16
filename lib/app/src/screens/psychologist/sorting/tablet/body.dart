import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../constraint.dart';
import '../../../../../../enum.dart';

import '../../../../../helpers/helpers.dart' as helpers;

import '../../provider/psychologist_provider.dart';

class Body extends StatelessWidget {
  final ScreenSize screenSize = ScreenSize.tablet;

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);

    return Consumer<PsychologistProvider>(
        builder: (_, provider, child) => SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    child,
                    ..._sortingElementBuilder(provider, localization)
                  ],
                ),
              ),
            ),
        child: Text(
          localization.translate('Sort By'),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ));
  }

  List<Widget> _sortingElementBuilder(
      PsychologistProvider provider, helpers.AppLocalizations localization) {
    List<Widget> widget = [];

    for (int i = 0; i < provider.sortingData.length; i++) {
      widget.add(const SizedBox(
        height: 5,
      ));

      widget.add(InkWell(
        onTap: () => provider.setSortBy(provider.sortingData[i].sortValue),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
                width: 25,
                child: Icon(
                  provider.sortingData[i].sortValue == provider.sortBy
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: PsykayGreenColor,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  localization.translate(provider.sortingData[i].name),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
      ));

      if (i < provider.sortingData.length - 1) {
        widget.add(
          Divider(
            color: PsykayGreenColor,
            indent: 15,
            endIndent: 15,
            thickness: 1.0,
          ),
        );
      }
    }
    return widget;
  }
}

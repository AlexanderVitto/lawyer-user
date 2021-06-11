import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constraint.dart';
import '../../../../../enum.dart';

import '../../../../helpers/helpers.dart' as helpers;

import '../../../models/models.dart' as models;

import '../../shared/shared.dart';

import '../provider/preference_provider.dart';

class Body extends StatelessWidget {
  final ScreenSize screenSize = ScreenSize.mini;
  final models.StaticData staticData;

  const Body({Key key, this.staticData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    return Consumer<PreferenceProvider>(
      builder: (_, provider, __) => CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Text(
                  localization.translate(
                      'Do you have any preference(s) for your Psychologist?'),
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  localization.translate('You may choose more than one'),
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              _preferencesContainer(provider),
              _nextBtn(provider, context, localization),
            ]),
          )
        ],
      ),
    );
  }

  Padding _nextBtn(PreferenceProvider provider, BuildContext context,
      helpers.AppLocalizations localization) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomElevatedButton(
            onPresses: () => provider.next(staticData, context),
            localization: localization,
            text: 'Next',
            fontSize: 12,
            backgroundColor: Colors.white,
            foregroundColor: PsykayGreenColor,
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
          ),
        ],
      ),
    );
  }

  // Builders

  Container _preferencesContainer(PreferenceProvider provider) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: _buildListPreference(provider),
      ),
    );
  }

  List<Widget> _buildListPreference(PreferenceProvider provider) {
    final widgets = <Widget>[];

    for (var i = 0; i < provider.preferences.length; i++) {
      if (i == 0) {
        widgets.add(_LabeledCheckbox(
          preferenceProvider: provider,
          preference: provider.preferences[i],
        ));
      } else {
        widgets.add(const Divider(
          color: PsykayGreenColor,
          indent: 30,
          endIndent: 30,
          thickness: 1.0,
        ));

        widgets.add(_LabeledCheckbox(
          preferenceProvider: provider,
          preference: provider.preferences[i],
        ));
      }
    }

    return widgets;
  }
}

class _LabeledCheckbox extends StatelessWidget {
  const _LabeledCheckbox({this.preferenceProvider, this.preference});

  final PreferenceProvider preferenceProvider;
  final models.Preference preference;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => preferenceProvider.selectAndReset(preference),
      child: ListTile(
        title: Text(preference.name),
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: preference.isSelected
                ? Icon(
                    Icons.radio_button_checked,
                    size: 25.0,
                    color: PsykayGreenColor,
                  )
                : Icon(
                    Icons.radio_button_unchecked,
                    size: 25.0,
                    color: Colors.black54,
                  ),
          ),
        ),
      ),
    );
  }
}

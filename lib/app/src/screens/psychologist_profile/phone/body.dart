import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:psykay_userapp_v2/app/src/screens/shared/custom_elevated_button.dart';

import '../../../../../constraint.dart';

import '../../../../helpers/helpers.dart' as helpers;

import '../../../models/models.dart' as models;

import '../provider/psychologist_profile_provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);

    return Consumer<PsychologistProfileProvider>(
      builder: (_, provider, __) => provider.isInit
          ? helpers.LoadingPouringHourGlass()
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _TopProfile(
                    provider: provider,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 7.0),
                    child: Text(
                      localization.translate('Details').toUpperCase(),
                      style: TextStyle(
                          fontSize: 18,
                          color: PsykayGreenColor,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Divider(
                    color: PsykayGreenColor,
                    thickness: 1,
                  ),
                  _qualificationsBuilder(localization, provider),
                  Divider(
                    color: PsykayGreenColor,
                    thickness: 1,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          localization.translate('Working hours').toUpperCase(),
                          style: TextStyle(
                              fontSize: 14,
                              color: PsykayGreenColor,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (provider.partnerDetail.partnerSchedules != null)
                          ..._workingHourBuilder(provider)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: CustomElevatedButton(
                      onPresses: () =>
                          provider.navigateToBookAppointment(context),
                      localization: localization,
                      fontSize: 14,
                      text: 'Set up an appointment',
                    ),
                  )
                ],
              ),
            ),
    );
  }

  // Builders

  Padding _qualificationsBuilder(helpers.AppLocalizations localization,
      PsychologistProfileProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            localization.translate('Qualifications').toUpperCase(),
            style: TextStyle(
                fontSize: 14,
                color: PsykayGreenColor,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 10,
          ),
          if (provider.partnerDetail != null)
            ...provider.partnerDetail.partnerExpertises.map((value) {
              models.StaticData expertise =
                  provider.staticDataProvider.expertiseData.firstWhere(
                      (expertiseData) =>
                          expertiseData.id == value.masterExpertiseId,
                      orElse: () => null);

              return expertise == null
                  ? Container()
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            expertise.name ?? '',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black45,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Icon(
                          Icons.check_circle_outline_outlined,
                          color: value.serviceEnable
                              ? PsykayOrangeColor.withOpacity(0.7)
                              : PsykayGreyLightColor,
                        )
                      ],
                    );
            }).toList()
        ],
      ),
    );
  }

  List<Widget> _workingHourBuilder(PsychologistProfileProvider provider) {
    print('_workingHourBuilder');
    List<Widget> widget = [];

    provider.mapAvailability.forEach((key, value) {
      for (int i = 0; i < value.length; i++) {
        if (i == 0) {
          widget.add(Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    '${DateFormat('EEEE', provider.staticDataProvider.auth.language).format(value[i].startTime)}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    '${DateFormat('HH:mm', provider.staticDataProvider.auth.language).format(value[i].startTime)} - ${DateFormat('HH:mm', provider.staticDataProvider.auth.language).format(value[i].endTime)}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ));
        } else {
          widget.add(Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    '${DateFormat('HH:mm', provider.staticDataProvider.auth.language).format(value[i].startTime)} - ${DateFormat('HH:mm', provider.staticDataProvider.auth.language).format(value[i].endTime)}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ));
        }
      }
    });

    return widget;
  }
}

class _TopProfile extends StatelessWidget {
  const _TopProfile({Key key, this.provider}) : super(key: key);

  final PsychologistProfileProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  color: PsykayGreyLightColor,
                  image: provider.partnerDetail.pictureUrl == null
                      ? null
                      : DecorationImage(
                          image:
                              NetworkImage(provider.partnerDetail.pictureUrl),
                          fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
              child: provider.partnerDetail.pictureUrl != null
                  ? null
                  : Icon(
                      Icons.person,
                      size: 90,
                      color: Colors.grey,
                    )),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${provider.partnerDetail.firstName} ${provider.partnerDetail.lastName}',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "${provider.partnerDetail.level}",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  "${DateFormat.yMMMd(provider.staticDataProvider.auth.language).format(DateTime.parse(provider.partnerDetail.dateOfBirth))}",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  "${provider.partnerDetail.country}",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

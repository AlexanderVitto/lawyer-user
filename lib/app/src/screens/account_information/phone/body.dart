import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../constraint.dart';
import '../../../../helpers/helpers.dart' as helpers;

import '../../../models/models.dart' as models;
import '../../../providers/providers.dart' as providers;

import '../../update_profile/update_profile_screen.dart';

import '../provider/account_information_provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    return Consumer<AccountInformationProvider>(
      builder: (_, provider, __) => ListView(
        padding: const EdgeInsets.symmetric(vertical: 15),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 10.0),
            child: Text(
              localization.translate('Email address'.pascalCase()),
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: PsykayGreyColor,
                spreadRadius: 0.5,
                blurRadius: 0.5,
                offset: Offset(0, 0.5), // changes position of shadow
              )
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    provider.userData.email ?? '',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Text(
                  localization.translate('Change'.toUpperCase()),
                  style: TextStyle(
                      fontSize: 12,
                      color: PsykayOrangeColor,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
            child: Text(
              localization.translate('Password'.pascalCase()),
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: PsykayGreyColor,
                spreadRadius: 0.5,
                blurRadius: 0.5,
                offset: Offset(0, 0.5), // changes position of shadow
              )
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    '●●●●●●',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Text(
                  localization.translate('Change'.toUpperCase()),
                  style: TextStyle(
                      fontSize: 12,
                      color: PsykayOrangeColor,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    localization.translate('Personal data'.pascalCase()),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => Navigator.of(context)
                      .pushNamed(UpdateProfileScreen.routeName),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.black38,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        localization.translate('Update'.toUpperCase()),
                        style: TextStyle(
                            fontSize: 14,
                            color: PsykayOrangeColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: PsykayGreyColor,
                spreadRadius: 0.5,
                blurRadius: 0.5,
                offset: Offset(0, 0.5), // changes position of shadow
              )
            ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PersonalDataItem(
                  localization: localization,
                  description: 'First name',
                  data: provider.userData.firstName ?? '',
                ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                _PersonalDataItem(
                  localization: localization,
                  description: 'Last name',
                  data: provider.userData.lastName ?? '',
                ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                _PersonalDataItem(
                  localization: localization,
                  description: 'Salutation',
                  data: provider.userData.salutation ?? '',
                ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                _PersonalDataItem(
                  localization: localization,
                  description: 'Gender',
                  data: provider.userData.sexId == null
                      ? ''
                      : provider.genderStatus.name,
                ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                _PersonalDataItem(
                  localization: localization,
                  description: 'Birth date',
                  data: provider.userData.dateOfBirth == null
                      ? ''
                      : DateFormat.yMMMMd(provider.auth.language).format(
                          DateTime.parse(
                              provider.userData.dateOfBirth.split('T')[0])),
                ),
                if (provider.userData.idType != null)
                  Column(
                    children: [
                      const Divider(
                        color: Colors.grey,
                        height: 1,
                      ),
                      _PersonalDataItem(
                        localization: localization,
                        description: provider.userData.idType == null
                            ? 'ID Card'
                            : provider.cardType.name,
                        data: provider.userData.idNumber ?? '',
                      ),
                    ],
                  ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                _PersonalDataItem(
                  localization: localization,
                  description: 'Religion',
                  data: provider.userData.religionId == null
                      ? ''
                      : provider.religion.name,
                ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                _PersonalDataItem(
                  localization: localization,
                  description: 'Marital status',
                  data: provider.userData.maritalStatusId == null
                      ? ''
                      : provider.maritalStatus.name,
                ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                _PersonalDataItem(
                  localization: localization,
                  description: 'Ethnic',
                  data: provider.userData.ethnic ?? '',
                ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                _PersonalDataItem(
                  localization: localization,
                  description: 'Occupation',
                  data: provider.userData.occupation == null
                      ? ''
                      : provider.occupation.name,
                ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                _PersonalDataItem(
                  localization: localization,
                  description: 'Phone number',
                  data: provider.userData.phoneNumber ?? '',
                ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                _PersonalDataItem(
                  localization: localization,
                  description: 'Mobile number',
                  data: provider.userData.mobileNumber ?? '',
                ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                _PersonalDataItem(
                  localization: localization,
                  description: 'Country',
                  data: provider.userData.country ?? '',
                ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                _PersonalDataItem(
                  localization: localization,
                  description: 'Address',
                  data: provider.userData.address ?? '',
                ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                _PersonalDataItem(
                  localization: localization,
                  description: 'Region 1',
                  data: provider.userData.region1 ?? '',
                ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                _PersonalDataItem(
                  localization: localization,
                  description: 'Region 2',
                  data: provider.userData.region2 ?? '',
                ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                _PersonalDataItem(
                  localization: localization,
                  description: 'Region 3',
                  data: provider.userData.region3 ?? '',
                ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                _PersonalDataItem(
                  localization: localization,
                  description: 'Region 4',
                  data: provider.userData.region4 ?? '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonalDataItem extends StatelessWidget {
  const _PersonalDataItem(
      {Key key, @required this.localization, this.description, this.data})
      : super(key: key);

  final helpers.AppLocalizations localization;
  final String description;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              localization.translate(description.capitalize()),
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black38,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Flexible(
            child: Text(
              data,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}

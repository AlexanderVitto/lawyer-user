import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constraint.dart';
import '../../../../helpers/helpers.dart' as helpers;

import '../../../models/models.dart' as models;
import '../../../providers/providers.dart' as providers;

import '../../shared/shared.dart';

import '../provider/update_profile_provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    return Consumer<UpdateProfileProvider>(
      builder: (_, provider, __) => Stack(
        fit: StackFit.expand,
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            children: [
              const SizedBox(
                height: 8,
              ),
              CustomTextField(
                controller: provider.firstNameController,
                onChanged: provider.firstNameOnChange,
                labelText: localization.translate('First name'.pascalCase()),
                labelColor: Colors.black54,
                helperText: provider.isFirstNameControllerEmpty
                    ? localization
                        .translate('Please fill this field'.capitalize())
                    : null,
                helperColor: Colors.red,
                inputBorderColor: provider.isFirstNameControllerEmpty
                    ? Colors.red
                    : PsykayGreenColor,
                borderColor: provider.isFirstNameControllerEmpty
                    ? Colors.red
                    : PsykayGreenMediumColor,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: provider.lastNameController,
                onChanged: provider.lastNameOnChange,
                labelText: localization.translate('Last name'.pascalCase()),
                labelColor: Colors.black54,
                helperText: provider.isLastNameControllerEmpty
                    ? localization
                        .translate('Please fill this field'.capitalize())
                    : null,
                helperColor: Colors.red,
                inputBorderColor: provider.isLastNameControllerEmpty
                    ? Colors.red
                    : PsykayGreenColor,
                borderColor: provider.isLastNameControllerEmpty
                    ? Colors.red
                    : PsykayGreenMediumColor,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: provider.salutationController,
                onChanged: provider.salutationOnChange,
                labelText: localization.translate('Salutation'.pascalCase()),
                labelColor: Colors.black54,
                helperText: provider.isSalutationControllerEmpty
                    ? localization
                        .translate('Please fill this field'.capitalize())
                    : null,
                helperColor: Colors.red,
                inputBorderColor: provider.isSalutationControllerEmpty
                    ? Colors.red
                    : PsykayGreenColor,
                borderColor: provider.isSalutationControllerEmpty
                    ? Colors.red
                    : PsykayGreenMediumColor,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                localization.translate('Gender'.pascalCase()),
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
              ),
              DropdownButton<models.StaticData>(
                value: provider.genderStatus,
                elevation: 16,
                style: TextStyle(color: Colors.black87),
                underline: Container(
                  height: 2,
                  color: provider.genderStatus == null
                      ? Colors.red
                      : PsykayGreenMediumColor,
                ),
                onChanged: provider.selectGenderStatus,
                items: provider.staticData.genderStatus
                    .map<DropdownMenuItem<models.StaticData>>((element) {
                  return DropdownMenuItem<models.StaticData>(
                    value: element,
                    child: Text(
                      localization.translate(element.name.pascalCase()),
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                localization.translate('Date of birth'.pascalCase()),
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => provider.selectDate(context),
                    child: Icon(
                      Icons.date_range_outlined,
                    ),
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(0, 0)),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.fromLTRB(16, 5, 16, 5)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).buttonColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(
                                        color:
                                            Theme.of(context).buttonColor)))),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    provider.dateOfBirth == null
                        ? ''
                        : provider.dateOfBirth.split('T')[0],
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                '${localization.translate('ID'.toUpperCase())} ${localization.translate('Card number'.pascalCase())}',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
              ),
              DropdownButton<models.StaticData>(
                value: provider.idCardType,
                elevation: 16,
                style: TextStyle(color: Colors.black87),
                underline: Container(
                  height: 2,
                  color: provider.idCardType == null
                      ? Colors.red
                      : PsykayGreenMediumColor,
                ),
                onChanged: provider.selectIdCardType,
                items: provider.staticData.cardTypeData
                    .map<DropdownMenuItem<models.StaticData>>((element) {
                  return DropdownMenuItem<models.StaticData>(
                    value: element,
                    child: Text(
                      localization.translate(element.name.pascalCase()),
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: provider.idCardNumberController,
                onChanged: provider.idCardNumberOnChange,
                keyboardType: TextInputType.number,
                labelText:
                    '${localization.translate('ID'.toUpperCase())} ${localization.translate('Card number'.pascalCase())}',
                labelColor: Colors.black54,
                helperText: provider.isIdCardNumberControllerEmpty
                    ? localization
                        .translate('Please fill this field'.capitalize())
                    : null,
                helperColor: Colors.red,
                inputBorderColor: provider.isIdCardNumberControllerEmpty
                    ? Colors.red
                    : PsykayGreenColor,
                borderColor: provider.isIdCardNumberControllerEmpty
                    ? Colors.red
                    : PsykayGreenMediumColor,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: provider.phoneNumberController,
                onChanged: provider.phoneNumberOnChange,
                keyboardType: TextInputType.phone,
                labelText: localization.translate('Phone number'.pascalCase()),
                labelColor: Colors.black54,
                helperText: provider.isPhoneNumberControllerEmpty
                    ? localization
                        .translate('Please fill this field'.capitalize())
                    : null,
                helperColor: Colors.red,
                inputBorderColor: provider.isPhoneNumberControllerEmpty
                    ? Colors.red
                    : PsykayGreenColor,
                borderColor: provider.isPhoneNumberControllerEmpty
                    ? Colors.red
                    : PsykayGreenMediumColor,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: provider.mobileNumberController,
                onChanged: provider.mobileNumberOnChange,
                keyboardType: TextInputType.phone,
                labelText: localization.translate('Mobile number'.pascalCase()),
                labelColor: Colors.black54,
                helperText: provider.isMobileNumberControllerEmpty
                    ? localization
                        .translate('Please fill this field'.capitalize())
                    : null,
                helperColor: Colors.red,
                inputBorderColor: provider.isMobileNumberControllerEmpty
                    ? Colors.red
                    : PsykayGreenColor,
                borderColor: provider.isMobileNumberControllerEmpty
                    ? Colors.red
                    : PsykayGreenMediumColor,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                maxLines: 5,
                controller: provider.addressController,
                onChanged: provider.addressOnChange,
                labelText: localization.translate('Address'.pascalCase()),
                labelColor: Colors.black54,
                helperText: provider.isAddressControllerEmpty
                    ? localization
                        .translate('Please fill this field'.capitalize())
                    : null,
                helperColor: Colors.red,
                inputBorderColor: provider.isAddressControllerEmpty
                    ? Colors.red
                    : PsykayGreenColor,
                borderColor: provider.isAddressControllerEmpty
                    ? Colors.red
                    : PsykayGreenMediumColor,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: CustomTextField(
                      controller: provider.zipCodeController,
                      onChanged: provider.zipCodeOnChange,
                      keyboardType: TextInputType.number,
                      labelText:
                          '${localization.translate('Zip'.toUpperCase())} ${localization.translate('Code/ postal code'.pascalCase())}',
                      labelColor: Colors.black54,
                      helperText: provider.isZipCodeControllerEmpty
                          ? localization
                              .translate('Please fill this field'.capitalize())
                          : null,
                      helperColor: Colors.red,
                      inputBorderColor: provider.isZipCodeControllerEmpty
                          ? Colors.red
                          : PsykayGreenColor,
                      borderColor: provider.isZipCodeControllerEmpty
                          ? Colors.red
                          : PsykayGreenMediumColor,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: CustomElevatedButton(
                        localization: localization,
                        onPresses: () => provider.searchLocation(context),
                        text: 'Check',
                        fontSize: 14,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                localization.translate(
                    'Check ZIP code will auto generate country and region'),
                style: TextStyle(fontSize: 12, color: PsykayOrangeColor),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: provider.countryController,
                onChanged: provider.countryOnChange,
                labelText: localization.translate('Country'.pascalCase()),
                labelColor: Colors.black54,
                helperText: provider.isCountryControllerEmpty
                    ? localization
                        .translate('Please fill this field'.capitalize())
                    : null,
                helperColor: Colors.red,
                inputBorderColor: provider.isCountryControllerEmpty
                    ? Colors.red
                    : PsykayGreenColor,
                borderColor: provider.isCountryControllerEmpty
                    ? Colors.red
                    : PsykayGreenMediumColor,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: provider.region1Controller,
                onChanged: provider.region1OnChange,
                labelText: localization.translate('Region 1'.pascalCase()),
                labelColor: Colors.black54,
                helperText: null,
                inputBorderColor: PsykayGreenColor,
                borderColor: PsykayGreenMediumColor,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: provider.region2Controller,
                onChanged: provider.region2OnChange,
                labelText: localization.translate('Region 2'.pascalCase()),
                labelColor: Colors.black54,
                helperText: null,
                inputBorderColor: PsykayGreenColor,
                borderColor: PsykayGreenMediumColor,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: provider.region3Controller,
                onChanged: provider.region3OnChange,
                labelText: localization.translate('Region 3'.pascalCase()),
                labelColor: Colors.black54,
                helperText: null,
                inputBorderColor: PsykayGreenColor,
                borderColor: PsykayGreenMediumColor,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: provider.region4Controller,
                onChanged: provider.region4OnChange,
                labelText: localization.translate('Region 4'.pascalCase()),
                labelColor: Colors.black54,
                helperText: null,
                inputBorderColor: PsykayGreenColor,
                borderColor: PsykayGreenMediumColor,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                localization.translate('Marital status'.pascalCase()),
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
              ),
              DropdownButton<models.StaticData>(
                value: provider.maritalStatus,
                elevation: 16,
                style: TextStyle(color: Colors.black87),
                underline: Container(
                  height: 2,
                  color: provider.maritalStatus == null
                      ? Colors.red
                      : PsykayGreenMediumColor,
                ),
                onChanged: provider.selectMaritalStatus,
                items: provider.staticData.maritalStatus
                    .map<DropdownMenuItem<models.StaticData>>((element) {
                  return DropdownMenuItem<models.StaticData>(
                    value: element,
                    child: Text(
                      localization.translate(element.name.pascalCase()),
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                localization.translate('Religion'.pascalCase()),
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
              ),
              DropdownButton<models.StaticData>(
                value: provider.religion,
                elevation: 16,
                style: TextStyle(color: Colors.black87),
                underline: Container(
                  height: 2,
                  color: provider.religion == null
                      ? Colors.red
                      : PsykayGreenMediumColor,
                ),
                onChanged: provider.selectReligion,
                items: provider.staticData.religionData
                    .map<DropdownMenuItem<models.StaticData>>((element) {
                  return DropdownMenuItem<models.StaticData>(
                    value: element,
                    child: Text(
                      localization.translate(element.name.pascalCase()),
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: provider.ethnicController,
                onChanged: provider.ethnicOnChange,
                labelText: localization.translate('Ethnic'.pascalCase()),
                labelColor: Colors.black54,
                helperText: provider.isEthnicControllerEmpty
                    ? localization
                        .translate('Please fill this field'.capitalize())
                    : null,
                helperColor: Colors.red,
                inputBorderColor: provider.isEthnicControllerEmpty
                    ? Colors.red
                    : PsykayGreenColor,
                borderColor: provider.isEthnicControllerEmpty
                    ? Colors.red
                    : PsykayGreenMediumColor,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                localization.translate('Occupation'.pascalCase()),
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
              ),
              DropdownButton<models.StaticData>(
                value: provider.occupation,
                elevation: 16,
                style: TextStyle(color: Colors.black87),
                underline: Container(
                  height: 2,
                  color: provider.occupation == null
                      ? Colors.red
                      : PsykayGreenMediumColor,
                ),
                onChanged: provider.selectOccupation,
                items: provider.staticData.occupationData
                    .map<DropdownMenuItem<models.StaticData>>((element) {
                  return DropdownMenuItem<models.StaticData>(
                    value: element,
                    child: Text(
                      localization.translate(element.name.pascalCase()),
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                localization.translate('Last education'.pascalCase()),
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
              ),
              DropdownButton<models.StaticData>(
                value: provider.lastEducation,
                elevation: 16,
                style: TextStyle(color: Colors.black87),
                underline: Container(
                  height: 2,
                  color: provider.lastEducation == null
                      ? Colors.red
                      : PsykayGreenMediumColor,
                ),
                onChanged: provider.selectLastEducation,
                items: provider.staticData.lastEducationData
                    .map<DropdownMenuItem<models.StaticData>>((element) {
                  return DropdownMenuItem<models.StaticData>(
                    value: element,
                    child: Text(
                      localization.translate(element.name.pascalCase()),
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 35,
              ),
              CustomElevatedButton(
                localization: localization,
                onPresses: () => provider.save(context),
                text: 'Save',
                fontSize: 14,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              )
            ],
          ),
          if (provider.isBusy) helpers.LoadingPouringHourGlass()
        ],
      ),
    );
  }
}

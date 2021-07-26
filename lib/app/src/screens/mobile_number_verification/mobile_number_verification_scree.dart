import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/helpers.dart' as helpers;

import '../shared/shared.dart';

import 'mobile_number_verification_provider.dart';

class MobileNumberVerificationScreen extends StatelessWidget {
  static const routeName = '/mobile-number-verification-screen';

  final helpers.ScreenArguments arguments;

  const MobileNumberVerificationScreen(this.arguments);

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    Provider.of<MobileNumberVerificationProvider>(context, listen: false)
        .initialize(arguments);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<MobileNumberVerificationProvider>(
        builder: (_, provider, __) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).padding.top,
              color: helpers.LawyerMainColor,
            ),
            Container(
              padding: const EdgeInsets.only(left: 5),
              alignment: Alignment.bottomLeft,
              color: helpers.LawyerMainColor,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              color: helpers.LawyerMainColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    localization.translate('Verification'),
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    localization.translate('Choose your verification method'),
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.grey[300]),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0.1,
                      blurRadius: 0.1,
                      offset: Offset(0, 1), // changes position of shadow
                    )
                  ]),
              child: Row(
                children: [
                  Icon(Icons.phone_android),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localization.translate('Verify via SMS to'),
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          provider.mobileNumber,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 16,
                  )
                ],
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: CustomElevatedButton(
                localization: localization,
                onPresses: () => provider.continueBtn(context),
                text: 'Continue',
                backgroundColor: helpers.LawyerMainColor,
                fontSize: 14,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

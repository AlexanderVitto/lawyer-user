import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../enum.dart';
import '../../../../../constraint.dart';

import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;

import '../../shared/shared.dart';

import '../provider/mobile_number_verification_provider.dart';

class Body extends StatelessWidget {
  final ScreenSize screenSize = ScreenSize.mini;

  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    final provider =
        Provider.of<MobileNumberVerificationProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 5,
              ),
              TopImage(
                name: 'assets/images/verification.png',
                containerHeight: 200,
                withLogo: false,
                localization: localization,
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                color: PsykayGreenColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      localization.translate('Verification'),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      localization.translate('Choose your verification method'),
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              InkWell(
                onTap: () => provider.sendOTP(context, screenSize),
                child: _VerificationMethod(
                    localization: localization,
                    mobileNumber: provider.fullMobileNumber),
              ),
              Container(
                height: size.height * 0.3,
                constraints: BoxConstraints(minHeight: 50),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: CustomeElevatedButton(
                  onPresses: () => Navigator.of(context).pop(),
                  localization: localization,
                  text: 'Back',
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Consumer<MobileNumberVerificationProvider>(
          builder: (_, provider, __) => provider.isBusy
              ? helpers.LoadingPouringHourGlass(
                  iconSize: 30,
                )
              : Container(),
        ),
        utils.ConnectionInfo(
          iconSize: 16,
          fontSize: 12,
        )
      ],
    );
  }
}

class _VerificationMethod extends StatelessWidget {
  const _VerificationMethod({
    Key key,
    @required this.localization,
    @required this.mobileNumber,
  }) : super(key: key);

  final helpers.AppLocalizations localization;
  final String mobileNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.phone_android_rounded,
            color: Colors.black54,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  localization.translate('Verify via SMS to'),
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  localization.translate(mobileNumber),
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

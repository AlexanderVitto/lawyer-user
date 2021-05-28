import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../enum.dart';
import '../../../../../constraint.dart';

import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;

import '../../shared/shared.dart';

import '../provider/otp_provider.dart';

class Body extends StatelessWidget {
  final ScreenSize screenSize = ScreenSize.phone;

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
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
                containerHeight: 250,
                withLogo: false,
                localization: localization,
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                color: PsykayGreenColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      localization.translate('Enter OTP Code'),
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      localization
                          .translate('Please do not share your OTP code'),
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              _InputText(localization: localization),
              Container(
                height: size.height * 0.22,
                constraints: BoxConstraints(minHeight: 150),
              ),
              Consumer<OTPProvider>(
                builder: (_, provider, __) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomeElevatedButton(
                        onPresses: () => provider.confirm(context, screenSize),
                        localization: localization,
                        backgroundColor: provider.isCodeControllerEmpty
                            ? PsykayGreyLightColor
                            : PsykayGreenColor,
                        text: 'Confirm',
                      ),
                      CustomeElevatedButton(
                        onPresses: () => provider.resend(context, screenSize),
                        localization: localization,
                        foregroundColor: PsykayGreenColor,
                        backgroundColor: PsykayGreenLightColor,
                        text:
                            '${provider.timeout == 0 ? "Resend" : provider.timeout}',
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Consumer<OTPProvider>(
          builder: (_, provider, __) =>
              provider.isBusy ? helpers.LoadingPouringHourGlass() : Container(),
        ),
        utils.ConnectionInfo(
          iconSize: 18,
          fontSize: 14,
        )
      ],
    );
  }
}

class _InputText extends StatelessWidget {
  const _InputText({
    Key key,
    @required this.localization,
  }) : super(key: key);

  final helpers.AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            localization.translate('Code'),
            style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          Consumer<OTPProvider>(
              builder: (_, provider, __) => CustomTextField(
                    controller: provider.codeController,
                    onChanged: provider.codeTextOnChange,
                    labelText: localization.translate('Code'),
                    labelFontSize: 14,
                    inputBorderColor: PsykayGreenColor,
                    fillColor: PsykayGreyLightColor,
                    labelColor: Colors.black54,
                    borderColor: provider.isCodeControllerEmpty
                        ? Colors.red
                        : PsykayGreenColor,
                  ))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../enum.dart';
import '../../../../../constraint.dart';

import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;

import '../../shared/shared.dart';
import '../provider/forgot_password_provider.dart';

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
                height: 20,
              ),
              TopImage(
                  name: 'assets/images/forgot-password.png',
                  containerHeight: 250,
                  withLogo: false,
                  localization: localization),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                color: PsykayGreenColor,
                child: Text(
                  localization.translate('Reset Password'),
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              _InputText(localization: localization),
              Container(
                  height: size.height * 0.3,
                  constraints: BoxConstraints(minHeight: 150)),
              Consumer<ForgotPasswordProvider>(
                builder: (_, forgotPasswordProvider, __) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: CustomElevatedButton(
                    onPresses: () => forgotPasswordProvider.resetPassword(
                        context, screenSize),
                    localization: localization,
                    text: 'Send To Email',
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
        Consumer<ForgotPasswordProvider>(
          builder: (_, forgotPasswordProvider, __) =>
              forgotPasswordProvider.isBusy
                  ? helpers.LoadingPouringHourGlass()
                  : Container(),
        ),
        // utils.ConnectionInfo(
        //   iconSize: 18,
        //   fontSize: 14,
        // )
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
            localization.translate('Please enter your email address'),
            style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          Consumer<ForgotPasswordProvider>(
              builder: (_, forgotPasswordProvider, __) => CustomTextField(
                    controller: forgotPasswordProvider.emailController,
                    onChanged: forgotPasswordProvider.emailTextOnChange,
                    labelText: localization.translate('Email'),
                    labelFontSize: 14,
                    inputBorderColor: PsykayGreenColor,
                    fillColor: PsykayGreyLightColor,
                    labelColor: Colors.black54,
                    borderColor: forgotPasswordProvider.isEmailControllerEmpty
                        ? Colors.red
                        : PsykayGreenColor,
                  ))
        ],
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../enum.dart';
import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;

import '../../shared/shared.dart';

import '../provider/signin_provider.dart';

class Body extends StatelessWidget {
  final ScreenSize screenSize = ScreenSize.tablet;

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TopImage(
                    name: 'assets/images/login.png',
                    containerHeight: 390,
                    logoHeight: 45,
                    localization: localization),
                const SizedBox(height: 25),
                _Label(localization: localization),
                const SizedBox(
                  height: 3,
                ),
                _LabelDescription(localization: localization),
                _InputText(localization: localization),
                Consumer<SignInProvider>(
                  builder: (_, signinProvider, __) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: signinProvider.isLogineWithEmail
                        ? CustomElevatedButton(
                            onPresses: () => signinProvider.loginWithEmail(
                                context, screenSize),
                            localization: localization,
                            text: 'Login')
                        : CustomElevatedButton(
                            onPresses: () => signinProvider.nextButton(context),
                            localization: localization,
                            text: 'Next'),
                  ),
                ),
                _NavigateToSignUp(localization: localization),
                ConnectingDivider(localization: localization),
                Consumer<SignInProvider>(
                    builder: (_, signinProvider, __) => MediaSocialIcon(
                          facebook: () => signinProvider.loginWithGoogle(
                              context, screenSize),
                          google: () => signinProvider.loginWithGoogle(
                              context, screenSize),
                        ))
              ]),
        ),
        Consumer<SignInProvider>(
          builder: (_, signinProvider, __) => signinProvider.isBusy
              ? helpers.LoadingPouringHourGlass(
                  iconSize: 80,
                )
              : Container(),
        ),
        // utils.ConnectionInfo(
        //   iconSize: 20,
        //   fontSize: 14,
        // )
      ],
    );
  }
}

class _NavigateToSignUp extends StatelessWidget {
  const _NavigateToSignUp({
    Key key,
    @required this.localization,
  }) : super(key: key);

  final helpers.AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    final signinProvider = Provider.of<SignInProvider>(context, listen: false);
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: '${localization.translate("Don't have an account")} ? ',
        style: TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
        children: <TextSpan>[
          TextSpan(
            text: '${localization.translate("Sign up").toUpperCase()}',
            style: TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
            recognizer: TapGestureRecognizer()
              ..onTap = () => signinProvider.navigateToSignUp(context),
          ),
        ],
      ),
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
    final size = MediaQuery.of(context).size;
    final signinProvider = Provider.of<SignInProvider>(context, listen: false);

    return Consumer<SignInProvider>(
      builder: (_, signinProvider, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                controller: signinProvider.userController,
                onChanged: signinProvider.userTextOnChange,
                hintText: localization.translate('Email / Mobile Number'),
                helperText: signinProvider.isLogineWithEmail
                    ? ''
                    : localization.translate('Example : 085123456789'),
                borderColor: signinProvider.isUserControllerEmpty
                    ? Colors.red
                    : Colors.white,
              ),
              if (signinProvider.isLogineWithEmail)
                CustomTextField(
                  controller: signinProvider.passwordController,
                  onChanged: signinProvider.passwordTextOnChange,
                  hintText: localization.translate('Password'),
                  borderColor: signinProvider.isPasswordControllerEmpty
                      ? Colors.red
                      : Colors.white,
                  obsecureText: signinProvider.passwordIsObsecure,
                  suffixIcon: IconButton(
                    icon: signinProvider.passwordIsObsecure
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off_rounded),
                    onPressed: signinProvider.toggleObsecurePassword,
                  ),
                ),
              const SizedBox(
                height: 15,
              ),
              child,
              SizedBox(
                height: signinProvider.isLogineWithEmail
                    ? size.height * 0.03
                    : size.height * 0.05,
              ),
            ]),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: '${localization.translate("Forgot Password")} ? ',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () => signinProvider.navigateToForgotPassword(context),
        ),
      ),
    );
  }
}

class _LabelDescription extends StatelessWidget {
  const _LabelDescription({
    Key key,
    @required this.localization,
  }) : super(key: key);

  final helpers.AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    return Text(
      localization.translate('Please enter your credentials to proceed'),
      style: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({
    Key key,
    @required this.localization,
  }) : super(key: key);

  final helpers.AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    return Text(
      localization.translate('Sign In'),
      style: TextStyle(
          color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700),
      textAlign: TextAlign.center,
    );
  }
}

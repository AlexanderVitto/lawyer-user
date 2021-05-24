import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../enum.dart';
import '../../../../../constraint.dart';
import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;

import '../../shared/shared.dart';

import '../providers/signin_provider.dart';

class SigninBody extends StatelessWidget {
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
                _TopImage(localization: localization),
                const SizedBox(height: 15),
                _Label(localization: localization),
                const SizedBox(
                  height: 2,
                ),
                _LabelDescription(localization: localization),
                _InputText(localization: localization),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Consumer<SigninProvider>(
                  builder: (_, signinProvider, __) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: signinProvider.isLogineWithEmail
                        ? CustomeElevatedButton(
                            onPresses: () => signinProvider.loginWithEmail(
                                context, ScreenSize.phone),
                            localization: localization,
                            text: 'Login')
                        : CustomeElevatedButton(
                            onPresses: signinProvider.nextButton,
                            localization: localization,
                            text: 'Next'),
                  ),
                ),
                _NavigateToSignUp(localization: localization),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        localization
                            .translate('Or connect using')
                            .toUpperCase(),
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<SigninProvider>(
                    builder: (_, signinProvider, __) => _MediaSocialIcon(
                          signinProvider: signinProvider,
                        ))
              ]),
        ),
        Consumer<SigninProvider>(
          builder: (_, signinProvider, __) => signinProvider.isBusy
              ? helpers.LoadingPouringHourGlass()
              : Container(),
        ),
        utils.ConnectionInfo(
          iconSize: 18,
          fontSize: 14,
        )
      ],
    );
  }
}

class _MediaSocialIcon extends StatelessWidget {
  const _MediaSocialIcon({
    Key key,
    this.signinProvider,
  }) : super(key: key);

  final SigninProvider signinProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialMediaIcon(
          asset: 'assets/icons/google.png',
          iconColor: Colors.red,
          onTap: () =>
              signinProvider.loginWithGoogle(context, ScreenSize.phone),
        ),
        SocialMediaIcon(
          asset: 'assets/icons/facebook.png',
          iconColor: Colors.blue,
          onTap: () =>
              signinProvider.loginWithFacebook(context, ScreenSize.phone),
        ),
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
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: '${localization.translate("Don't have an account")} ? ',
        style: TextStyle(
            fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400),
        children: <TextSpan>[
          TextSpan(
            text: '${localization.translate("Sign up").toUpperCase()}',
            style: TextStyle(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
            recognizer: TapGestureRecognizer()
              ..onTap = () => print('Tap Here onTap'),
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
    return Consumer<SigninProvider>(
      builder: (_, signinProvider, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                height: 5,
              ),
              child
            ]),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: '${localization.translate("Forgot Password")} ? ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () => print('Tap Here onTap'),
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
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
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
          color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),
      textAlign: TextAlign.center,
    );
  }
}

class _TopImage extends StatelessWidget {
  const _TopImage({
    Key key,
    @required this.localization,
  }) : super(key: key);

  final helpers.AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          color: Colors.white,
          child: Image.asset(
            'assets/images/login.png',
            alignment: Alignment.bottomCenter,
          ),
        ),
        Positioned(
          top: 45,
          left: 0,
          right: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 35,
              ),
              Text(
                  localization.translate('Trusted Verified Online Counselling'),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: PsykayGreenColor))
            ],
          ),
        )
      ],
    );
  }
}

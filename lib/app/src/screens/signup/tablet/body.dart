import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../enum.dart';
import '../../../../helpers/helpers.dart' as helpers;
import '../../../../utils/utils.dart' as utils;

import '../../shared/shared.dart';

import '../provider/signup_provider.dart';

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
                  name: 'assets/images/sign-up.png',
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
              Consumer<SignUpProvider>(
                builder: (_, signupProvider, __) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: signupProvider.isLogineWithEmail
                      ? CustomElevatedButton(
                          onPresses: () => signupProvider.signupWithEmail(
                              context, screenSize),
                          localization: localization,
                          text: 'Signup')
                      : CustomElevatedButton(
                          onPresses: () => signupProvider.nextButton(context),
                          localization: localization,
                          text: 'Next'),
                ),
              ),
              _NavigateToSignIn(
                localization: localization,
              ),
              ConnectingDivider(localization: localization),
              Consumer<SignUpProvider>(
                  builder: (_, signupProvider, __) => MediaSocialIcon(
                        facebook: () => signupProvider.signupWithGoogle(
                            context, screenSize),
                        google: () => signupProvider.signupWithGoogle(
                            context, screenSize),
                      ))
            ],
          ),
        ),
        Consumer<SignUpProvider>(
          builder: (_, signupProvider, __) => signupProvider.isBusy
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

class _NavigateToSignIn extends StatelessWidget {
  const _NavigateToSignIn({
    Key key,
    @required this.localization,
  }) : super(key: key);

  final helpers.AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<SignUpProvider>(context, listen: false);
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: '${localization.translate("Already have an Account")} ? ',
        style: TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
        children: <TextSpan>[
          TextSpan(
            text: '${localization.translate("Sign up").toUpperCase()}',
            style: TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
            recognizer: TapGestureRecognizer()
              ..onTap = () => signupProvider.navigateToSignIn(context),
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
    final signupProvider = Provider.of<SignUpProvider>(context, listen: false);

    return Consumer<SignUpProvider>(
      builder: (_, signupProvider, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                controller: signupProvider.userController,
                onChanged: signupProvider.userTextOnChange,
                hintText: localization.translate('Email / Mobile Number'),
                helperText: signupProvider.isLogineWithEmail
                    ? ''
                    : localization.translate('Example : 085123456789'),
                borderColor: signupProvider.isUserControllerEmpty
                    ? Colors.red
                    : Colors.white,
              ),
              if (signupProvider.isLogineWithEmail)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextField(
                      controller: signupProvider.nameController,
                      onChanged: signupProvider.nameTextOnChange,
                      hintText: localization.translate('Name'),
                      helperText: '',
                      borderColor: signupProvider.isNameControllerEmpty
                          ? Colors.red
                          : Colors.white,
                    ),
                    CustomTextField(
                      controller: signupProvider.passwordController,
                      onChanged: signupProvider.passwordTextOnChange,
                      hintText: localization.translate('Password'),
                      borderColor: signupProvider.isPasswordControllerEmpty
                          ? Colors.red
                          : Colors.white,
                      obsecureText: signupProvider.passwordIsObsecure,
                      suffixIcon: IconButton(
                        icon: signupProvider.passwordIsObsecure
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off_rounded),
                        onPressed: signupProvider.toggleObsecurePassword,
                      ),
                    ),
                    CustomTextField(
                      controller: signupProvider.passwordConfirmationController,
                      onChanged:
                          signupProvider.passwordConfirmationTextOnChange,
                      hintText: localization.translate('Confirm Password'),
                      borderColor:
                          signupProvider.isPasswordConfirmationControllerEmpty
                              ? Colors.red
                              : Colors.white,
                      obsecureText:
                          signupProvider.passwordConfirmationIsObsecure,
                      suffixIcon: IconButton(
                        icon: signupProvider.passwordConfirmationIsObsecure
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off_rounded),
                        onPressed: signupProvider.toggleObsecurePassword,
                      ),
                    ),
                  ],
                ),
              const SizedBox(
                height: 15,
              ),
              child,
              SizedBox(
                height: signupProvider.isLogineWithEmail
                    ? size.height * 0.01
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
            ..onTap = () => signupProvider.navigateToForgotPassword(context),
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
      localization.translate('Sign Up'),
      style: TextStyle(
          color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700),
      textAlign: TextAlign.center,
    );
  }
}

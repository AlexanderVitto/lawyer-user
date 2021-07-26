import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/helpers.dart' as helpers;

import '../shared/shared.dart';
import '../signup/signup_screen.dart';
import '../reset_password/reset_password_screen.dart';

import 'signin_provider.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/signin-screen';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  SigninProvider _provider;

  @override
  void initState() {
    super.initState();

    _provider = Provider.of<SigninProvider>(context, listen: false);
    _provider.initialize();
  }

  @override
  void dispose() {
    _provider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;
    _provider = Provider.of<SigninProvider>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        key: key,
        backgroundColor: helpers.LawyerMainColor,
        body: Consumer<SigninProvider>(
          builder: (_, provider, __) => Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Image.asset(
                  'assets/images/login_bottom_image.png',
                  fit: BoxFit.contain,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: size.height * 0.15,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'INDOLAW',
                            style: TextStyle(
                                fontSize: 32,
                                fontFamily: 'LibreBaskerville',
                                color: helpers.LawyerMainColor,
                                fontWeight: FontWeight.w200),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            height: size.height * 0.01,
                            constraints: BoxConstraints(minHeight: 8),
                          ),
                          Text(
                            localization.translate(
                                'Online consultation with certified Lawyer'),
                            style: TextStyle(
                                fontSize: 14,
                                color: helpers.LawyerMainColor,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            height: size.height * 0.05,
                            constraints: BoxConstraints(minHeight: 35),
                          ),
                          Text(
                            localization.translate('Sign in').pascalCase(),
                            style: TextStyle(
                                fontSize: 20,
                                color: helpers.LawyerMainColor,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            height: size.height * 0.016,
                            constraints: BoxConstraints(minHeight: 12),
                          ),
                          CustomTextField(
                            inputBorderColor: provider.isAccountEmpty
                                ? Colors.red
                                : Colors.grey,
                            controller: provider.accountController,
                            onChanged: provider.onAccountChanged,
                            hintText: localization
                                .translate('Enter your email/mobile number'),
                            hintFontSize: 14,
                            helperFontSize: 12,
                            helperText: provider.signInMode == SignInMode.email
                                ? ''
                                : localization
                                    .translate('Example: 085123456678'),
                            helperColor: Colors.grey,
                            borderColor: provider.isAccountEmpty
                                ? Colors.red
                                : Colors.grey,
                          ),
                          if (provider.signInMode == SignInMode.email)
                            CustomTextField(
                              inputBorderColor: provider.isPasswordEmpty
                                  ? Colors.red
                                  : Colors.grey,
                              controller: provider.passwordController,
                              onChanged: provider.onPasswordChanged,
                              hintText:
                                  localization.translate('Enter your password'),
                              hintFontSize: 14,
                              helperColor: Colors.grey,
                              borderColor: provider.isPasswordEmpty
                                  ? Colors.red
                                  : Colors.grey,
                              obsecureText: provider.isPasswordObscure,
                              suffixIcon: IconButton(
                                icon: provider.isPasswordObscure
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off_rounded),
                                onPressed: provider.togglePasswordObscure,
                              ),
                            ),
                          Container(
                            height: size.height * 0.032,
                            constraints: BoxConstraints(minHeight: 25),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () => Navigator.of(context)
                                    .pushNamed(SignUpScreen.routeName),
                                child: Text(
                                  localization
                                      .translate('Sign up')
                                      .pascalCase(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: helpers.LawyerMainColor,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              const Text(
                                '|',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: helpers.LawyerMainColor,
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () => Navigator.of(context)
                                    .pushNamed(ResetPassword.routeName),
                                child: Text(
                                  localization
                                      .translate('Forgot password')
                                      .pascalCase(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: helpers.LawyerMainColor,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: size.height * 0.045,
                            constraints: BoxConstraints(minHeight: 38),
                          ),
                          CustomElevatedButton(
                            onPresses: () => provider.signinBtn(key, context),
                            localization: localization,
                            text: 'Sign in',
                          ),
                          Container(
                            height: size.height * 0.014,
                            constraints: BoxConstraints(minHeight: 10),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: const Divider(
                                  indent: 15,
                                  color: helpers.LawyerMainColor,
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  localization
                                      .translate('Or connect user')
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: helpers.LawyerMainColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Expanded(
                                child: const Divider(
                                  endIndent: 15,
                                  color: helpers.LawyerMainColor,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: size.height * 0.014,
                            constraints: BoxConstraints(minHeight: 10),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border:
                                    Border.all(color: Colors.deepOrange[800]),
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  AssetImage(
                                    'assets/icons/google_icon.png',
                                  ),
                                  size: 14,
                                  color: Colors.deepOrange[800],
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  localization
                                      .translate('Connect with Google')
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.deepOrange[800],
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (provider.isBusy) helpers.LoadingPouringHourGlass(),
            ],
          ),
        ),
      ),
    );
  }
}

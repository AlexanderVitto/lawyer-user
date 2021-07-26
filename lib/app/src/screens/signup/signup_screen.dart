import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/helpers.dart' as helpers;

import '../shared/shared.dart';
import '../signin/signin_screen.dart';

import 'signup_provider.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup-screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  SignUpProvider _provider;

  @override
  void initState() {
    super.initState();

    _provider = Provider.of<SignUpProvider>(context, listen: false);
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
    _provider = Provider.of<SignUpProvider>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        key: key,
        backgroundColor: helpers.LawyerMainColor,
        body: Consumer<SignUpProvider>(
          builder: (_, provider, __) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: size.height * 0.15,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                        height: size.height * 0.05,
                        constraints: BoxConstraints(minHeight: 35),
                      ),
                      Text(
                        localization.translate('Register').pascalCase(),
                        style: TextStyle(
                            fontSize: 20,
                            color: helpers.LawyerMainColor,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        height: size.height * 0.01,
                        constraints: BoxConstraints(minHeight: 8),
                      ),
                      Text(
                        localization.translate(
                            'Start counselling with our certified psychologist'),
                        style: TextStyle(
                            fontSize: 14,
                            color: helpers.LawyerMainColor,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        height: size.height * 0.016,
                        constraints: BoxConstraints(minHeight: 12),
                      ),
                      CustomTextField(
                        inputBorderColor:
                            provider.isAccountEmpty ? Colors.red : Colors.grey,
                        controller: provider.nameController,
                        onChanged: provider.onNameChanged,
                        hintText: localization.translate('Name'),
                        hintFontSize: 14,
                        helperFontSize: 12,
                        helperText: '',
                        helperColor: Colors.grey,
                        borderColor:
                            provider.isNameEmpty ? Colors.red : Colors.grey,
                      ),
                      CustomTextField(
                        inputBorderColor:
                            provider.isAccountEmpty ? Colors.red : Colors.grey,
                        controller: provider.accountController,
                        onChanged: provider.onAccountChanged,
                        hintText: localization.translate('Email'),
                        hintFontSize: 14,
                        helperFontSize: 12,
                        helperText: '',
                        helperColor: Colors.grey,
                        borderColor:
                            provider.isAccountEmpty ? Colors.red : Colors.grey,
                      ),
                      CustomTextField(
                        inputBorderColor:
                            provider.isAccountEmpty ? Colors.red : Colors.grey,
                        controller: provider.mobileNumberController,
                        onChanged: provider.onMobileNumberChanged,
                       keyboardType: TextInputType.phone,
                        hintText: localization
                            .translate('Mobile number : 085123456678')
                            .pascalCase(),
                        hintFontSize: 14,
                        helperFontSize: 12,
                        helperText: '',
                        helperColor: Colors.grey,
                        borderColor: provider.isMobileNumberEmpty
                            ? Colors.red
                            : Colors.grey,
                      ),
                      CustomTextField(
                        inputBorderColor:
                            provider.isPasswordEmpty ? Colors.red : Colors.grey,
                        controller: provider.passwordController,
                        onChanged: provider.onPasswordChanged,
                        hintText:
                            localization.translate('Password').pascalCase(),
                        hintFontSize: 14,
                        helperColor: Colors.grey,
                        borderColor:
                            provider.isPasswordEmpty ? Colors.red : Colors.grey,
                        obsecureText: provider.isPasswordObscure,
                        suffixIcon: IconButton(
                          icon: provider.isPasswordObscure
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off_rounded),
                          onPressed: provider.togglePasswordObscure,
                        ),
                      ),
                      CustomTextField(
                        inputBorderColor: provider.isConfirmPasswordEmpty
                            ? Colors.red
                            : Colors.grey,
                        controller: provider.confirmPasswordController,
                        onChanged: provider.onConfirmPasswordChanged,
                        hintText: localization
                            .translate('Confirm password')
                            .pascalCase(),
                        hintFontSize: 14,
                        helperColor: Colors.grey,
                        borderColor: provider.isConfirmPasswordEmpty
                            ? Colors.red
                            : Colors.grey,
                        obsecureText: provider.isConfirmPasswordObscure,
                        suffixIcon: IconButton(
                          icon: provider.isConfirmPasswordObscure
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off_rounded),
                          onPressed: provider.toggleConfirmPasswordObscure,
                        ),
                      ),
                      Container(
                        height: size.height * 0.008,
                        constraints: BoxConstraints(minHeight: 6),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () => Navigator.of(context).pop(),
                            child: Text(
                              localization
                                  .translate('Back to sign in')
                                  .pascalCase(),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: helpers.LawyerMainColor,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: size.height * 0.026,
                        constraints: BoxConstraints(minHeight: 24),
                      ),
                      CustomElevatedButton(
                        onPresses: () =>
                            provider.createAccountBtn(key, context),
                        localization: localization,
                        text: 'Create account',
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
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              localization.translate('Or').toUpperCase(),
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
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () =>
                            provider.createAccountWithGoogleBtn(key, context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: Colors.deepOrange[800]),
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
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

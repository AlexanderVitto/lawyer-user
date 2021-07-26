import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/helpers.dart' as helpers;

import '../shared/shared.dart';

import 'reset_password_provider.dart';

class ResetPassword extends StatefulWidget {
  static const routeName = '/reset-password-screen';

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  ResetPasswordProvider _provider;

  @override
  void initState() {
    super.initState();

    _provider = Provider.of<ResetPasswordProvider>(context, listen: false);
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
    _provider = Provider.of<ResetPasswordProvider>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        key: key,
        appBar: AppBar(
          title: Text(localization.translate('Reset password').pascalCase()),
        ),
        backgroundColor: Colors.white,
        body: Consumer<ResetPasswordProvider>(
          builder: (_, provider, __) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 5),
                    child: Text(
                      localization.translate('Please enter your email'),
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  CustomTextField(
                    inputBorderColor:
                        provider.isEmailEmpty ? Colors.red : Colors.grey,
                    controller: provider.emailController,
                    onChanged: provider.onEmailChanged,
                    hintText: localization.translate('Email'),
                    hintFontSize: 14,
                    helperFontSize: 12,
                    helperText: '',
                    helperColor: Colors.grey,
                    borderColor:
                        provider.isEmailEmpty ? Colors.red : Colors.grey,
                  ),
                  Container(
                    height: size.height * 0.55,
                    constraints: BoxConstraints(minHeight: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: CustomElevatedButton(
                      onPresses: () => provider.sendToEmailBtn(key, context),
                      localization: localization,
                      text: 'Send to email',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

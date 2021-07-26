import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/helpers.dart' as helpers;

import '../shared/shared.dart';

import 'otp_provider.dart';

class OTPScreen extends StatefulWidget {
  static const routeName = '/otp-screen';

  final helpers.ScreenArguments arguments;

  const OTPScreen(this.arguments);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  OTPProvider _provider;

  @override
  void initState() {
    super.initState();

    _provider = Provider.of<OTPProvider>(context, listen: false);
    _provider.initialize(widget.arguments);
  }

  @override
  void dispose() {
    _provider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);
    _provider = Provider.of<OTPProvider>(context, listen: false);
    _provider.startTimer();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<OTPProvider>(
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
                    localization.translate('Code Verification'),
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    localization.translate('Please do not share your OTP code'),
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    localization.translate('Input the verification code'),
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    localization.translate(
                        'We have sent you a 6 digit verification code via SMS'),
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    inputBorderColor:
                        provider.isCodeEmpty ? Colors.red : Colors.grey,
                    controller: provider.codeController,
                    onChanged: provider.onAccountChanged,
                    hintText: localization.translate('Enter the code'),
                    hintFontSize: 14,
                    borderColor:
                        provider.isCodeEmpty ? Colors.red : Colors.grey,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomElevatedButton(
                    localization: localization,
                    onPresses: () => provider.verifyBtn(context),
                    text: 'Verify',
                    backgroundColor: helpers.LawyerMainColor,
                    fontSize: 14,
                    foregroundColor: Colors.white,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomElevatedButton(
                    localization: localization,
                    onPresses: () => provider.resendBtn(),
                    text: provider.timeout > 0
                        ? provider.timeout.toString()
                        : 'Resend OTP',
                    backgroundColor: Colors.indigo[50],
                    fontSize: 14,
                    foregroundColor: helpers.LawyerMainColor,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

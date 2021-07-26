import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/helpers.dart' as helpers;
import 'utils/utils.dart' as utils;
import 'config/config.dart' as config;
import 'src/providers/providers.dart' as providers;
import 'src/screens/signin/signin_screen.dart';

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp(this.sharedPreferences);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: config.setupProviders(sharedPreferences),
      child: MaterialApp(
        locale: Locale.fromSubtags(languageCode: 'en'),
        debugShowCheckedModeBanner: false,
        navigatorObservers: [config.locator<utils.AnalyticUtils>().observer()],
        title: 'PsyKay',
        localizationsDelegates: [
          helpers.AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'), // English, no country code
          const Locale('id', 'ID'), // Spanish, no country code
        ],
        // Returns a locale which will be used by the app
        localeResolutionCallback: (locale, supportedLocales) {
          // Check if the current device locale is supported
          // for (var supportedLocale in supportedLocales) {
          //   if (supportedLocale.languageCode == locale.languageCode &&
          //       supportedLocale.countryCode == locale.countryCode) {
          //     return supportedLocale;
          //   }
          // }
          // // If the locale of the device is not supported, use the first one
          // // from the list (English, in this case).
          // return supportedLocales.first;

          return locale;
        },
        theme: ThemeData(
          primaryColor: helpers.LawyerMainColor,
          scaffoldBackgroundColor: Colors.grey[200],
          buttonColor: helpers.LawyerMainColor,
          fontFamily: 'OpenSans',
        ),
        home: SignInScreen(),
        onGenerateRoute: config.generateRoute,
      ),
    );
  }
}

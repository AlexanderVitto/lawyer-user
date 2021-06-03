import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../constraint.dart';
import '../enum.dart';

import 'helpers/helpers.dart' as helpers;
import 'utils/utils.dart' as utils;
import 'config/config.dart' as config;
import 'src/providers/providers.dart' as providers;
import 'src/screens/main/main_screen.dart';
import 'src/screens/splash/splash_screen.dart';

import 'splash_animation.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: config.setupProviders(),
      child: MaterialApp(
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
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          // If the locale of the device is not supported, use the first one
          // from the list (English, in this case).
          return supportedLocales.first;
        },
        theme: ThemeData(
          primaryColor: PsykayGreenColor,
          primaryColorLight: PsykayGreenLightColor,
          scaffoldBackgroundColor: PsykayGreyLightColor,
          bottomAppBarColor: PsykayGreenColor,
          buttonColor: PsykayOrangeColor,
          fontFamily: 'Roboto',
        ),
        // home: TestingScreen(),
        // home: SplashAnimation(),
        // home: SplashScreen(),
        home: Consumer<providers.Auth>(
            builder: (_, provider, __) => provider.isAuth
                ? MainScreen(
                    helpers.ScreenArguments(mainScreenTab: MainScreenTab.home))
                : FutureBuilder(
                    future: provider.tryAutoLogin(),
                    builder: (_, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? SplashAnimation()
                            : SplashScreen())),
        onGenerateRoute: config.generateRoute,
      ),
    );
  }
}

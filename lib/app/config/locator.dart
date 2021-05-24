import 'package:get_it/get_it.dart';

import '../helpers/helpers.dart' as helpers;
import '../utils/utils.dart' as utils;
import '../services/application.dart' as application;
import '../services/identity.dart' as identity;
import '../services/user_profile.dart' as userProfile;

GetIt locator = GetIt.instance;

setuptLocator() {
  // Factory
  locator.registerFactoryParam<utils.LogUtils, String, bool>(
      (fileName, isEnable) =>
          utils.LogUtils(fileName: fileName, isEnable: isEnable));
  locator.registerFactory<helpers.Request>(() => helpers.Request());

  // Switch between production and dummy
  locator.registerFactory<application.ApplicationAPI>(
      () => application.Production());
  locator.registerFactory<identity.IdentityAPI>(() => identity.Production());
  locator.registerFactory<userProfile.UserProfileAPI>(
      () => userProfile.Production());

  // Singleton
  locator
      .registerLazySingleton<utils.AnalyticUtils>(() => utils.AnalyticUtils());
  // locator.registerLazySingleton<utils.ConnectivityUtils>(
  //     () => utils.ConnectivityUtils());
}

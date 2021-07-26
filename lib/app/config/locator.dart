import 'package:get_it/get_it.dart';

import '../helpers/helpers.dart' as helpers;
import '../utils/utils.dart' as utils;

GetIt locator = GetIt.instance;

setuptLocator() {
  // Factory
  locator.registerFactoryParam<utils.LogUtils, String, bool>(
      (fileName, isEnable) =>
          utils.LogUtils(fileName: fileName, isEnable: isEnable));
  locator.registerFactory<helpers.Request>(() => helpers.Request());

  // Switch between production and dummy

  // Singleton
  locator.registerLazySingleton<helpers.MinioStorage>(() =>
      helpers.MinioStorage(
          endPoint: 's3.psykay.co.id',
          accessKey: 'a52083d32a66aae6',
          secretKey: '31328a6f23e8498ba5d093e2e75ce4b9',
          bucket: 'pub'));
  locator
      .registerLazySingleton<utils.AnalyticUtils>(() => utils.AnalyticUtils());
  // locator.registerLazySingleton<utils.ConnectivityUtils>(
  //     () => utils.ConnectivityUtils());
}

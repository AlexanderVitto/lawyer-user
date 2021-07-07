import 'package:get_it/get_it.dart';

import '../helpers/helpers.dart' as helpers;
import '../utils/utils.dart' as utils;
import '../services/application.dart' as application;
import '../services/appointment.dart' as appointment;
import '../services/cart.dart' as cart;
import '../services/financial.dart' as financial;
import '../services/geo_location.dart' as geoLocation;
import '../services/identity.dart' as identity;
import '../services/master_bank.dart' as masterBank;
import '../services/master_expertise.dart' as masterExpertise;
import '../services/notification.dart' as notification;
import '../services/partner.dart' as partner;
import '../services/payment.dart' as payment;
import '../services/price_schema.dart' as priceSchema;
import '../services/questionnaire.dart' as questionnaire;
import '../services/static.dart' as staticData;
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
  locator.registerFactory<appointment.AppointmentAPI>(
      () => appointment.Production());
  locator.registerFactory<cart.CartAPI>(() => cart.Production());
  locator.registerFactory<financial.FinancialAPI>(() => financial.Production());
  locator.registerFactory<geoLocation.GeoLocationAPI>(
      () => geoLocation.Production());
  locator.registerFactory<identity.IdentityAPI>(() => identity.Production());
  locator
      .registerFactory<masterBank.MasterBankAPI>(() => masterBank.Production());
  locator.registerFactory<masterExpertise.MasterExpertiseAPI>(
      () => masterExpertise.Production());
  locator.registerFactory<notification.NotificationAPI>(
      () => notification.Production());
  locator.registerFactory<partner.PartnerAPI>(() => partner.Production());
  locator.registerFactory<payment.PaymentAPI>(() => payment.Production());
  locator.registerFactory<priceSchema.PriceSchemaAPI>(
      () => priceSchema.Production());
  locator.registerFactory<questionnaire.QuestionnaireAPI>(
      () => questionnaire.Production());
  locator.registerFactory<staticData.StaticAPI>(() => staticData.Production());
  locator.registerFactory<userProfile.UserProfileAPI>(
      () => userProfile.Production());

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

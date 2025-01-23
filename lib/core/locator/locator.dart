import 'package:furniture_e_commerce/core/controllers/auth_controller.dart';
import 'package:furniture_e_commerce/core/controllers/file_upload_controller.dart';
import 'package:furniture_e_commerce/core/features/main/services/storage_service.dart';
import 'package:furniture_e_commerce/core/global/config.dart';
import 'package:furniture_e_commerce/core/provider/auth_provider.dart';
import 'package:furniture_e_commerce/model/user_model.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.I;

class DependencyInjector {
  static void init() {
    // Firebase services
    locator.registerLazySingleton<AuthConroller>(() => AuthConroller());
    locator.registerLazySingleton< MyAuthProvider >(() =>  MyAuthProvider ());
    locator.registerLazySingleton<FileUploadController>(
        () => FileUploadController());

//  Storage services
    locator.registerLazySingleton<StorageService>(() => StorageService());
    // Api key services
    locator.registerLazySingleton<Config>(() => Config());

    //  Models
    locator.registerLazySingleton<UserModel>(() => UserModel.empty());

    // // Register Database Service
    // locator.registerLazySingleton(() => DatabaseService());

    // // Register Repositories
    // locator.registerLazySingleton(() => ProductRepository());
    // locator.registerLazySingleton(() => UserRepository());
    // locator.registerLazySingleton(() => OrderRepository());

    // // Register Authentication Service
    // locator.registerLazySingleton(() => AuthService());

    // // Register AR Model Service
    // locator.registerLazySingleton(() => ARModelService());

    // // Register Analytics Service (Optional)
    // locator.registerLazySingleton(() => AnalyticsService());
  }
}

import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:mobx_example/core/dio/configs/dio_configs.dart';
import 'package:mobx_example/core/dio/dio_client.dart';
import 'package:mobx_example/core/dio/interceptor/auth_interceptor.dart';
import 'package:mobx_example/core/dio/interceptor/logging_interceptor.dart';
import 'package:mobx_example/data/data_sources/remote/apis/movies/movie_api.dart';
import 'package:mobx_example/data/data_sources/remote/apis/movies/movie_api_impl.dart';
import 'package:mobx_example/di/service_locator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

mixin NetworkModule {
  static Future<void> configureNetworkModuleInjection() async {
    //
    // Interceptors:------------------------------------------------------------
    //
    getIt.registerLazySingleton<LoggingInterceptor>(() => LoggingInterceptor());
    getIt.registerLazySingleton<AuthInterceptor>(
      () => AuthInterceptor(
          // accessToken: () async => await getIt<AuthRepository>().authToken,
          accessToken: () async => dotenv.get('MOVIE_ACCESS_TOKEN')),
    );

    //
    // Dio:---------------------------------------------------------------------
    //
    getIt.registerSingleton<DioConfigs>(
      DioConfigs(
        baseUrl: FlavorConfig.instance.variables['baseUrl'],
        connectionTimeout: FlavorConfig.instance.variables['connectionTimeout'],
        receiveTimeout: FlavorConfig.instance.variables['receiveTimeout'],
      ),
    );
    getIt.registerSingleton<DioClient>(
      DioClient.basic(dioConfigs: getIt())
        ..addInterceptors(
          [
            getIt<AuthInterceptor>(),
            getIt<LoggingInterceptor>(),
          ],
        ),
    );

    //
    // API's:-------------------------------------------------------------------
    //

    //  Posts
    getIt.registerSingleton<MovieApi>(
      MovieApiImpl(
        getIt<DioClient>(),
      ),
    );
  }
}

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:invia_case_study/features/hotels/data/data_sources/hotels_data_source.dart';
import 'package:invia_case_study/features/hotels/data/repositories/hotels_repo_implementation.dart';
import 'package:invia_case_study/features/hotels/domain/repositories/hotels_repository.dart';
import 'package:invia_case_study/features/network/connectivity/connectivity_checker.dart';
import 'package:invia_case_study/features/network/connectivity/connectivity_interceptor.dart';
import 'package:invia_case_study/features/network/http_client.dart';
import 'package:invia_case_study/features/storage/local_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @LazySingleton(dispose: disposeDatabase)
  LocalDatabase appDb() {
    const isTest = bool.fromEnvironment('FLUTTER_TEST');
    if (isTest) {
      return constructTestDb();
    } else {
      return constructProdDb();
    }
  }

  @lazySingleton
  Dio provideDio() => Dio();

  @lazySingleton
  ConnectivityChecker provideConnectivityChecker() => ConnectivityChecker();

  @lazySingleton
  ConnectivityInterceptor provideConnectivityInterceptor(
    ConnectivityChecker checker,
  ) =>
      ConnectivityInterceptor()..connectivityChecker = checker;

  @lazySingleton
  HttpClient provideHttpClient(ConnectivityInterceptor interceptor) {
    final httpClient = HttpClient();
    return httpClient;
  }

  @LazySingleton(as: HotelsDataSource)
  HotelsDataSourceImpl provideHotelsDataSource() {
    return HotelsDataSourceImpl();
  }

  @LazySingleton(as: HotelsRepository)
  HotelRepoImplementation provideHotelsRepository() {
    return HotelRepoImplementation();
  }
}

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:invia_case_study/features/favorites/data/data_sources/favorites_data_source.dart';
import 'package:invia_case_study/features/favorites/data/repositories/favorites_repo_impl.dart';
import 'package:invia_case_study/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:invia_case_study/features/hotels/data/data_sources/hotels_data_source.dart';
import 'package:invia_case_study/features/hotels/data/repositories/hotels_repo_impl.dart';
import 'package:invia_case_study/features/hotels/domain/repositories/hotels_repository.dart';
import 'package:invia_case_study/features/network/connectivity/connectivity_checker.dart';
import 'package:invia_case_study/features/network/connectivity/connectivity_interceptor.dart';
import 'package:invia_case_study/features/network/http_client.dart';
import 'package:invia_case_study/features/storage/local_database.dart';
import 'package:invia_case_study/features/storage/local_database_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @LazySingleton()
  LocalDatabase appDb() => LocalDatabaseImpl();

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
  HotelsDataSourceImpl provideHotelsDataSource() => HotelsDataSourceImpl();

  @LazySingleton(as: FavoritesDataSource)
  FavoritesDataSourceImpl provideFavoritesDataSource() =>
      FavoritesDataSourceImpl();

  @LazySingleton(as: HotelsRepository)
  HotelRepoImpl provideHotelsRepository() => HotelRepoImpl();

  @LazySingleton(as: FavoritesRepository)
  FavoriteRepoImpl provideFavoritesRepository() => FavoriteRepoImpl();
}

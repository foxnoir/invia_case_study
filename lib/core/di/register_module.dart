import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:invia_case_study/features/hotels/data/data_sources/hotel_data_source.dart';
import 'package:invia_case_study/features/hotels/data/repositories/hotel_repo_implementation.dart';
import 'package:invia_case_study/features/hotels/domain/repositories/hotel_repository.dart';
import 'package:invia_case_study/features/storage/local_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @lazySingleton
  http.Client get httpClient => http.Client();

  @LazySingleton(dispose: disposeDatabase)
  LocalDatabase appDb() {
    const isTest = bool.fromEnvironment('FLUTTER_TEST');
    if (isTest) {
      return constructTestDb();
    } else {
      return constructProdDb();
    }
  }

  @LazySingleton(as: HotelDataSource)
  HotelDataSourceImpl provideHotelDataSource() {
    return HotelDataSourceImpl();
  }

  @LazySingleton(as: HotelRepository)
  HotelRepoImplementation provideHotelRepository() {
    return HotelRepoImplementation();
  }
}

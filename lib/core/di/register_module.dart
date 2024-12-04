import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:invia_case_study/features/hotels/data/data_sources/hotels_data_source.dart';
import 'package:invia_case_study/features/hotels/data/repositories/hotels_repo_implementation.dart';
import 'package:invia_case_study/features/hotels/domain/repositories/hotels_repository.dart';
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

  @LazySingleton(as: HotelsDataSource)
  HotelsDataSourceImpl provideHotelsDataSource() {
    return HotelsDataSourceImpl();
  }

  @LazySingleton(as: HotelsRepository)
  HotelRepoImplementation provideHotelsRepository() {
    return HotelRepoImplementation();
  }
}

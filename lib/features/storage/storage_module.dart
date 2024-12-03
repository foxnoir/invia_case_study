import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:invia_case_study/features/storage/local_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class StorageModule {
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
}

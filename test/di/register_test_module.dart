import 'package:injectable/injectable.dart';
import 'package:invia_case_study/features/favorites/data/data_sources/favorites_data_source.dart';
import 'package:invia_case_study/features/storage/local_database.dart';
import 'package:mocktail/mocktail.dart';

import '../features/favorites/presentation/bloc/favorites_bloc_test.dart';
import '../features/hotels/data/repositories/hotels_repo_impl_test.dart';
import '../features/hotels/presentation/bloc/hotels_bloc_test.dart';

class MockLocalDatabase extends Mock implements LocalDatabase {}

class MockFavoritesDataSource extends Mock implements FavoritesDataSource {}

@module
abstract class RegisterTestModule {
  @LazySingleton()
  MockLocalDatabase get mockLocalDatabase => MockLocalDatabase();

  @LazySingleton()
  MockFavoritesDataSource get mockFavoritesDataSource =>
      MockFavoritesDataSource();

  @LazySingleton()
  MockHotelsDataSource get mockHotelsDataSource => MockHotelsDataSource();

  @LazySingleton()
  MockHotelsRepository get mockHotelsRepository => MockHotelsRepository();

  @LazySingleton()
  MockFavoritesRepository get mockFavoritesRepository =>
      MockFavoritesRepository();
}

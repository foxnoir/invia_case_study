import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:invia_case_study/core/di/di.config.dart';

// Method used to initialized the dependency injection. Called in main.
@InjectableInit(ignoreUnregisteredTypes: [])
Future<GetIt> configureInjection(String env) => DI.getIt.init();

// Class to use GetIt for dependency injection.

class DI {
  // map of all registered instances
  static final GetIt getIt = GetIt.I;
}

extension GetItSafe on GetIt {
  // if a class is already registered it unregisters is and registers a new
  // object and returns the old implementation
  T? safeRegisterSingleton<T extends Object>(T impl) {
    T? old;
    if (DI.getIt.isRegistered<T>()) {
      old = DI.getIt<T>();
      DI.getIt.unregister<T>();
    }
    DI.getIt.registerSingleton<T>(impl);

    return old;
  }

  void safeUnregister<T extends Object>(T impl) {
    if (DI.getIt.isRegistered<T>(instance: impl)) {
      DI.getIt.unregister<T>(instance: impl);
    }
  }
}

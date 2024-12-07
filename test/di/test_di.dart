import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'test_di.config.dart';

@InjectableInit(
  initializerName: 'initTest',
  preferRelativeImports: true,
  asExtension: true,
  generateForDir: ['test'],
)
Future<void> configureTestInjection() async {
  TestDI.getIt.initTest(environment: Environment.test);
}

class TestDI {
  static final GetIt getIt = GetIt.instance;
}

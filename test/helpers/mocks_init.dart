// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../di/test_di.dart';

class InitMocks {
  static void initMocks() {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      await TestDI.getIt.reset();

      await configureTestInjection();
    });

    tearDown(TestDI.getIt.reset);
  }
}

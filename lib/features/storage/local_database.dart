import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:invia_case_study/features/storage/hive_models/user.dart';

class LocalDatabase {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
  }

  static Future<void> dispose() async {
    await Hive.close();
  }
}

// Constructs the production database
LocalDatabase constructProdDb() {
  LocalDatabase.init(); // Initializes Hive for production (persistent storage)
  return LocalDatabase();
}

// Constructs the test database (non-persistent, in-memory storage)
LocalDatabase constructTestDb() {
  LocalDatabase.init(); // Initializes Hive for test
  Hive.init(null); // Uses in-memory storage instead of persistent files
  return LocalDatabase();
}

// Dispose function for dependency injection
FutureOr<dynamic> disposeDatabase(LocalDatabase instance) async {
  await LocalDatabase.dispose(); // Closes and cleans up the Hive instance
}

import 'package:flutter/material.dart';
import 'package:invia_case_study/features/router/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  /// create an instance of `AppRouter`
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // hook up router to MaterialApp
      routerConfig: _appRouter.config(),
    );
  }
}

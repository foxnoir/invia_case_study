import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:invia_case_study/core/di/di.dart';
import 'package:invia_case_study/core/log/logger.dart';
import 'package:invia_case_study/core/theme/theme.dart';
import 'package:invia_case_study/features/router/app_router.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _loadApp();
  }, (Object error, StackTrace stack) {
    logger.f('zone error $error', error, stack);
  });
}

Future<void> _loadApp() async {
  await DI.getIt.reset();
  await configureInjection(Environment.dev);

  try {
    runApp(InviaApp());
  } catch (ex, st) {
    logger.e('startup exception', ex, st);
  }
}

class InviaApp extends StatelessWidget {
  factory InviaApp() => instance;
  const InviaApp._internal();

  static const InviaApp instance = InviaApp._internal();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: appRouter.defaultRouteParser(),
      routerDelegate: appRouter.delegate(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: getLightTheme(),
    );
  }
}

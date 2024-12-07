// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:juwelo/features/settings/data/settings_repository.dart';

// import '../../di/test_di.dart';

// class TestableWidget extends StatelessWidget {
//   final Widget child;
//   const TestableWidget({
//     required this.child,
//     super.key,
//   });
//   @override
//   Widget build(BuildContext context) {
//     final SettingsRepository settingsRepository =
//         TestDI.getIt<SettingsRepository>();
//     return MediaQuery(
//       data: const MediaQueryData(),
//       child: MaterialApp(
//         localizationsDelegates: AppLocalizations.localizationsDelegates,
//         supportedLocales: AppLocalizations.supportedLocales,
//         locale: settingsRepository.locale,
//         home: Material(child: child),
//       ),
//     );
//   }
// }

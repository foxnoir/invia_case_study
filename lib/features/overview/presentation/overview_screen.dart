import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';

@RoutePage()
class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.overview ?? FallBackString.overview,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Image.network('https://picsum.photos/200/300'),
        ],
      ),
    );
  }
}

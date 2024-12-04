import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class HotelsScreen extends StatelessWidget {
  const HotelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.hotels ?? ''),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Image.network('https://picsum.photos/200/300'),
        ],
      ),
    );
  }
}

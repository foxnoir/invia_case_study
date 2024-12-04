import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.favorites ?? ''),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          ListTile(
            title: const Text('Setting 1'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Setting 2'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Setting 3'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

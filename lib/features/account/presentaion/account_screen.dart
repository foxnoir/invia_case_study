import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
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

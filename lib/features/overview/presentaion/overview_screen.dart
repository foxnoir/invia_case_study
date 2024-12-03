import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overview'),
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

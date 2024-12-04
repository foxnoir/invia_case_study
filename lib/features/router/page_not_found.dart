import 'package:flutter/material.dart';
import 'package:invia_case_study/core/theme/theme_helpers.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({
    super.key,
    this.isTesting = false,
  });
  final bool isTesting;

  static const ValueKey pageNotFoundKey = ValueKey('pageNotFoundKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: getHeight(context) / 6),
        child: Container(),
      ),
    );
  }
}

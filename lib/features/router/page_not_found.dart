import 'package:flutter/material.dart';
import 'package:invia_case_study/core/theme/theme_helpers.dart';

class PageNotFound extends StatelessWidget {
  PageNotFound({
    this.isTesting = false,
  }) : super();
  final bool isTesting;

  static const ValueKey pageNotFoundKey = ValueKey('pageNotFoundKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: getHeight(context) / 6),
        child: Container(),
      ),
    );
  }
}

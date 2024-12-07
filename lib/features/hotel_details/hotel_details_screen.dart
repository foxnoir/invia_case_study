// ignore_for_file: public_member_api_docs, use_key_in_widget_constructors

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';

@RoutePage()
class HotelDetailsScreen extends StatelessWidget {
  const HotelDetailsScreen({
    @PathParam('hotelId') required this.hotelId,
  });

  final String hotelId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.details ?? FallBackString.details,
        ),
      ),
      body: Center(
        child: Text('Welcome to Hotel $hotelId'),
      ),
    );
  }
}

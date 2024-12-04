import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:invia_case_study/core/di/di.dart';
import 'package:invia_case_study/features/hotels/data/repositories/hotel_repo_implementation.dart';
import 'package:invia_case_study/features/hotels/domain/repositories/hotel_repository.dart';

@RoutePage()
class HotelsScreen extends StatelessWidget {
  const HotelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HotelRepoImplementation hotelRepository =
        DI.getIt<HotelRepoImplementation>();

    // Hole die Hotels und drucke sie in der Konsole
    hotelRepository.getHotels().then((result) {
      result.fold(
        (failure) => print('Error: ${failure.message}'),
        (hotels) => print(hotels.first.runtimeType),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.hotels ?? 'Hotels'),
      ),
      body: Center(
        child: Text('Check the console for hotel data'),
      ),
    );
  }
}

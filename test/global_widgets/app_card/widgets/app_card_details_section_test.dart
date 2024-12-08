import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/global_widgets/app_card/widgets/app_card_details_section.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  late Hotel _hotel;

  setUp(() {
    _hotel = const Hotel.empty().copyWith(
      id: '1',
      name: 'Test Hotel',
      destination: 'Berlin, Germany',
      hotelId: 'hotel_1',
      bestOffer: const BestOffer(
        total: 99999,
        simplePricePerPerson: 49999,
        travelDate: TravelDate(days: 5, nights: 4),
        flightIncluded: true,
        overallRoomDetails: RoomDetails(
          name: 'Standard Room',
          boarding: 'Bed & Breakfast',
          adultCount: 2,
          childrenCount: 1,
        ),
        roomGroups: [
          RoomGroup(
            name: 'Deluxe Room',
            boarding: 'Half Board',
          ),
        ],
      ),
    );

    HttpOverrides.global = TestHttpOverrides();
  });

  tearDown(() {
    HttpOverrides.global = null;
  });

  Widget createAppCardDetailsSectionTestWidget({bool isFavoriteTab = false}) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('de'),
      ],
      locale: const Locale('de'),
      home: Scaffold(
        body: AppCardDetailsSection(
          hotel: _hotel,
          isFavoriteTab: isFavoriteTab,
        ),
      ),
    );
  }

  group('AppCardDetailsSection Tests', () {
    testWidgets('renders hotel name, destination, and star rating',
        (tester) async {
      await tester.pumpWidget(createAppCardDetailsSectionTestWidget());

      expect(find.text('Test Hotel'), findsOneWidget);
      expect(find.text('Berlin, Germany'), findsOneWidget);
      expect(find.byType(AppCardDetailsSection), findsOneWidget);
    });

    testWidgets('renders travel date, nights, and room details',
        (tester) async {
      await tester.pumpWidget(createAppCardDetailsSectionTestWidget());

      expect(find.textContaining('5 Tage'), findsOneWidget);
      expect(find.textContaining('4 Nächte'), findsOneWidget);
      expect(find.textContaining('Deluxe Room'), findsOneWidget);
      expect(find.textContaining('Half Board'), findsOneWidget);
    });

    testWidgets('renders traveler information and flight details',
        (tester) async {
      await tester.pumpWidget(createAppCardDetailsSectionTestWidget());

      expect(find.textContaining('2'), findsOneWidget);
      expect(find.textContaining('1'), findsOneWidget);
      expect(find.textContaining('inkl. Flug'), findsOneWidget);
    });

    testWidgets('does not render room details if roomGroups is empty',
        (tester) async {
      _hotel = _hotel.copyWith(
        bestOffer: const BestOffer(
          total: 99999,
          simplePricePerPerson: 49999,
          travelDate: TravelDate(days: 5, nights: 4),
          flightIncluded: true,
          overallRoomDetails: RoomDetails(
            name: 'Standard Room',
            boarding: 'Bed & Breakfast',
            adultCount: 2,
            childrenCount: 1,
          ),
          roomGroups: [],
        ),
      );

      await tester.pumpWidget(createAppCardDetailsSectionTestWidget());

      // Deluxe Room and Boarding should not be present
      expect(find.textContaining('Deluxe Room'), findsNothing);
      expect(find.textContaining('Half Board'), findsNothing);
    });

    testWidgets('renders Divider between sections', (tester) async {
      await tester.pumpWidget(createAppCardDetailsSectionTestWidget());

      final dividerFinder = find.byType(Divider);
      expect(dividerFinder, findsOneWidget);
    });

    testWidgets('does not render additional information if in favorite tab',
        (tester) async {
      await tester.pumpWidget(createAppCardDetailsSectionTestWidget(
        isFavoriteTab: true,
      ));

      expect(find.textContaining('5 Tage'), findsNothing);
      expect(find.textContaining('4 Nächte'), findsNothing);
      expect(find.textContaining('Deluxe Room'), findsNothing);
      expect(find.textContaining('Half Board'), findsNothing);
      expect(find.textContaining('2 Erwachsene'), findsNothing);
      expect(find.textContaining('1 Kind'), findsNothing);
      expect(find.textContaining('inklusive Flug'), findsNothing);
    });
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/features/network/errors/failure.dart';
import 'package:invia_case_study/global_widgets/app_banner.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/app_scaffold.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_bloc.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_state.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/widgets/app_sliver_fill.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';
import 'package:mocktail/mocktail.dart';

class MockAppScaffoldBloc extends MockBloc<AppScaffoldEvent, AppScaffoldState>
    implements AppScaffoldBloc {}

void main() {
  late MockAppScaffoldBloc mockAppScaffoldBloc;

  setUp(() {
    mockAppScaffoldBloc = MockAppScaffoldBloc();
    when(() => mockAppScaffoldBloc.state)
        .thenReturn(const AppScaffoldInitial());
  });

  tearDown(() {
    mockAppScaffoldBloc.close();
  });

  const testTitle = 'Test Title';
  const testErrorMessage = 'Something went wrong';
  const testButtonText = 'Try Again';

  final hotelList = <Hotel>[
    const Hotel.empty().copyWith(
      id: '1',
      name: 'Hotel 1',
      hotelId: 'hotel_1',
    ),
    const Hotel.empty().copyWith(
      id: '2',
      name: 'Hotel 2',
      hotelId: 'hotel_2',
    ),
  ];

  group('AppScaffold', () {
    testWidgets('should show loading indicator when isLoading is true',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AppScaffoldBloc>(
            create: (_) => mockAppScaffoldBloc,
            child: AppScaffold(
              title: testTitle,
              isLoading: true,
              isLoaded: false,
              hasError: false,
              hotelList: hotelList,
              errorMessage: '',
              onRefresh: () async {},
              buttonText: testButtonText,
              isFavoriteTab: false,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show error message when hasError is true',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AppScaffoldBloc>(
            create: (_) => mockAppScaffoldBloc,
            child: AppScaffold(
              title: testTitle,
              isLoading: false,
              isLoaded: false,
              hasError: true,
              hotelList: hotelList,
              errorMessage: testErrorMessage,
              onRefresh: () async {},
              buttonText: testButtonText,
              isFavoriteTab: false,
            ),
          ),
        ),
      );

      expect(find.text(testErrorMessage), findsOneWidget);
      expect(find.byType(AppSliverFill), findsOneWidget);
    });

    testWidgets('should show empty state when hotelList is empty',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AppScaffoldBloc>(
            create: (_) => mockAppScaffoldBloc,
            child: AppScaffold(
              title: testTitle,
              isLoading: false,
              isLoaded: true,
              hasError: false,
              hotelList: const [],
              errorMessage: '',
              onRefresh: () async {},
              buttonText: testButtonText,
              isFavoriteTab: true,
            ),
          ),
        ),
      );

      expect(find.byType(AppSliverFill), findsOneWidget);
      expect(find.text(FallBackString.noFavorites), findsOneWidget);
    });

    testWidgets('should show AppBanner when state is AppScaffoldError',
        (tester) async {
      when(() => mockAppScaffoldBloc.state).thenReturn(
        const AppScaffoldError(
          failure: ApiFailure(message: 'Error occurred', statusCode: 400),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AppScaffoldBloc>(
            create: (_) => mockAppScaffoldBloc,
            child: AppScaffold(
              title: testTitle,
              isLoading: false,
              isLoaded: false,
              hasError: false,
              hotelList: hotelList,
              errorMessage: testErrorMessage,
              onRefresh: () async {},
              buttonText: testButtonText,
              isFavoriteTab: false,
            ),
          ),
        ),
      );

      expect(find.byType(AppBanner), findsOneWidget);
    });
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invia_case_study/core/theme/consts.dart';
import 'package:invia_case_study/features/account/presentation/account_screen.dart';
import 'package:invia_case_study/features/account/presentation/bloc/account_bloc.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';
import 'package:mocktail/mocktail.dart';

class MockAccountBloc extends MockBloc<AccountEvent, AccountState>
    implements AccountBloc {}

void main() {
  late MockAccountBloc _mockAccountBloc;

  setUp(() {
    _mockAccountBloc = MockAccountBloc();
    when(() => _mockAccountBloc.state).thenReturn(
      const AccountState(locale: Locale('de')),
    );
  });

  tearDown(() {
    _mockAccountBloc.close();
  });

  group('AccountScreen', () {
    testWidgets('should display elements correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AccountBloc>(
            create: (_) => _mockAccountBloc,
            child: const AccountScreen(),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text(FallBackString.account), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.text('Fox Noir'), findsOneWidget);
      expect(find.text(FallBackString.editAccount), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should change locale when flag is tapped', (tester) async {
      _mockAccountBloc = MockAccountBloc();

      when(() => _mockAccountBloc.stream).thenAnswer(
        (_) => Stream.fromIterable([
          const AccountState(locale: Locale('en')),
          const AccountState(locale: Locale('de')),
        ]),
      );

      when(() => _mockAccountBloc.state)
          .thenReturn(const AccountState(locale: Locale('en')));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AccountBloc>(
            create: (_) => _mockAccountBloc,
            child: const AccountScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byKey(const ValueKey('en_flag')));

      await tester.tap(find.byKey(const ValueKey('en_flag')));
      await tester.pumpAndSettle();

      verify(() => _mockAccountBloc.add(const ChangeLocaleEvent(Locale('de'))))
          .called(1);
    });

    testWidgets('should display Englosh flag when locale is German',
        (tester) async {
      when(() => _mockAccountBloc.state).thenReturn(
        const AccountState(locale: Locale('de')),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AccountBloc>(
            create: (_) => _mockAccountBloc,
            child: const AccountScreen(),
          ),
        ),
      );

      expect(find.image(const AssetImage(AppImg.en_flag)), findsOneWidget);
      expect(find.image(const AssetImage(AppImg.de_flag)), findsNothing);
    });

    testWidgets('should display German flag when locale is English',
        (tester) async {
      when(() => _mockAccountBloc.state).thenReturn(
        const AccountState(locale: Locale('en')),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AccountBloc>(
            create: (_) => _mockAccountBloc,
            child: const AccountScreen(),
          ),
        ),
      );

      expect(find.image(const AssetImage(AppImg.de_flag)), findsOneWidget);
      expect(find.image(const AssetImage(AppImg.en_flag)), findsNothing);
    });

    testWidgets(
        'should display user info (name, profile picture) '
        'and edit account button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AccountBloc>(
            create: (_) => _mockAccountBloc,
            child: const AccountScreen(),
          ),
        ),
      );

      expect(find.text('Fox Noir'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.text(FallBackString.editAccount), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should trigger tap on the edit account button',
        (tester) async {
      var isTapped = false;
      when(() => _mockAccountBloc.state).thenReturn(
        const AccountState(locale: Locale('en')),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AccountBloc>(
            create: (_) => _mockAccountBloc,
            child: const AccountScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text(FallBackString.editAccount), findsOneWidget);

      isTapped = true;
      expect(isTapped, true);
    });
  });
}

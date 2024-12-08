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
  late MockAccountBloc mockAccountBloc;

  setUp(() {
    mockAccountBloc = MockAccountBloc();
    when(() => mockAccountBloc.state).thenReturn(
      const AccountState(locale: Locale('de')),
    );
  });

  tearDown(() {
    mockAccountBloc.close();
  });

  group('AccountScreen', () {
    testWidgets('should display the [AccountScreen] elements correctly',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AccountBloc>(
            create: (_) => mockAccountBloc,
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
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AccountBloc>(
            create: (_) => mockAccountBloc,
            child: const AccountScreen(),
          ),
        ),
      );

      expect(find.image(const AssetImage(AppImg.en_flag)), findsNothing);
      expect(find.image(const AssetImage(AppImg.de_flag)), findsOneWidget);

      await tester.tap(find.byType(GestureDetector));
      await tester.pump();

      verify(() => mockAccountBloc.add(const ChangeLocaleEvent(Locale('en'))))
          .called(1);
    });

    testWidgets('should display  German flag when locale is English',
        (tester) async {
      when(() => mockAccountBloc.state).thenReturn(
        const AccountState(locale: Locale('de')),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AccountBloc>(
            create: (_) => mockAccountBloc,
            child: const AccountScreen(),
          ),
        ),
      );

      expect(find.image(const AssetImage(AppImg.en_flag)), findsOneWidget);
      expect(find.image(const AssetImage(AppImg.de_flag)), findsNothing);
    });

    testWidgets('should display  English flag when locale is German',
        (tester) async {
      when(() => mockAccountBloc.state).thenReturn(
        const AccountState(locale: Locale('en')),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AccountBloc>(
            create: (_) => mockAccountBloc,
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
            create: (_) => mockAccountBloc,
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
      when(() => mockAccountBloc.state).thenReturn(
        const AccountState(locale: Locale('en')),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AccountBloc>(
            create: (_) => mockAccountBloc,
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

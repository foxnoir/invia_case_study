import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invia_case_study/features/account/presentation/bloc/account_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences _mockSharedPreferences;
  late AccountBloc _accountBloc;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
  });

  setUp(() async {
    _mockSharedPreferences = await SharedPreferences.getInstance();
    _accountBloc = AccountBloc(sharedPreferences: _mockSharedPreferences);
  });

  tearDown(() async {
    await _accountBloc.close();
  });

  group('AccountBloc', () {
    const initialLocale = Locale('de');
    const newLocale = Locale('en');

    test('initial state is AccountState with default locale', () {
      expect(_accountBloc.state, const AccountState(locale: initialLocale));
    });

    blocTest<AccountBloc, AccountState>(
      'emits [AccountState] with updated locale '
      'when ChangeLocaleEvent is added',
      build: () => _accountBloc,
      act: (bloc) => bloc.add(const ChangeLocaleEvent(newLocale)),
      expect: () => [
        const AccountState(locale: newLocale),
      ],
      verify: (_) async {
        final storedLocale = _mockSharedPreferences.getString('LOCALE');
        expect(storedLocale, 'en');
      },
    );

    blocTest<AccountBloc, AccountState>(
      'correctly loads the initial locale from SharedPreferences',
      setUp: () async {
        SharedPreferences.setMockInitialValues({'LOCALE': 'fr'});
        _mockSharedPreferences = await SharedPreferences.getInstance();
      },
      build: () => AccountBloc(sharedPreferences: _mockSharedPreferences),
      verify: (bloc) {
        expect(bloc.state, const AccountState(locale: Locale('fr')));
      },
    );
  });
}
